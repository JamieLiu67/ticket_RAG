# Commit Message Detection Enhancement Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在 sync.sh 脚本中增加对工单和 CS_KI 文件的新增、删除、修改检测，生成详细的 commit message

**Architecture:** 通过对比 git HEAD 版本与当前工作区版本的 ID 集合差异，检测新增/删除；通过条目内容哈希对比检测修改；使用 comm 命令高效计算集合差集

**Tech Stack:** Bash, git, standard Unix tools (grep, awk, sort, comm, md5sum)

---

## Prerequisites

- Bash >= 4.0 (支持 process substitution)
- git
- 标准 Unix 工具链

## File Structure

```
ticket_RAG/
├── sync.sh                          # 主脚本（本次修改目标）
├── 工单训练 RAG 集.md               # 工单文件
├── CS_KI_RAG优化版.md               # CS_KI 文件
└── .opencode/plans/                 # 本计划文档
```

---

## Task 1: 创建 ID 提取函数

**Files:**
- Modify: `sync.sh:52-68` (在现有函数之前添加新函数)

**Step 1: 添加工单文件 ID 提取函数**

在 `generate_ticket_message` 函数之前添加：

```bash
# ============ ID 提取函数 ============

# 提取工单文件中的所有 ID
extract_ids_ticket() {
    local file="$1"
    grep "^# ID:" "$file" 2>/dev/null | awk '{print $3}' | sort -n
}

# 提取 CS_KI 文件中的所有 ID（去掉前导零）
extract_ids_cski() {
    local file="$1"
    grep "^# CS_KI_" "$file" 2>/dev/null | sed 's/# CS_KI_//' | awk '{print $1}' | sort -n
}
```

**Step 2: 验证函数语法**

Run: `bash -n sync.sh`
Expected: No output (syntax OK)

**Step 3: 测试 ID 提取**

Run: 
```bash
grep -A2 "extract_ids_ticket" sync.sh | head -4
bash -c 'source sync.sh 2>/dev/null; extract_ids_ticket "工单训练 RAG 集.md" | head -5'
```

Expected: 输出前 5 个工单 ID (如: 10, 39194, 39201...)

**Step 4: Commit**

```bash
git add sync.sh
git commit -m "feat: add ID extraction functions for ticket and CSKI files"
```

---

## Task 2: 创建条目内容提取与哈希函数

**Files:**
- Modify: `sync.sh` (在 ID 提取函数后添加)

**Step 1: 添加工单条目提取函数**

```bash
# 提取工单条目的完整内容（从 # ID: xxx 到下一个 --- 之前）
extract_ticket_entry() {
    local content="$1"
    local id="$2"
    
    echo "$content" | awk -v id="$id" '
        BEGIN { capturing = 0; entry = "" }
        /^# ID: / { 
            if (capturing) { 
                capturing = 0 
            }
            if ($3 == id) { 
                capturing = 1 
            }
        }
        capturing { 
            entry = entry $0 "\n" 
        }
        END { 
            if (capturing) {
                # Remove trailing --- and newlines
                gsub(/---\s*$/, "", entry)
                print entry
            }
        }
    '
}

# 提取 CS_KI 条目的完整内容（从 # CS_KI_xxx 到下一个 --- 之前）
extract_cski_entry() {
    local content="$1"
    local id="$2"
    
    printf -v padded_id "%04d" "$id"
    
    echo "$content" | awk -v id="$padded_id" '
        BEGIN { capturing = 0; entry = "" }
        /^# CS_KI_/ { 
            if (capturing) { 
                capturing = 0 
            }
            if (substr($0, 10, 4) == id) { 
                capturing = 1 
            }
        }
        capturing { 
            entry = entry $0 "\n" 
        }
        END { 
            if (capturing) {
                gsub(/---\s*$/, "", entry)
                print entry
            }
        }
    '
}
```

**Step 2: 添加哈希计算函数**

```bash
# 计算字符串的 MD5 哈希（跨平台兼容）
compute_hash() {
    local content="$1"
    if command -v md5sum >/dev/null 2>&1; then
        echo "$content" | md5sum | awk '{print $1}'
    else
        echo "$content" | md5 | awk '{print $1}'
    fi
}
```

**Step 3: 验证语法**

Run: `bash -n sync.sh`
Expected: No output

**Step 4: Commit**

```bash
git add sync.sh
git commit -m "feat: add entry extraction and hash computation functions"
```

