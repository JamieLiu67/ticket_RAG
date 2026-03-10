#!/bin/bash

# RAG 知识库同步脚本 v2.0
# 功能：一键同步工单和CS_KI文件到 GitHub 和阿里云 OSS
# 优化：高效哈希计算、图形进度条、超时机制

set -e

# ============ 临时目录管理 ============
TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

# ============ 颜色定义 ============
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 启用颜色输出
export TERM=xterm-256color

# ============ 配置 ============
TICKET_FILE="工单训练 RAG 集.md"
CSKI_FILE="CS_KI_RAG 优化版.md"
VIDEO_FILE="Video私有参数.md"
OSS_BUCKET="oss://agora-rte-rag-hz"
OSS_ENDPOINT="oss-cn-hangzhou.aliyuncs.com"

# 最多显示的 ID 数量（超过则只显示数量）
MAX_DISPLAY_IDS=10

# 超时时间（秒）
TIMEOUT_SECONDS=60

# 命令行参数
FAST_MODE=false
SHOW_PROGRESS=true
DRY_RUN=false

# ============ 命令行参数解析 ============
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --fast)
                FAST_MODE=true
                shift
                ;;
            --no-progress)
                SHOW_PROGRESS=false
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            *)
                echo "未知参数: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

show_help() {
    echo "用法：./sync.sh [选项]"
    echo ""
    echo "选项:"
    echo "  --fast          快速模式（不计算哈希，只统计数量）"
    echo "  --no-progress   不显示进度条"
    echo "  --dry-run       模拟模式（检测变动但不实际提交和上传）"
    echo "  --help, -h      显示帮助信息"
    echo ""
    echo "示例:"
    echo "  ./sync.sh                    # 默认精确模式"
    echo "  ./sync.sh --fast             # 快速模式"
    echo "  ./sync.sh --fast --no-progress  # 快速模式且无进度条"
    echo "  ./sync.sh --dry-run          # 模拟模式测试"
}

# ============ 图形进度条 ============
# 全局变量，用于跟踪进度条是否已显示
PROGRESS_SHOWN=false

show_progress() {
    local current=$1
    local total=$2
    local msg=$3
    local is_new=${4:-false}  # 是否是新的进度条（首次显示）
    
    # 禁用进度条时不显示
    if [ "$SHOW_PROGRESS" != "true" ]; then
        return
    fi
    
    local percent=$((current * 100 / total))
    local width=30
    local filled=$((width * current / total))
    local empty=$((width - filled))
    
    # 使用 Unicode block characters
    local bar=""
    for ((i=0; i<filled; i++)); do bar="${bar}█"; done
    for ((i=0; i<empty; i++)); do bar="${bar}░"; done
    
    # 如果是新的进度条，先换行到 stderr（这样不会被 $(...) 捕获）
    if [ "$is_new" == "true" ]; then
        echo "" >&2
        PROGRESS_SHOWN=true
    fi
    
    # 使用 printf 的 \r 回到行首，输出进度条到 stderr
    printf "\r  [%s] %3d%% (%d/%d) %s" "$bar" "$percent" "$current" "$total" "$msg" >&2
    
    # 如果完成，换行并标记完成
    if [ $current -eq $total ]; then
        printf "\n" >&2
        PROGRESS_SHOWN=false
    fi
}

# 清除当前行（用于在进度条完成后清理）
clear_progress_line() {
    if [ "$PROGRESS_SHOWN" == "true" ]; then
        printf "\r\033[K" >&2
        PROGRESS_SHOWN=false
    fi
}

# ============ 工具函数 ============
count_ids() {
    local ids="$1"
    if [ -z "$ids" ]; then
        echo "0"
        return
    fi
    echo "$ids" | tr ',' '\n' | grep -v '^$' | wc -l
}

# ============ 获取今日日期 ============
TODAY=$(date +%Y.%-m.%-d)

# ============ 高效的文件解析函数 ============

