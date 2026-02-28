# Commit Message 智能检测生成设计文档

**日期**: 2026-02-28  
**需求**: 在提交 RAG 知识库文件时，自动检测新增、删除、修改的条目，并生成相应的 commit message

---

## 1. 需求分析

### 1.1 文件类型

本项目包含两类知识库文件：

1. **工单训练 RAG 集.md** - 客服工单问答记录
2. **CS_KI_RAG优化版.md** - 已知问题数据库

### 1.2 Commit Message 格式要求

#### 工单文件格式规则：
- **新增**：标记时间段（不需列 ID）
  - 格式：`新增 YYYY.M.DD 19:00 到 YYYY.M.DD 19:00 的工单对答记录`
  - 示例：`新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录`
  
- **删除**：列出被删除的 ID 列表
  - 格式：`删除工单 ID: xxx, yyy, zzz`
  - 示例：`删除工单 ID: 39194, 39195`
  
- **修改**：列出被修改的 ID 列表
  - 格式：`修改工单 ID: xxx, yyy`
  - 示例：`修改工单 ID: 39188`

#### CS_KI 文件格式规则：
- **新增**：保持现有格式（标记 ID 范围）
  - 单个：`新增 CSKI 0238`
  - 多个：`新增 CSKI 0238-0240`
  
- **删除**：列出被删除的 ID 列表
  - 格式：`删除 CSKI xxx, yyy`
  - 示例：`删除 CSKI 0230, 0235`
  
- **修改**：列出被修改的 ID 列表
  - 格式：`修改 CSKI xxx, yyy`
  - 示例：`修改 CSKI 0228`

### 1.3 组合场景

当同时存在多种变动类型时，使用分号连接：
```
新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录；删除工单 ID: 39194；修改工单 ID: 39188
```

---

## 2. 技术设计

### 2.1 文件格式特征

#### 工单文件条目格式：
```markdown
# ID: {number}

SDK Product: {产品}
SDK Platform: {平台}
SDK Version: {版本}
Request Type: {类型}
Request Description: {描述}

Reply: {回复内容}

---
```

#### CS_KI 文件条目格式：
```markdown
# CS_KI_{ID}
问题ID:{ID}  
问题描述: {描述}  
影响范围: {范围}  
影响平台: {平台}  
修复方案及进展: {方案}

---
```

### 2.2 变动检测算法

#### 2.2.1 新增/删除检测

通过比较两次提交间的 ID 集合差异：

```bash
# 获取当前文件的 ID 列表
CURRENT_IDS=$(grep "^# ID:" "$FILE" | awk '{print $3}' | sort -n)

# 获取上次提交的 ID 列表  
LAST_IDS=$(git show HEAD:"$FILE" 2>/dev/null | grep "^# ID:" | awk '{print $3}' | sort -n)

# 计算新增（在 current 中但不在 last 中）
ADDED_IDS=$(comm -23 <(echo "$CURRENT_IDS") <(echo "$LAST_IDS"))

# 计算删除（在 last 中但不在 current 中）
DELETED_IDS=$(comm -13 <(echo "$CURRENT_IDS") <(echo "$LAST_IDS"))
```

#### 2.2.2 修改检测

通过对比条目的内容哈希值：

```bash
detect_modified_entries() {
    local file="$1"
    local last_content=$(git show HEAD:"$file" 2>/dev/null)
    local current_content=$(cat "$file")
    
    # 获取存在于两个版本中的 ID（交集）
    COMMON_IDS=$(comm -12 <(echo "$CURRENT_IDS") <(echo "$LAST_IDS"))
    
    # 对每个共同 ID，比较内容是否变化
    for id in $COMMON_IDS; do
        last_entry_hash=$(extract_entry_hash "$last_content" "$id")
        current_entry_hash=$(extract_entry_hash "$current_content" "$id")
        
        if [ "$last_entry_hash" != "$current_entry_hash" ]; then
            echo "$id"
        fi
    done
}
```

### 2.3 条目提取

#### 工单条目提取
```bash
extract_ticket_entry() {
    local content="$1"
    local id="$2"
    
    # 从 # ID: xxx 开始，到下一个 --- 之前
    echo "$content" | awk -v id="$id" '
        /^# ID: / { capture=0 }
        /^# ID: / && $3 == id { capture=1 }
        capture { print }
        /^---$/ && capture { capture=0 }
    '
}
```

#### CS_KI 条目提取
```bash
extract_cski_entry() {
    local content="$1"
    local id="$2"
    
    # 从 # CS_KI_xxx 开始，到下一个 --- 之前
    echo "$content" | awk -v id="$id" '
        /^# CS_KI_/ { capture=0 }
        /^# CS_KI_/ && substr($0, 10) == id { capture=1 }
        capture { print }
        /^---$/ && capture { capture=0 }
    '
}
```

### 2.4 ID 格式化

#### 连续 ID 压缩
```bash
format_id_range() {
    local ids=("$@")
    local result=""
    local start=""
    local prev=""
    
    for id in "${ids[@]}"; do
        if [ -z "$start" ]; then
            start=$id
            prev=$id
        elif [ $((prev + 1)) -eq $id ]; then
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
```

---

## 3. 模块设计

### 3.1 函数清单

#### 核心检测函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `extract_ids_ticket` | file_path | ID 列表 | 提取工单文件所有 ID |
| `extract_ids_cski` | file_path | ID 列表 | 提取 CSKI 文件所有 ID |
| `extract_entry_hash_ticket` | content, id | hash | 提取工单条目并计算哈希 |
| `extract_entry_hash_cski` | content, id | hash | 提取 CSKI 条目并计算哈希 |
| `detect_changes` | file_path, file_type | 变动信息 | 检测新增/删除/修改 |