---

## Task 3: 实现新增/删除检测逻辑

**Files:**
- Modify: `sync.sh` (在哈希函数后添加)

**Step 1: 添加变动检测主函数**

```bash
# ============ 变动检测函数 ============

# 检测文件的变动（新增/删除/修改）
# 返回格式: ADDED: id1,id2|DELETED: id3,id4|MODIFIED: id5,id6
detect_changes() {
    local file="$1"
    local file_type="$2"  # "ticket" or "cski"
    
    # 获取当前文件内容
    local current_content
    current_content=$(cat "$file" 2>/dev/null)
    
    # 获取上次提交的文件内容
    local last_content
    last_content=$(git show HEAD:"$file" 2>/dev/null)
    
    # 如果上次没有提交（首次提交），所有内容都是新增
    if [ -z "$last_content" ]; then
        if [ "$file_type" == "ticket" ]; then
            local all_ids
            all_ids=$(extract_ids_ticket "$file")
            echo "ADDED:$all_ids|DELETED:|MODIFIED:"
        else
            local all_ids
            all_ids=$(extract_ids_cski "$file")
            echo "ADDED:$all_ids|DELETED:|MODIFIED:"
        fi
        return
    fi
    
    # 提取 ID 列表
    local current_ids last_ids
    if [ "$file_type" == "ticket" ]; then
        current_ids=$(echo "$current_content" | grep "^# ID:" | awk '{print $3}' | sort -n)
        last_ids=$(echo "$last_content" | grep "^# ID:" | awk '{print $3}' | sort -n)
    else
        current_ids=$(echo "$current_content" | grep "^# CS_KI_" | sed 's/# CS_KI_//' | awk '{print $1}' | sort -n)
        last_ids=$(echo "$last_content" | grep "^# CS_KI_" | sed 's/# CS_KI_//' | awk '{print $1}' | sort -n)
    fi
    
    # 计算新增（在 current 中但不在 last 中）
    local added_ids
    added_ids=$(comm -23 <(echo "$current_ids") <(echo "$last_ids"))
    
    # 计算删除（在 last 中但不在 current 中）
    local deleted_ids
    deleted_ids=$(comm -13 <(echo "$current_ids") <(echo "$last_ids"))
    
    # 计算可能修改的 ID（交集）
    local common_ids
    common_ids=$(comm -12 <(echo "$current_ids") <(echo "$last_ids"))
    
    # 检测修改
    local modified_ids=""
    for id in $common_ids; do
        local last_entry current_entry last_hash current_hash
        
        if [ "$file_type" == "ticket" ]; then
            last_entry=$(extract_ticket_entry "$last_content" "$id")
            current_entry=$(extract_ticket_entry "$current_content" "$id")
        else
            last_entry=$(extract_cski_entry "$last_content" "$id")
            current_entry=$(extract_cski_entry "$current_content" "$id")
        fi
        
        # 计算哈希并比较
        last_hash=$(compute_hash "$last_entry")
        current_hash=$(compute_hash "$current_entry")
        
        if [ "$last_hash" != "$current_hash" ]; then
            modified_ids="${modified_ids}${id},"
        fi
    done
    
    # 去掉末尾的逗号
    modified_ids=${modified_ids%,}
    
    # 格式化输出
    added_ids=$(echo "$added_ids" | tr '\n' ',' | sed 's/,$//')
    deleted_ids=$(echo "$deleted_ids" | tr '\n' ',' | sed 's/,$//')
    
    echo "ADDED:$added_ids|DELETED:$deleted_ids|MODIFIED:$modified_ids"
}
```

**Step 2: 测试变动检测**

首先创建一个临时测试：

```bash
# 测试函数是否可调用
bash -c '
source sync.sh 2>/dev/null
result=$(detect_changes "工单训练 RAG 集.md" "ticket")
echo "Detect changes result: $result"
'
```

Expected: 如果没有变动，返回 `ADDED:|DELETED:|MODIFIED:`

**Step 3: Commit**

```bash
git add sync.sh
git commit -m "feat: implement change detection (add/delete/modify)"
```

---

## Task 4: 实现 ID 格式化函数

**Files:**
- Modify: `sync.sh` (在 detect_changes 函数后添加)

**Step 1: 添加 ID 列表格式化函数**

