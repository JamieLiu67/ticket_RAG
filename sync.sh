#!/bin/bash

# RAG 知识库同步脚本
# 功能：一键同步工单和CS_KI文件到 GitHub 和阿里云 OSS

set -e

# 颜色定义
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ============ 配置 ============
TICKET_FILE="工单训练 RAG 集.md"
CSKI_FILE="CS_KI_RAG优化版.md"
OSS_BUCKET="oss://agora-rte-rag-hz"
OSS_ENDPOINT="oss-cn-hangzhou.aliyuncs.com"

# ============ 获取今日日期 ============
if [[ "$OSTYPE" == "darwin"* ]]; then
    TODAY=$(date +%Y.%-m.%-d)
else
    TODAY=$(date +%Y.%-m.%-d)
fi

# ============ 检测变更文件 ============
echo "🔍 检查文件变更..."

CHANGED_FILES=()
if git diff --quiet HEAD -- "$TICKET_FILE" 2>/dev/null || [ -n "$(git status --porcelain "$TICKET_FILE" 2>/dev/null)" ]; then
    CHANGED_FILES+=("$TICKET_FILE")
    echo -e "${GREEN}✓ 检测到 $TICKET_FILE 有变更${NC}"
    git diff --stat HEAD -- "$TICKET_FILE" 2>/dev/null || true
fi

if git diff --quiet HEAD -- "$CSKI_FILE" 2>/dev/null || [ -n "$(git status --porcelain "$CSKI_FILE" 2>/dev/null)" ]; then
    CHANGED_FILES+=("$CSKI_FILE")
    echo -e "${GREEN}✓ 检测到 $CSKI_FILE 有变更${NC}"
    git diff --stat HEAD -- "$CSKI_FILE" 2>/dev/null || true
fi