# 解析文件，输出格式: id|hash
# 使用临时文件避免 shell 解析特殊字符问题
parse_file_to_hashes() {
    local file="$1"
    local file_type="$2"  # "ticket" or "cski"
    
    if [ ! -f "$file" ]; then
        return
    fi
    
    # 使用全局临时目录（由 trap 管理清理）
    local tmpdir="$TMPDIR/hashes"
    mkdir -p "$tmpdir"
    
    if [ "$file_type" == "ticket" ]; then
        awk -v tmpdir="$tmpdir" '
            /^# ID: / {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
                current_id = $3
                entry = ""
                next
            }
            current_id != "" {
                entry = entry $0 "\n"
            }
            END {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
            }
        ' "$file"
    elif [ "$file_type" == "cski" ]; then
        awk -v tmpdir="$tmpdir" '
            /^# CS_KI_/ {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
                current_id = $0
                sub(/.*CS_KI_/, "", current_id)
                sub(/[^0-9].*/, "", current_id)
                entry = ""
                next
            }
            current_id != "" {
                entry = entry $0 "\n"
            }
            END {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
            }
        ' "$file"
    elif [ "$file_type" == "video" ]; then
        awk -v tmpdir="$tmpdir" '
            /^# rtc\.video\./ {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
                current_id = $0
                sub(/^# /, "", current_id)
                entry = ""
                next
            }
            current_id != "" {
                entry = entry $0 "\n"
            }
            END {
                if (current_id != "" && entry != "") {
                    tmpfile = tmpdir "/" current_id
                    printf "%s", entry > tmpfile
                    close(tmpfile)
                    print current_id
                }
            }
        ' "$file"
    fi | while read -r id; do
        local hash
        if command -v md5sum >/dev/null 2>&1; then
            hash=$(md5sum "$tmpdir/$id" | awk '{print $1}')
        else
            hash=$(md5 "$tmpdir/$id" | awk '{print $NF}')
        fi
        echo "$id|$hash"
    done
}

# 快速模式：只统计 ID 数量，不计算哈希
parse_file_to_ids_fast() {
    local file="$1"
    local file_type="$2"
    
    if [ ! -f "$file" ]; then
        return
    fi
    
    if [ "$file_type" == "ticket" ]; then
        grep "^# ID:" "$file" | awk '{print $3}' | sort -n
    elif [ "$file_type" == "cski" ]; then
        # 使用 grep -oE 提取数字 ID，更健壮
        grep "^# CS_KI_" "$file" | grep -oE 'CS_KI_[0-9]+' | sed 's/CS_KI_//' | sort -n
    elif [ "$file_type" == "video" ]; then
        # Video 文件：提取 rtc.video.xxx 作为 ID
        grep "^# rtc.video\." "$file" | sed 's/^# //' | sort
    fi
}

# ============ 变动检测函数（优化版） ============