#### 格式化函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `format_ticket_message` | added_ids, deleted_ids, modified_ids | message | 生成工单 commit msg |
| `format_cski_message` | added_ids, deleted_ids, modified_ids | message | 生成 CSKI commit msg |
| `compress_id_range` | id_list | 范围字符串 | 压缩连续 ID 为范围 |
| `format_id_list` | id_list | 字符串 | 格式化 ID 列表 |

#### 工具函数

| 函数名 | 参数 | 返回值 | 说明 |
|--------|------|--------|------|
| `get_last_commit_date` | - | 日期 | 获取上次提交日期 |
| `get_time_range` | last_date, today | 时间段 | 生成时间段字符串 |
| `parse_entry_content` | content, id, file_type | 条目内容 | 解析条目完整内容 |

### 3.2 主流程

```
开始
  │
  ▼
检测文件变更
  │
  ├─ 工单文件变更? ──► 检测变动 (新增/删除/修改)
  │                      │
  │                      ▼
  │                   生成工单 commit message
  │
  └─ CSKI 文件变更? ──► 检测变动 (新增/删除/修改)
                         │
                         ▼
                      生成 CSKI commit message
  │
  ▼
合并 commit messages
  │
  ▼
用户确认
  │
  ▼
提交并推送
```

---

## 4. 边界情况处理

### 4.1 首次提交
- **场景**：文件之前不存在于仓库
- **处理**：所有条目视为新增
- **实现**：`git show HEAD:"$file"` 返回空时，将当前文件所有 ID 标记为新增

### 4.2 大量变动
- **场景**：变动 ID 数量超过 10 个
- **处理**：
  - 新增：仍然显示时间段（工单）或 ID 范围（CSKI）
  - 删除/修改：如果 ID 过多，显示为"删除 X 条工单"而非列出所有 ID
- **阈值**：可配置，默认 10 个

### 4.3 格式错误
- **场景**：条目格式不符合预期（缺少 ID 行）
- **处理**：
  - 跳过无效条目
  - 输出警告信息
  - 继续处理其他有效条目

### 4.4 空变动
- **场景**：文件有变更但没有条目变动（如只修改了空行）
- **处理**：
  - 检测条目数量变化
  - 如果条目数未变但文件大小变化，标记为"格式调整"

---

## 5. 测试用例

### 5.1 新增场景

**输入**：
- 当前文件包含 ID: 10, 11, 12
- 上次提交包含 ID: 10

**预期输出**：
```
新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录
```

### 5.2 删除场景

**输入**：
- 当前文件包含 ID: 10, 12
- 上次提交包含 ID: 10, 11, 12

**预期输出**：
```
删除工单 ID: 11
```

### 5.3 修改场景

**输入**：
- 当前文件包含 ID: 10, 11（ID 11 的 Reply 内容已修改）
- 上次提交包含 ID: 10, 11

**预期输出**：
```
修改工单 ID: 11
```

### 5.4 组合场景

**输入**：
- 当前文件包含 ID: 10, 12, 13（新增 12、13，删除 11，修改 10）
- 上次提交包含 ID: 10, 11

**预期输出**：
```
新增 2026.2.27 19:00 到 2026.2.28 19:00 的工单对答记录；删除工单 ID: 11；修改工单 ID: 10
```

### 5.5 CSKI 新增范围

**输入**：
- 当前文件包含 CS_KI: 0238, 0239, 0240
- 上次提交包含 CS_KI: 0238

**预期输出**：
```
新增 CSKI 0239-0240
```

---

## 6. 实现计划

### Phase 1: 基础框架 (Day 1)
- [ ] 创建检测函数 extract_ids_*
- [ ] 实现新增/删除检测逻辑
- [ ] 修改现有 generate_ticket_message 函数

### Phase 2: 修改检测 (Day 1-2)
- [ ] 实现条目内容提取函数
- [ ] 实现修改检测算法
- [ ] 添加哈希对比逻辑

### Phase 3: 格式化输出 (Day 2)
- [ ] 实现 format_id_range 函数
- [ ] 完善 commit message 生成逻辑
- [ ] 处理组合场景

### Phase 4: 边界处理 (Day 2-3)
- [ ] 处理首次提交场景
- [ ] 添加大量变动保护
- [ ] 错误处理和日志

### Phase 5: 测试验证 (Day 3)
- [ ] 编写测试用例
- [ ] 执行集成测试
- [ ] 文档更新

---

## 7. 风险评估

| 风险 | 概率 | 影响 | 缓解措施 |
|------|------|------|----------|
| 性能问题（大文件） | 中 | 中 | 限制检测条目数量，优化算法 |
| 格式解析错误 | 低 | 高 | 增加格式验证，优雅降级 |
| 误报修改 | 中 | 低 | 使用稳定哈希算法，忽略格式变化 |
| Git 依赖问题 | 低 | 高 | 检查 git 状态，提供备用方案 |

---

## 8. 附录

### 8.1 依赖

- bash >= 4.0
- git
- 标准 Unix 工具：grep, awk, sort, comm, md5sum/shasum

### 8.2 配置项

```bash
# 最多显示的 ID 数量
MAX_DISPLAY_IDS=10

# 是否忽略格式变化（空格、换行）
IGNORE_FORMAT_CHANGES=true

# 哈希算法：md5 或 sha1
HASH_ALGORITHM=md5
```

---

**文档版本**: 1.0  
**作者**: Claude Code  
**审核状态**: 已确认