```bash
# ============ ID 格式化函数 ============

# 将 ID 列表压缩为范围表示（连续 ID 合并）
# 输入: "1 2 3 5 7 8 9"  输出: "1-3, 5, 7-9"
compress_id_range() {
    local ids="$1"
    ids=$(echo "$ids" | tr ',' '\n' | sort -n | uniq)
    
    local result=""
    local start=""
    local prev=""
    
    for id in $ids; do
        id=$(echo "$id" | tr -d ' ')
        if [ -z "$start" ]; then
            start=$id
            prev=$id
        elif [ $((prev + 1)) -eq "$id" ]; then
            prev=$id
        else
            if [ "$start" -eq "$prev" ]; then
                result="${result}${start}, "
            else
                result="${result}${start}-${prev}, "
            fi
            start=$id
            prev=$id
        fi
    done
    
    # 处理最后一组
    if [ -n "$start" ]; then
        if [ "$start" -eq "$prev" ]; then
            result="${result}${start}"
        else
            result="${result}${start}-${prev}"
        fi
    fi
    
    echo "$result"
}

# 格式化 ID 列表为逗号分隔字符串（不压缩）
format_id_list() {
    local ids="$1"
    echo "$ids" | tr ',' '\n' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g'
}
```

**Step 2: 测试压缩函数**

Run:
```bash
bash -c '
source sync.sh 2>/dev/null
compress_id_range "10,11,12,15,20,21,22"
'
```

Expected: `10-12, 15, 20-22`

**Step 3: Commit**

```bash
git add sync.sh
git commit -m "feat: add ID range compression and formatting functions"
```

---

## Task 5: 重构 generate_ticket_message 函数

**Files:**
- Modify: `sync.sh:52-68` (替换现有函数)

**Step 1: 重写工单 commit message 生成函数**

将原有的 `generate_ticket_message` 函数替换为：

```bash
# ============ 生成工单文件的 commit message 部分 ============
generate_ticket_message() {
    # 获取变动检测结果
    local changes
    changes=$(detect_changes "$TICKET_FILE" "ticket")
    
    # 解析变动
    local added_ids deleted_ids modified_ids
    added_ids=$(echo "$changes" | grep -o 'ADDED:[^|]*' | cut -d: -f2)
    deleted_ids=$(echo "$changes" | grep -o 'DELETED:[^|]*' | cut -d: -f2)
    modified_ids=$(echo "$changes" | grep -o 'MODIFIED:[^|]*' | cut -d: -f2)
    
    # 构建 message 部分
    local parts=()
    
    # 如果有新增，添加时间段信息
    if [ -n "$added_ids" ]; then
        local LAST_COMMIT_MSG LAST_DATES LAST_END_DATE
        LAST_COMMIT_MSG=$(git log -1 --format="%s")
        LAST_DATES=$(echo "$LAST_COMMIT_MSG" | grep -oE '[0-9]{4}\.[0-9]{1,2}\.[0-9]{1,2}')
        
        if [ -n "$LAST_DATES" ]; then
            LAST_END_DATE=$(echo "$LAST_DATES" | tail -1)
            parts+=("新增 ${LAST_END_DATE} 19:00 到 ${TODAY} 19:00 的工单对答记录")
        else
            local YESTERDAY
            if [[ "$OSTYPE" == "darwin"* ]]; then
                YESTERDAY=$(date -v-1d +%Y.%-m.%-d 2>/dev/null || echo "$TODAY")
            else
                YESTERDAY=$(date -d "yesterday" +%Y.%-m.%-d 2>/dev/null || echo "$TODAY")
            fi
            parts+=("新增 ${YESTERDAY} 19:00 到 ${TODAY} 19:00 的工单对答记录")
        fi
    fi
    
    # 如果有删除，列出 ID
    if [ -n "$deleted_ids" ]; then
        local formatted_deleted
        formatted_deleted=$(format_id_list "$deleted_ids")
        parts+=("删除工单 ID: ${formatted_deleted}")
    fi
    
    # 如果有修改，列出 ID
    if [ -n "$modified_ids" ]; then
        local formatted_modified
        formatted_modified=$(format_id_list "$modified_ids")
        parts+=("修改工单 ID: ${formatted_modified}")
    fi
    
    # 合并所有部分（用分号连接）
    if [ ${#parts[@]} -eq 0 ]; then
        echo "更新工单文件"
    else
        local IFS='；'
        echo "${parts[*]}"
    fi
}
```

**Step 2: 验证函数**