detect_changes() {
    local file="$1"
    local file_type="$2"
    local desc="$3"
    
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
    
    # 快速模式：只统计数量
    if [ "$FAST_MODE" == "true" ]; then
        detect_changes_fast "$file" "$file_type"
        return
    fi
    
    # 精确模式：使用临时文件存储哈希
    local current_file last_file
    current_file=$(mktemp)
    last_file=$(mktemp)
    
    # 检查是否是首次提交（没有历史版本）
    local last_file_tmp="${last_file}.tmp"
    if ! git show HEAD:"$file" > "$last_file_tmp" 2>/dev/null; then
        # 首次提交，所有条目都是新增的
        local all_ids
        if [ "$file_type" == "ticket" ]; then
            all_ids=$(parse_file_to_ids_fast "$file" "$file_type" | tr '\n' ',' | sed 's/,$//')
        else
            all_ids=$(parse_file_to_ids_fast "$file" "$file_type" | sed 's/^0*//' | tr '\n' ',' | sed 's/,$//')
        fi
        rm -f "$current_file" "$last_file" "$last_file_tmp"
        echo "ADDED:$all_ids|DELETED:|MODIFIED:"
        return
    fi
    
    # 解析当前文件
    if [ "$SHOW_PROGRESS" == "true" ]; then
        # 获取总数用于进度条（使用 awk 避免 grep -c 的返回值问题）
        local total_ids
        if [ "$file_type" == "ticket" ]; then
            total_ids=$(awk '/^# ID:/ {count++} END {print count+0}' "$file" 2>/dev/null || echo "1")
        else
            total_ids=$(awk '/^# CS_KI_/ {count++} END {print count+0}' "$file" 2>/dev/null || echo "1")
        fi
        
        # 后台执行哈希计算
        parse_file_to_hashes "$file" "$file_type" > "$current_file" &
        local pid=$!
        
        local processed=0
        local first_show=true
        while kill -0 $pid 2>/dev/null && [ "$processed" -lt "$total_ids" ]; do
            processed=$((processed + total_ids / 20 + 1))
            if [ "$processed" -gt "$total_ids" ]; then
                processed=$total_ids
            fi
            if [ "$first_show" == "true" ]; then
                show_progress $processed $total_ids "分析 ${desc}" "true"
                first_show=false
            else
                show_progress $processed $total_ids "分析 ${desc}"
            fi
            sleep 0.1
        done
        # 确保显示 100%
        if [ "$processed" -lt "$total_ids" ]; then
            show_progress $total_ids $total_ids "分析 ${desc}"
        fi
        wait $pid 2>/dev/null
    else
        parse_file_to_hashes "$file" "$file_type" > "$current_file"
    fi
    
    # 解析旧文件（last_file_tmp 已在上面创建）
    if [ "$SHOW_PROGRESS" == "true" ]; then
        local total_ids_old
        if [ "$file_type" == "ticket" ]; then
            total_ids_old=$(awk '/^# ID:/ {count++} END {print count+0}' "$last_file_tmp" 2>/dev/null || echo "1")
        else
            total_ids_old=$(awk '/^# CS_KI_/ {count++} END {print count+0}' "$last_file_tmp" 2>/dev/null || echo "1")
        fi
        
        parse_file_to_hashes "$last_file_tmp" "$file_type" > "$last_file" &
        local pid=$!
        
        local processed=0
        local first_show=true
        while kill -0 $pid 2>/dev/null && [ "$processed" -lt "$total_ids_old" ]; do
            processed=$((processed + total_ids_old / 20 + 1))
            if [ "$processed" -gt "$total_ids_old" ]; then
                processed=$total_ids_old
            fi
            if [ "$first_show" == "true" ]; then
                show_progress $processed $total_ids_old "对比历史版本" "true"
                first_show=false
            else
                show_progress $processed $total_ids_old "对比历史版本"
            fi
            sleep 0.1
        done
        # 确保显示 100%
        if [ "$processed" -lt "$total_ids_old" ]; then
            show_progress $total_ids_old $total_ids_old "对比历史版本"
        fi
        wait $pid 2>/dev/null
    else
        parse_file_to_hashes "$last_file_tmp" "$file_type" > "$last_file"
    fi
    
    rm -f "$last_file_tmp"
    
    # 比较两个文件
    local added_ids deleted_ids modified_ids
    added_ids=$(comm -23 <(cut -d'|' -f1 "$current_file" | sort) <(cut -d'|' -f1 "$last_file" | sort) | tr '\n' ',' | sed 's/,$//')
    deleted_ids=$(comm -13 <(cut -d'|' -f1 "$current_file" | sort) <(cut -d'|' -f1 "$last_file" | sort) | tr '\n' ',' | sed 's/,$//')
    
    # 检测修改（共同存在的 ID 但哈希不同）
    modified_ids=""
    local common_ids
    common_ids=$(comm -12 <(cut -d'|' -f1 "$current_file" | sort) <(cut -d'|' -f1 "$last_file" | sort))
    
    if [ -n "$common_ids" ]; then
        # 使用 join 命令比较哈希值（兼容旧版 bash）
        modified_ids=$(join -t'|' -1 1 -2 1 "$last_file" "$current_file" | awk -F'|' '$2 != $3 {print $1}' | tr '\n' ',' | sed 's/,$//')
    fi
    
    # 清理临时文件
    rm -f "$current_file" "$last_file"
    
    echo "ADDED:$added_ids|DELETED:$deleted_ids|MODIFIED:$modified_ids"
}

# 快速模式：只统计数量变化
detect_changes_fast() {
    local file="$1"
    local file_type="$2"
    
    local current_ids last_ids
    current_ids=$(parse_file_to_ids_fast "$file" "$file_type")
    last_ids=$(git show HEAD:"$file" 2>/dev/null | parse_file_to_ids_fast - "$file_type")
    
    local added_count deleted_count
    added_count=$(comm -23 <(echo "$current_ids") <(echo "$last_ids") | wc -l | tr -d ' ')
    deleted_count=$(comm -13 <(echo "$current_ids") <(echo "$last_ids") | wc -l | tr -d ' ')
    
    echo "ADDED:${added_count}|DELETED:${deleted_count}|MODIFIED:0"
}

