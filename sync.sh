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