Run:
```bash
bash -c '
source sync.sh 2>/dev/null
generate_ticket_message
'
```

Expected: 如果没有变动，显示 "更新工单文件" 或时间段信息

**Step 3: Commit**

```bash
git add sync.sh
git commit -m "refactor: enhance ticket commit message with add/delete/modify detection"
```

---

## Task 6: 重构 generate_cski_message 函数

**Files:**
- Modify: `sync.sh:70-95` (替换现有函数)

**Step 1: 重写 CS_KI commit message 生成函数**

将原有的 `generate_cski_message` 函数替换为：

```bash
# ============ 生成 CS_KI 文件的 commit message 部分 ============
generate_cski_message() {
    # 获取变动检测结果
    local changes
    changes=$(detect_changes "$CSKI_FILE" "cski")
    
    # 解析变动
    local added_ids deleted_ids modified_ids
    added_ids=$(echo "$changes" | grep -o 'ADDED:[^|]*' | cut -d: -f2)
    deleted_ids=$(echo "$changes" | grep -o 'DELETED:[^|]*' | cut -d: -f2)
    modified_ids=$(echo "$changes" | grep -o 'MODIFIED:[^|]*' | cut -d: -f2)
    
    # 构建 message 部分
    local parts=()
    
    # 如果有新增，使用范围格式
    if [ -n "$added_ids" ]; then
        local formatted_added
        formatted_added=$(compress_id_range "$added_ids")
        parts+=("新增 CSKI ${formatted_added}")
    fi
    
    # 如果有删除，列出 ID
    if [ -n "$deleted_ids" ]; then
        local formatted_deleted
        formatted_deleted=$(format_id_list "$deleted_ids")
        parts+=("删除 CSKI ${formatted_deleted}")
    fi
    
    # 如果有修改，列出 ID
    if [ -n "$modified_ids" ]; then
        local formatted_modified
        formatted_modified=$(format_id_list "$modified_ids")
        parts+=("修改 CSKI ${formatted_modified}")
    fi
    
    # 合并所有部分
    if [ ${#parts[@]} -eq 0 ]; then
        echo "更新 CSKI 文件"
    else
        local IFS='；'
        echo "${parts[*]}"
    fi
}
```

**Step 2: 验证函数**

Run:
```bash
bash -c '
source sync.sh 2>/dev/null
generate_cski_message
'
```

Expected: 如果没有变动，显示 "更新 CSKI 文件"

**Step 3: Commit**

```bash
git add sync.sh
git commit -m "refactor: enhance CSKI commit message with add/delete/modify detection"
```

---

## Task 7: 添加边界情况处理

**Files:**
- Modify: `sync.sh` (在 detect_changes 函数中增强)

**Step 1: 增强 detect_changes 函数的错误处理**

更新 `detect_changes` 函数开头部分：

```bash
detect_changes() {
    local file="$1"
    local file_type="$2"
    
    # 检查文件是否存在
    if [ ! -f "$file" ]; then
        echo "ADDED:|DELETED:|MODIFIED:"
        return
    fi
    
    # 检查是否是 git 仓库
    if ! git rev-parse --git-dir >/dev/null 2>&1; then
        echo "ADDED:|DELETED:|MODIFIED:"
        return
    fi
    
    # 获取当前文件内容
    local current_content
    current_content=$(cat "$file" 2>/dev/null)
    
    if [ -z "$current_content" ]; then
        echo "ADDED:|DELETED:|MODIFIED:"
        return
    fi
    
    # 获取上次提交的文件内容
    local last_content
    last_content=$(git show HEAD:"$file" 2>/dev/null || echo "")
    
    # 如果上次没有提交（首次提交或文件是新的）
    if [ -z "$last_content" ]; then
        if [ "$file_type" == "ticket" ]; then
            local all_ids
            all_ids=$(extract_ids_ticket "$file" | tr '\n' ',' | sed 's/,$//')
            echo "ADDED:$all_ids|DELETED:|MODIFIED:"
        else
            local all_ids
            all_ids=$(extract_ids_cski "$file" | tr '\n' ',' | sed 's/,$//')
            echo "ADDED:$all_ids|DELETED:|MODIFIED:"
        fi
        return
    fi
    
    # ... 原有逻辑 ...
}
```

**Step 2: 添加大量变动保护**

在 generate_ticket_message 和 generate_cski_message 中添加阈值检查：