if [ ${#CHANGED_FILES[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠️  警告：没有检测到文件变更${NC}"
    read -p "是否继续同步？(y/N): " continue_anyway
    if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
        echo "已取消"
        exit 0
    fi
fi

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

# 计算字符串的 MD5 哈希（跨平台兼容）
compute_hash() {
    local content="$1"
    if command -v md5sum >/dev/null 2>&1; then
        echo "$content" | md5sum | awk '{print $1}'
    else
        echo "$content" | md5 | awk '{print $1}'
    fi
}

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
        id=$(echo "$id" | tr -d ' ' | sed 's/^0*//')
        if [ -z "$id" ]; then
            id=0
        fi
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

# ============ 生成工单文件的 commit message 部分 ============
generate_ticket_message() {
    LAST_COMMIT_MSG=$(git log -1 --format="%s")
    LAST_DATES=$(echo "$LAST_COMMIT_MSG" | grep -oE '[0-9]{4}\.[0-9]{1,2}\.[0-9]{1,2}')
    
    if [ -n "$LAST_DATES" ]; then
        LAST_END_DATE=$(echo "$LAST_DATES" | tail -1)
        echo "新增 ${LAST_END_DATE} 19:00 到 ${TODAY} 19:00 的工单对答记录"
    else
        if [[ "$OSTYPE" == "darwin"* ]]; then
            YESTERDAY=$(date -v-1d +%Y.%-m.%-d 2>/dev/null || echo "$TODAY")
        else
            YESTERDAY=$(date -d "yesterday" +%Y.%-m.%-d 2>/dev/null || echo "$TODAY")
        fi
        echo "新增 ${YESTERDAY} 19:00 到 ${TODAY} 19:00 的工单对答记录"
    fi
}

# ============ 生成 CS_KI 文件的 commit message 部分 ============
generate_cski_message() {
    # 获取当前文件中的最大 ID
    CURRENT_MAX=$(grep -oE '# CS_KI_[0-9]+' "$CSKI_FILE" | grep -oE '[0-9]+' | sort -n | tail -1)
    
    # 获取上次提交时的文件内容中的最大 ID
    if git show HEAD:"$CSKI_FILE" 2>/dev/null | grep -oE '# CS_KI_[0-9]+' | grep -oE '[0-9]+' | sort -n | tail -1 > /tmp/last_max_id.txt 2>/dev/null; then
        LAST_MAX=$(cat /tmp/last_max_id.txt)
    else
        LAST_MAX=0
    fi
    
    rm -f /tmp/last_max_id.txt
    
    if [ -n "$CURRENT_MAX" ] && [ "$CURRENT_MAX" -gt "$LAST_MAX" ]; then
        if [ "$((LAST_MAX + 1))" -eq "$CURRENT_MAX" ]; then
            # 只新增了一个
            echo "新增 CSKI ${CURRENT_MAX}"
        else
            # 新增了多个
            echo "新增 CSKI $((LAST_MAX + 1))-${CURRENT_MAX}"
        fi
    else
        echo "更新 CSKI"
    fi
}

# ============ 生成合并的 commit message ============
echo ""
echo "📝 生成建议的 commit message..."

COMMIT_PARTS=()

# 检查工单文件是否有变更
if [[ " ${CHANGED_FILES[@]} " =~ " ${TICKET_FILE} " ]]; then
    TICKET_MSG=$(generate_ticket_message)
    COMMIT_PARTS+=("$TICKET_MSG")
fi

# 检查 CS_KI 文件是否有变更
if [[ " ${CHANGED_FILES[@]} " =~ " ${CSKI_FILE} " ]]; then
    CSKI_MSG=$(generate_cski_message)
    COMMIT_PARTS+=("$CSKI_MSG")
fi

# 合并 commit message
if [ ${#COMMIT_PARTS[@]} -eq 2 ]; then
    SUGGESTED_MSG="${COMMIT_PARTS[0]}；${COMMIT_PARTS[1]}"
else
    SUGGESTED_MSG="${COMMIT_PARTS[0]}"
fi

echo ""
echo "建议的 commit message:"
echo "  $SUGGESTED_MSG"
echo ""

# ============ 用户确认/修改 ============
read -p "使用建议的 message? [回车确认 / 输入自定义内容 / n取消]: " user_input

if [ -z "$user_input" ]; then
    COMMIT_MSG="$SUGGESTED_MSG"
elif [[ "$user_input" =~ ^[Nn]$ ]]; then
    echo "已取消"
    exit 0
else
    COMMIT_MSG="$user_input"
fi

echo ""
echo "将使用 commit message: $COMMIT_MSG"
echo ""

# ============ Git 操作 ============
echo "📦 Git 操作..."
for file in "${CHANGED_FILES[@]}"; do
    git add "$file"
done
git commit -m "$COMMIT_MSG"
git push origin main &
GIT_PID=$!

# ============ OSS 上传 ============
echo "☁️  上传到阿里云 OSS..."
for file in "${CHANGED_FILES[@]}"; do
    ossutil cp "$file" "$OSS_BUCKET/$file" -f --endpoint "$OSS_ENDPOINT" &
done
OSS_PID=$!

# ============ 等待并行任务 ============
echo ""
echo "⏳ 等待同步完成（并行执行中）..."
echo ""

wait $GIT_PID
GIT_STATUS=$?

wait $OSS_PID
OSS_STATUS=$?

# ============ 结果汇总 ============
echo ""
echo "================================"
echo "         同步结果报告"
echo "================================"

if [ $GIT_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ GitHub 备份${NC}"
    echo "   分支: main"
    echo "   Commit: $(git log -1 --oneline)"
else
    echo -e "${RED}❌ GitHub 备份失败 (exit code: $GIT_STATUS)${NC}"
fi

echo ""

if [ $OSS_STATUS -eq 0 ]; then
    echo -e "${GREEN}✅ OSS 上传成功${NC}"
    echo "   Bucket: $OSS_BUCKET"
    for file in "${CHANGED_FILES[@]}"; do
        echo "   文件: $file"
    done
    # 显示 OSS 上的文件信息
    for file in "${CHANGED_FILES[@]}"; do
        ossutil ls "$OSS_BUCKET/$file" --endpoint "$OSS_ENDPOINT" 2>/dev/null | grep "$file" || true
    done
else
    echo -e "${RED}❌ OSS 上传失败 (exit code: $OSS_STATUS)${NC}"
fi

echo ""
echo "================================"

if [ $GIT_STATUS -eq 0 ] && [ $OSS_STATUS -eq 0 ]; then
    echo -e "${GREEN}🎉 全部同步完成！${NC}"
    echo ""
    echo "下次同步将在百炼平台自动生效"
    exit 0
else
    echo -e "${YELLOW}⚠️  部分任务失败${NC}"
    echo ""
    if [ $GIT_STATUS -ne 0 ]; then
        echo "GitHub 失败排查："
        echo "  - 检查网络连接"
        echo "  - 检查 git remote -v 配置"
        echo "  - 检查是否有未解决的冲突"
    fi
    if [ $OSS_STATUS -ne 0 ]; then
        echo "OSS 失败排查："
        echo "  - 检查网络连接"
        echo "  - 运行: ossutil config 检查 AK/SK 配置"
        echo "  - 检查 bucket 权限"
    fi
    exit 1
fi