# ============ ID 格式化函数 ============

compress_id_range() {
    local ids="$1"
    ids=$(echo "$ids" | tr ',' '\n' | sort -n | uniq)
    
    local result=""
    local start=""
    local start_formatted=""
    local prev_num=""
    
    for id in $ids; do
        # 保留原始格式，只去掉空格
        id=$(echo "$id" | tr -d ' ')
        if [ -z "$id" ]; then
            continue
        fi
        
        # 提取数字部分用于比较
        local num_id=$(echo "$id" | sed 's/^0*//')
        if [ -z "$num_id" ]; then
            num_id=0
        fi
        
        if [ -z "$start" ]; then
            start=$num_id
            start_formatted=$id
            prev_num=$num_id
        elif [ $((prev_num + 1)) -eq "$num_id" ]; then
            prev_num=$num_id
        else
            if [ "$start" -eq "$prev_num" ]; then
                result="${result}${start_formatted}, "
            else
                # 范围显示时也保留格式（使用前一个 ID 的格式）
                local prev_formatted=$(printf "%04d" $prev_num)
                result="${result}${start_formatted}-${prev_formatted}, "
            fi
            start=$num_id
            start_formatted=$id
            prev_num=$num_id
        fi
    done
    
    if [ -n "$start" ]; then
        if [ "$start" -eq "$prev_num" ]; then
            result="${result}${start_formatted}"
        else
            local prev_formatted=$(printf "%04d" $prev_num)
            result="${result}${start_formatted}-${prev_formatted}"
        fi
    fi
    
    echo "$result"
}

format_id_list() {
    local ids="$1"
    echo "$ids" | tr ',' '\n' | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g'
}