```bash
# 在函数开头添加
MAX_DISPLAY_IDS=10

# 在格式化 ID 前检查数量
count_ids() {
    echo "$1" | tr ',' '\n' | grep -v '^$' | wc -l
}

# 使用示例：
if [ -n "$deleted_ids" ]; then
    local deleted_count
    deleted_count=$(count_ids "$deleted_ids")
    
    if [ "$deleted_count" -gt "$MAX_DISPLAY_IDS" ]; then
        parts+=("删除 ${deleted_count} 条工单")
    else
        local formatted_deleted
        formatted_deleted=$(format_id_list "$deleted_ids")
        parts+=("删除工单 ID: ${formatted_deleted}")
    fi
fi
```

**Step 3: Commit**

```bash
git add sync.sh
git commit -m "feat: add error handling and large change protection"
```

---

## Task 8: 集成测试

**Files:**
- No file changes (仅测试)

**Step 1: 创建测试场景**

创建一个临时测试脚本来验证功能：

```bash
# 创建测试目录
mkdir -p /tmp/sync_test
cd /tmp/sync_test

# 初始化 git
git init
git config user.email "test@test.com"
git config user.name "Test"

# 创建模拟工单文件
cat > ticket.md << 'EOF'
# ID: 10
SDK: Test
Reply: Reply 10
---
EOF

git add ticket.md
git commit -m "Initial commit"

# 修改文件（添加、删除、修改）
cat > ticket.md << 'EOF'
# ID: 10
SDK: Test Modified
Reply: Reply 10 modified
---
# ID: 11
SDK: Test2
Reply: Reply 11
---
EOF

# 运行检测
source /path/to/sync.sh
detect_changes ticket.md ticket
```

**Step 2: 验证输出**

Expected:
- ADDED: 11
- MODIFIED: 10
- DELETED: (empty)

**Step 3: 清理测试文件**

```bash
cd /Users/liushiqin/ticket_RAG
rm -rf /tmp/sync_test
```

**Step 4: 最终提交**

```bash
git add sync.sh
git commit -m "chore: finalize sync.sh with comprehensive change detection"
```

---

## Task 9: 更新文档

**Files:**
- Modify: `AGENTS.md` (添加新功能说明)

**Step 1: 添加功能说明**

在 AGENTS.md 的 "Git Workflow" 部分后添加：

```markdown
### Commit Message 自动生成

sync.sh 脚本现在支持自动检测以下变动并生成相应的 commit message：

**工单文件 (工单训练 RAG 集.md)：**
- 新增：标记时间段（如：`新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录`）
- 删除：列出 ID（如：`删除工单 ID: 39194, 39195`）
- 修改：列出 ID（如：`修改工单 ID: 39188`）

**CS_KI 文件 (CS_KI_RAG优化版.md)：**
- 新增：标记 ID 范围（如：`新增 CSKI 0238-0240`）
- 删除：列出 ID（如：`删除 CSKI 0230, 0235`）
- 修改：列出 ID（如：`修改 CSKI 0228`）

**组合场景示例：**
```
新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录；删除工单 ID: 39194；修改工单 ID: 39188
```

**注意事项：**
- 删除或修改超过 10 个条目时，将只显示数量而非具体 ID
- 检测基于条目内容哈希，忽略格式变化（空格、换行）
```

**Step 2: Commit**

```bash
git add AGENTS.md
git commit -m "docs: update AGENTS.md with commit message auto-generation feature"
```

---

## Verification Checklist

在完成所有任务后，运行以下验证：

- [ ] `bash -n sync.sh` 无语法错误
- [ ] `./sync.sh` 能正确检测并显示变动
- [ ] 新增条目正确显示时间段/范围
- [ ] 删除条目正确列出 ID
- [ ] 修改条目正确列出 ID
- [ ] 组合场景正确使用分号连接
- [ ] 超过 10 个变动时正确显示数量
- [ ] 首次提交场景正确处理

---

## Notes

1. **性能考虑**: 对于大文件（数千条目），修改检测可能较慢。后续可考虑：
   - 增加缓存机制
   - 使用更高效的比较算法
   - 增加进度提示

2. **兼容性**: 脚本使用 Bash 4.0+ 特性（process substitution），确保运行环境支持

3. **扩展性**: 如需支持更多文件类型，只需：
   - 添加 extract_ids_* 函数
   - 添加 extract_*_entry 函数
   - 修改 detect_changes 中的类型判断