# ============ 生成工单文件的 commit message 部分 ============
generate_ticket_message() {
    local changes
    changes=$(detect_changes "$TICKET_FILE" "ticket" "工单文件")
    
    local added_ids deleted_ids modified_ids
    added_ids=$(echo "$changes" | grep -o 'ADDED:[^|]*' | cut -d: -f2)
    deleted_ids=$(echo "$changes" | grep -o 'DELETED:[^|]*' | cut -d: -f2)
    modified_ids=$(echo "$changes" | grep -o 'MODIFIED:[^|]*' | cut -d: -f2)
    
    local parts=()
    
    if [ -n "$added_ids" ] && [ "$added_ids" != "0" ]; then
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
    
    if [ -n "$deleted_ids" ] && [ "$deleted_ids" != "0" ]; then
        local deleted_count
        if [ "$FAST_MODE" == "true" ]; then
            deleted_count=$deleted_ids
            if [ "$deleted_count" -eq 0 ]; then
                deleted_ids=""
            fi
        else
            deleted_count=$(count_ids "$deleted_ids")
        fi
        
        if [ -n "$deleted_ids" ] && [ "$deleted_count" -gt 0 ]; then
            if [ "$deleted_count" -gt "$MAX_DISPLAY_IDS" ]; then
                parts+=("删除 ${deleted_count} 条工单")
            else
                local formatted_deleted
                formatted_deleted=$(format_id_list "$deleted_ids")
                parts+=("删除工单 ID: ${formatted_deleted}")
            fi
        fi
    fi
    
    if [ -n "$modified_ids" ] && [ "$modified_ids" != "0" ]; then
        local modified_count
        if [ "$FAST_MODE" == "true" ]; then
            modified_count=$modified_ids
            if [ "$modified_count" -eq 0 ]; then
                modified_ids=""
            fi
        else
            modified_count=$(count_ids "$modified_ids")
        fi
        
        if [ -n "$modified_ids" ] && [ "$modified_count" -gt 0 ]; then
            if [ "$modified_count" -gt "$MAX_DISPLAY_IDS" ]; then
                parts+=("修改 ${modified_count} 条工单")
            else
                local formatted_modified
                formatted_modified=$(format_id_list "$modified_ids")
                parts+=("修改工单 ID: ${formatted_modified}")
            fi
        fi
    fi
    
    if [ ${#parts[@]} -eq 0 ]; then
        echo "更新工单文件"
    else
        local IFS='；'
        echo "${parts[*]}"
    fi
}

# ============ 生成 CS_KI 文件的 commit message 部分 ============
generate_cski_message() {
    local changes
    changes=$(detect_changes "$CSKI_FILE" "cski" "CS_KI 文件")
    
    local added_ids deleted_ids modified_ids
    added_ids=$(echo "$changes" | grep -o 'ADDED:[^|]*' | cut -d: -f2)
    deleted_ids=$(echo "$changes" | grep -o 'DELETED:[^|]*' | cut -d: -f2)
    modified_ids=$(echo "$changes" | grep -o 'MODIFIED:[^|]*' | cut -d: -f2)
    
    local parts=()
    
    if [ -n "$added_ids" ] && [ "$added_ids" != "0" ]; then
        local formatted_added
        formatted_added=$(compress_id_range "$added_ids")
        parts+=("新增 CSKI ${formatted_added}")
    fi
    
    if [ -n "$deleted_ids" ] && [ "$deleted_ids" != "0" ]; then
        local deleted_count
        if [ "$FAST_MODE" == "true" ]; then
            deleted_count=$deleted_ids
            if [ "$deleted_count" -eq 0 ]; then
                deleted_ids=""
            fi
        else
            deleted_count=$(count_ids "$deleted_ids")
        fi
        
        if [ -n "$deleted_ids" ] && [ "$deleted_count" -gt 0 ]; then
            if [ "$deleted_count" -gt "$MAX_DISPLAY_IDS" ]; then
                parts+=("删除 ${deleted_count} 条 CSKI")
            else
                local formatted_deleted
                formatted_deleted=$(format_id_list "$deleted_ids")
                parts+=("删除 CSKI ${formatted_deleted}")
            fi
        fi
    fi
    
    if [ -n "$modified_ids" ] && [ "$modified_ids" != "0" ]; then
        local modified_count
        if [ "$FAST_MODE" == "true" ]; then
            modified_count=$modified_ids
            if [ "$modified_count" -eq 0 ]; then
                modified_ids=""
            fi
        else
            modified_count=$(count_ids "$modified_ids")
        fi
        
        if [ -n "$modified_ids" ] && [ "$modified_count" -gt 0 ]; then
            if [ "$modified_count" -gt "$MAX_DISPLAY_IDS" ]; then
                parts+=("修改 ${modified_count} 条 CSKI")
            else
                local formatted_modified
                formatted_modified=$(format_id_list "$modified_ids")
                parts+=("修改 CSKI ${formatted_modified}")
            fi
        fi
    fi
    
    if [ ${#parts[@]} -eq 0 ]; then
        echo "更新 CSKI 文件"
    else
        local IFS='；'
        echo "${parts[*]}"
    fi
}

# ============ 主程序 ============

main() {
    # 解析命令行参数
    parse_args "$@"
    
    # 检查 ossutil 是否安装（dry-run 模式除外）
    if [ "$DRY_RUN" != "true" ] && ! command -v ossutil >/dev/null 2>&1; then
        echo -e "${RED}❌ ossutil 未安装，请先安装阿里云 OSS 工具${NC}"
        echo "   安装方法：https://help.aliyun.com/document_detail/50452.html"
        exit 1
    fi
    
    # ============ 从远端拉取 Video 私有参数.md ============
    VIDEO_UPDATED=false
    REMOTE_VIDEO_EXISTS=false
    REMOTE_VIDEO_BLOB=""
    echo "📥 检查远端 Video 私有参数.md..."
    if git fetch origin main 2>/dev/null; then
        # 使用 git ls-tree 检测文件是否存在并获取 blob hash
        REMOTE_VIDEO_BLOB=$(git ls-tree origin/main 2>/dev/null | grep "Video" | awk '{print $3}')
        if [ -n "$REMOTE_VIDEO_BLOB" ]; then
            REMOTE_VIDEO_EXISTS=true
        fi
        
        if [ "$REMOTE_VIDEO_EXISTS" == "true" ]; then
            # 如果本地文件不存在，从远端拉取
            if [ ! -f "$VIDEO_FILE" ]; then
                git show "$REMOTE_VIDEO_BLOB" > "$VIDEO_FILE" 2>/dev/null
                VIDEO_UPDATED=true
                echo -e "${GREEN}✓ 已从远端下载 $VIDEO_FILE${NC}"
            else
                # 本地文件存在，比较远端和本地的差异
                git show "$REMOTE_VIDEO_BLOB" > "$TMPDIR/video_remote.md" 2>/dev/null
                if ! diff -q "$TMPDIR/video_remote.md" "$VIDEO_FILE" >/dev/null 2>&1; then
                    # 远端和本地不同，使用远端版本并标记为已更新
                    cp "$TMPDIR/video_remote.md" "$VIDEO_FILE"
                    VIDEO_UPDATED=true
                    echo -e "${GREEN}✓ 远端 Video 私有参数.md 有更新，已同步到本地${NC}"
                else
                    echo -e "${GREEN}✓ 本地 $VIDEO_FILE 已是最新版本${NC}"
                fi
            fi
        else
            echo -e "${YELLOW}⚠️  远端仓库中没有 Video 私有参数.md，跳过拉取${NC}"
        fi
    else
        echo -e "${YELLOW}⚠️  无法连接远端仓库，使用本地 $VIDEO_FILE${NC}"
    fi
    
    echo "🔍 检查文件变更..."
    
    CHANGED_FILES=()
    
    # 使用 GIT_PAGER=cat 避免 less 分页
    if ! git diff --quiet HEAD -- "$TICKET_FILE" 2>/dev/null || [ -n "$(git status --porcelain "$TICKET_FILE" 2>/dev/null)" ]; then
        CHANGED_FILES+=("$TICKET_FILE")
        echo -e "${GREEN}✓ 检测到 $TICKET_FILE 有变更${NC}"
        GIT_PAGER=cat git diff --stat HEAD -- "$TICKET_FILE" 2>/dev/null || true
    fi
    
    if ! git diff --quiet HEAD -- "$CSKI_FILE" 2>/dev/null || [ -n "$(git status --porcelain "$CSKI_FILE" 2>/dev/null)" ]; then
        CHANGED_FILES+=("$CSKI_FILE")
        echo -e "${GREEN}✓ 检测到 $CSKI_FILE 有变更${NC}"
        GIT_PAGER=cat git diff --stat HEAD -- "$CSKI_FILE" 2>/dev/null || true
    fi
    
    # 判断是否只有 Video 文件有更新
    ONLY_VIDEO_UPDATE=false
    if [ ${#CHANGED_FILES[@]} -eq 0 ] && [ "$VIDEO_UPDATED" == "true" ]; then
        ONLY_VIDEO_UPDATE=true
    fi
    
    if [ ${#CHANGED_FILES[@]} -eq 0 ]; then
        if [ "$VIDEO_UPDATED" != "true" ]; then
            echo -e "${YELLOW}⚠️  警告：没有检测到文件变更${NC}"
            read -p "是否继续同步？(y/N): " continue_anyway
            if [[ ! "$continue_anyway" =~ ^[Yy]$ ]]; then
                echo "已取消"
                exit 0
            fi
        else
            echo -e "${GREEN}✓ Video 文件有更新，将上传到 OSS${NC}"
        fi
    fi
    
    # 只有非 Video 文件更新时才生成 commit message
    if [ "$ONLY_VIDEO_UPDATE" != "true" ]; then
        echo ""
        echo "📝 生成建议的 commit message..."
        
        COMMIT_PARTS=()
        
        # 生成工单消息
        if [[ " ${CHANGED_FILES[@]} " =~ " ${TICKET_FILE} " ]]; then
            TICKET_MSG=$(generate_ticket_message)
            COMMIT_PARTS+=("$TICKET_MSG")
        fi
        
        # 生成 CSKI 消息
        if [[ " ${CHANGED_FILES[@]} " =~ " ${CSKI_FILE} " ]]; then
            CSKI_MSG=$(generate_cski_message)
            COMMIT_PARTS+=("$CSKI_MSG")
        fi
        
        # 合并 commit message
        if [ ${#COMMIT_PARTS[@]} -eq 2 ]; then
            SUGGESTED_MSG="${COMMIT_PARTS[0]}；${COMMIT_PARTS[1]}"
        elif [ ${#COMMIT_PARTS[@]} -eq 1 ]; then
            SUGGESTED_MSG="${COMMIT_PARTS[0]}"
        else
            SUGGESTED_MSG="同步 RAG 知识库"
        fi
        
        echo ""
        echo "建议的 commit message:"
        echo "  $SUGGESTED_MSG"
        echo ""
        
        # Dry-run 模式：跳过交互，直接退出
        if [ "$DRY_RUN" == "true" ]; then
            echo -e "${GREEN}✅ [DRY RUN] 完成 - 未执行任何实际修改${NC}"
            echo ""
            echo "实际文件变更:"
            if [ "$VIDEO_UPDATED" == "true" ]; then
                echo "  $VIDEO_FILE (仅上传 OSS，不提交 git)"
            fi
            for file in "${CHANGED_FILES[@]}"; do
                echo "  $file"
            done
            exit 0
        fi
        
        read -p "使用建议的 message? [回车确认 / 输入自定义内容 / n 取消]: " user_input
        
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
    else
        # 只有 Video 文件更新，不需要 commit message
        echo ""
        echo "📝 Video 文件更新（无需 git commit，直接上传 OSS）"
        echo ""
        
        # Dry-run 模式：跳过执行，直接退出
        if [ "$DRY_RUN" == "true" ]; then
            echo -e "${GREEN}✅ [DRY RUN] 完成 - 未执行任何实际修改${NC}"
            echo ""
            echo "实际文件变更:"
            echo "  $VIDEO_FILE (仅上传 OSS，不提交 git)"
            exit 0
        fi
        
        read -p "是否继续上传到 OSS? [回车确认 / n 取消]: " user_input
        
        if [[ "$user_input" =~ ^[Nn]$ ]]; then
            echo "已取消"
            exit 0
        fi
        
        COMMIT_MSG=""
    fi
    
    # 准备日志文件
    GIT_LOG="/tmp/sync_git_$$.log"
    OSS_LOG="/tmp/sync_oss_$$.log"
    touch "$OSS_LOG"
    
    # 只有非 Video 文件更新时才执行 git 操作
    if [ "$ONLY_VIDEO_UPDATE" != "true" ]; then
        echo "📦 Git 操作..."
        for file in "${CHANGED_FILES[@]}"; do
            git add "$file"
        done
        if [ ${#CHANGED_FILES[@]} -gt 0 ]; then
            git commit -m "$COMMIT_MSG"
        fi
        git push origin main > "$GIT_LOG" 2>&1 &
        GIT_PID=$!
    else
        echo "📦 跳过 Git 操作（Video 文件不提交 git）"
        GIT_PID=""
    fi
    
    echo "☁️  上传到阿里云 OSS..."
    # Video 文件单独上传（如果有更新）- 同步执行确保能看到状态
    VIDEO_OSS_STATUS=0
    if [ "$VIDEO_UPDATED" == "true" ]; then
        echo -n "  - $VIDEO_FILE (直接上传 OSS，不经过 git) ... "
        if ossutil cp "$VIDEO_FILE" "$OSS_BUCKET/$VIDEO_FILE" -f --endpoint "$OSS_ENDPOINT" >> "$OSS_LOG" 2>&1; then
            echo -e "${GREEN}✅${NC}"
        else
            echo -e "${RED}❌${NC}"
            VIDEO_OSS_STATUS=1
        fi
    fi
    # 其他文件上传（后台并行）
    OSS_PID=""
    if [ ${#CHANGED_FILES[@]} -gt 0 ]; then
        for file in "${CHANGED_FILES[@]}"; do
            echo "  - $file"
            ossutil cp "$file" "$OSS_BUCKET/$file" -f --endpoint "$OSS_ENDPOINT" >> "$OSS_LOG" 2>&1 &
        done
        OSS_PID=$!
    fi
    
    echo ""
    echo "⏳ 等待同步完成（并行执行中）..."
    echo ""
    
    # 等待 git 操作（如果有）
    GIT_STATUS=0
    if [ -n "$GIT_PID" ]; then
        wait $GIT_PID
        GIT_STATUS=$?
    fi
    
    # 等待其他文件 OSS 上传（如果有）
    OSS_STATUS=0
    if [ -n "$OSS_PID" ] && [ ${#CHANGED_FILES[@]} -gt 0 ]; then
        wait $OSS_PID
        OSS_STATUS=$?
    fi
    
    # 清理日志文件（成功时）
    if [ $GIT_STATUS -eq 0 ] && [ $OSS_STATUS -eq 0 ] && [ $VIDEO_OSS_STATUS -eq 0 ]; then
        rm -f "$GIT_LOG" "$OSS_LOG"
    fi
    
    echo ""
    echo "================================"
    echo "         同步结果报告"
    echo "================================"
    
    # GitHub 备份结果（只有非 Video 文件更新时才显示）
    if [ "$ONLY_VIDEO_UPDATE" != "true" ] && [ ${#CHANGED_FILES[@]} -gt 0 ]; then
        if [ $GIT_STATUS -eq 0 ]; then
            echo -e "${GREEN}✅ GitHub 备份${NC}"
            echo "   分支：main"
            echo "   Commit: $(git log -1 --oneline)"
        else
            echo -e "${RED}❌ GitHub 备份失败 (exit code: $GIT_STATUS)${NC}"
            echo "   错误日志:"
            if [ -f "$GIT_LOG" ]; then
                cat "$GIT_LOG" | sed 's/^/     /'
            fi
        fi
        echo ""
    fi
    
    # Video 文件 OSS 上传结果
    if [ "$VIDEO_UPDATED" == "true" ]; then
        if [ $VIDEO_OSS_STATUS -eq 0 ]; then
            echo -e "${GREEN}✅ Video 文件上传 OSS 成功${NC}"
            echo "   文件：$VIDEO_FILE"
            echo "   路径：$OSS_BUCKET/$VIDEO_FILE"
            echo "   （不提交 git，直接上传 OSS）"
        else
            echo -e "${RED}❌ Video 文件上传 OSS 失败${NC}"
            echo "   文件：$VIDEO_FILE"
            echo "   错误日志:"
            if [ -f "$OSS_LOG" ]; then
                tail -5 "$OSS_LOG" | sed 's/^/     /'
            fi
        fi
        echo ""
    fi
    
    # 其他文件 OSS 上传结果
    if [ ${#CHANGED_FILES[@]} -gt 0 ]; then
        if [ $OSS_STATUS -eq 0 ]; then
            echo -e "${GREEN}✅ 工单/CSKI 文件上传 OSS${NC}"
            echo "   Bucket: $OSS_BUCKET"
            for file in "${CHANGED_FILES[@]}"; do
                echo "   文件：$file"
            done
        else
            echo -e "${RED}❌ 工单/CSKI 文件上传 OSS 失败 (exit code: $OSS_STATUS)${NC}"
            echo "   错误日志:"
            if [ -f "$OSS_LOG" ]; then
                cat "$OSS_LOG" | sed 's/^/     /'
            fi
        fi
    fi
    
    echo ""
    echo "================================"
    
    ALL_SUCCESS=true
    # 只有非 Video 更新时才检查 git 状态
    if [ "$ONLY_VIDEO_UPDATE" != "true" ] && [ ${#CHANGED_FILES[@]} -gt 0 ] && [ $GIT_STATUS -ne 0 ]; then
        ALL_SUCCESS=false
    fi
    if [ "$VIDEO_UPDATED" == "true" ] && [ $VIDEO_OSS_STATUS -ne 0 ]; then
        ALL_SUCCESS=false
    fi
    if [ ${#CHANGED_FILES[@]} -gt 0 ] && [ $OSS_STATUS -ne 0 ]; then
        ALL_SUCCESS=false
    fi
    
    if [ "$ALL_SUCCESS" == "true" ]; then
        echo -e "${GREEN}🎉 全部同步完成！${NC}"
        echo ""
        echo "OSS 文件约 1-2 分钟后在百炼平台自动生效"
        exit 0
    else
        echo -e "${YELLOW}⚠️  部分任务失败${NC}"
        exit 1
    fi
}

# 运行主程序
main "$@"
