#!/bin/bash

# RAG 知识库同步脚本 v3.0
# 功能：双阶段 — Block A：条件化 GitHub（工单/CS_KI）；Block B：始终执行 OSS（按 HEAD blob 增量）
# Prep：fetch + pull --rebase；Video 远端更新时可选 diff 摘要（不写 commit）

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
CSKI_FILE="CS_KI_RAG优化版.md"
VIDEO_FILE="Video私有参数.md"
OSS_BUCKET="oss://agora-rte-rag-hz"
OSS_ENDPOINT="oss-cn-hangzhou.aliyuncs.com"
# OSS 同步清单（与仓库内文件名一致）
OSS_SYNC_FILES=("$TICKET_FILE" "$CSKI_FILE" "$VIDEO_FILE")

# 最多显示的 ID 数量（超过则只显示数量）
MAX_DISPLAY_IDS=10

# 超时时间（秒）
TIMEOUT_SECONDS=60

# 命令行参数
FAST_MODE=false
SHOW_PROGRESS=true
DRY_RUN=false
AUTO_YES=false

# Block 间共享状态（由 main 初始化）
REPO_ROOT=""
OSS_STATE_FILE=""

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
            --yes|-y)
                AUTO_YES=true
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
    echo "  --yes, -y       跳过 OSS 上传前的确认提示"
    echo "  --help, -h      显示帮助信息"
    echo ""
    echo "流程：Prep（fetch + rebase）→ Block A（仅工单/CS_KI 有变更或未 push 时操作 GitHub）"
    echo "      → Block B（始终根据 .oss_last_upload 与 HEAD blob 增量上传 OSS）"
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

# ============ v3：仓库根目录、blob、OSS 状态 ============

# 当前 HEAD 下路径对应 blob；未纳入版本控制则对磁盘文件 hash-object
get_head_blob() {
    local path="$1"
    local sha
    sha=$(git rev-parse "HEAD:$path" 2>/dev/null) || true
    if [ -n "$sha" ]; then
        echo "$sha"
        return
    fi
    if [ -f "$path" ]; then
        git hash-object "$path" 2>/dev/null || echo ""
    else
        echo ""
    fi
}

read_oss_state_blob() {
    local path="$1"
    local statefile="$2"
    if [ ! -f "$statefile" ]; then
        echo ""
        return
    fi
    awk -F '\t' -v p="$path" '$1 == p { print $2; exit }' "$statefile"
}

upsert_oss_state_blob() {
    local path="$1"
    local blob="$2"
    local statefile="$3"
    local tmp
    tmp=$(mktemp)
    if [ -f "$statefile" ]; then
        awk -F '\t' -v p="$path" '$1 != p' "$statefile" > "$tmp" || true
    else
        : > "$tmp"
    fi
    printf '%s\t%s\n' "$path" "$blob" >> "$tmp"
    mv "$tmp" "$statefile"
}

file_has_uncommitted_changes() {
    local path="$1"
    if ! git diff --quiet HEAD -- "$path" 2>/dev/null; then
        return 0
    fi
    if [ -n "$(git status --porcelain "$path" 2>/dev/null)" ]; then
        return 0
    fi
    return 1
}

# Prep：进入仓库根目录、fetch、可选 pull --rebase；Video blob 变化时打印 diff --stat
prep_sync() {
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || {
        echo -e "${RED}❌ 当前目录不是 git 仓库${NC}"
        exit 1
    }
    OSS_STATE_FILE="$REPO_ROOT/.oss_last_upload"
    cd "$REPO_ROOT" || exit 1

    FETCH_OK=false
    local video_blob_pre video_blob_remote
    video_blob_pre=$(git rev-parse "HEAD:$VIDEO_FILE" 2>/dev/null) || true
    video_blob_remote=""

    echo "📥 Prep：与远端同步（fetch + pull --rebase）..."
    if git fetch origin main 2>/dev/null; then
        FETCH_OK=true
        video_blob_remote=$(git rev-parse "origin/main:$VIDEO_FILE" 2>/dev/null) || true
        if [ -n "$video_blob_pre" ] && [ -n "$video_blob_remote" ] && [ "$video_blob_pre" != "$video_blob_remote" ]; then
            echo -e "${CYAN}ℹ️  远端 origin/main 上 $VIDEO_FILE 与本地 HEAD 版本不同（将尝试 rebase 拉取）${NC}"
        fi

        local local_head remote_head
        local_head=$(git rev-parse HEAD 2>/dev/null)
        remote_head=$(git rev-parse origin/main 2>/dev/null)
        if [ -z "$local_head" ] || [ -z "$remote_head" ] || [ "$local_head" = "$remote_head" ]; then
            echo -e "${GREEN}✓ 本地已与 origin/main 一致${NC}"
        elif [ "$DRY_RUN" = "true" ]; then
            echo -e "${CYAN}[DRY RUN] 将执行: git pull --rebase origin main（工作区脏时会先 stash）${NC}"
        else
            local stashed=false
            if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
                echo "  存在未提交修改，临时 stash..."
                if ! git stash push -m "sync.sh temp" 2>/dev/null; then
                    echo -e "${RED}❌ git stash 失败，请先提交或还原本地修改后重试${NC}"
                    exit 1
                fi
                stashed=true
            fi
            if ! git pull --rebase origin main; then
                echo -e "${RED}❌ git pull --rebase 失败（可能存在冲突），请手动解决后重试${NC}"
                if [ "$stashed" = "true" ]; then
                    git stash pop 2>/dev/null || true
                fi
                exit 1
            fi
            echo -e "${GREEN}✓ 已 rebase 到 origin/main 最新 $(git rev-parse --short HEAD)${NC}"
            if [ "$stashed" = "true" ]; then
                if ! git stash pop; then
                    echo -e "${RED}❌ stash pop 冲突，请手动解决后重试${NC}"
                    exit 1
                fi
                echo -e "${GREEN}✓ 已恢复本地未提交修改${NC}"
            fi
            local video_blob_post
            video_blob_post=$(git rev-parse "HEAD:$VIDEO_FILE" 2>/dev/null) || true
            if [ -n "$video_blob_pre" ] && [ -n "$video_blob_post" ] && [ "$video_blob_pre" != "$video_blob_post" ]; then
                echo ""
                echo -e "${BLUE}── $VIDEO_FILE 相对 rebase 前 HEAD 的变更摘要（仅供参考，不写入 commit）──${NC}"
                GIT_PAGER=cat git diff --stat "$video_blob_pre" "$video_blob_post" 2>/dev/null || true
                echo ""
            fi
        fi
    else
        echo -e "${YELLOW}⚠️  无法 fetch origin main，将仅基于本地 HEAD 继续（GitHub/OSS 状态可能滞后）${NC}"
    fi
}

# Block A：仅工单 + CS_KI；有未提交变更则 commit 建议；仅有未 push 则直接 push
# 返回值通过全局变量：GITHUB_RAN_PUSH, GITHUB_STATUS, GITHUB_SKIPPED_REASON, CHANGED_GITHUB_FILES
block_github() {
    GITHUB_RAN_PUSH=false
    GITHUB_STATUS=0
    GITHUB_SKIPPED_REASON=""
    CHANGED_GITHUB_FILES=()

    if file_has_uncommitted_changes "$TICKET_FILE"; then
        CHANGED_GITHUB_FILES+=("$TICKET_FILE")
        echo -e "${GREEN}✓ 检测到 $TICKET_FILE 有未提交变更${NC}"
        GIT_PAGER=cat git diff --stat HEAD -- "$TICKET_FILE" 2>/dev/null || true
    fi
    if file_has_uncommitted_changes "$CSKI_FILE"; then
        CHANGED_GITHUB_FILES+=("$CSKI_FILE")
        echo -e "${GREEN}✓ 检测到 $CSKI_FILE 有未提交变更${NC}"
        GIT_PAGER=cat git diff --stat HEAD -- "$CSKI_FILE" 2>/dev/null || true
    fi

    local unpushed_count=0
    if [ "$FETCH_OK" = "true" ] && git rev-parse origin/main >/dev/null 2>&1; then
        unpushed_count=$(git rev-list --count origin/main..HEAD 2>/dev/null | tr -d ' \n')
        unpushed_count=${unpushed_count:-0}
    fi

    if [ ${#CHANGED_GITHUB_FILES[@]} -eq 0 ] && [ "${unpushed_count:-0}" -eq 0 ]; then
        GITHUB_SKIPPED_REASON="无工单/CS_KI 未提交变更，且无未 push 的本地提交"
        echo -e "${CYAN}⏭ Block A：跳过 GitHub（${GITHUB_SKIPPED_REASON}）${NC}"
        return
    fi

    echo ""
    echo "📌 Block A：GitHub（main）"

    if [ ${#CHANGED_GITHUB_FILES[@]} -gt 0 ]; then
        echo ""
        echo "📝 生成建议的 commit message（仅工单/CS_KI）..."
        local commit_parts=()
        local f
        for f in "${CHANGED_GITHUB_FILES[@]}"; do
            if [ "$f" = "$TICKET_FILE" ]; then
                commit_parts+=("$(generate_ticket_message)")
            elif [ "$f" = "$CSKI_FILE" ]; then
                commit_parts+=("$(generate_cski_message)")
            fi
        done
        local suggested_msg
        if [ ${#commit_parts[@]} -eq 2 ]; then
            suggested_msg="${commit_parts[0]}；${commit_parts[1]}"
        elif [ ${#commit_parts[@]} -eq 1 ]; then
            suggested_msg="${commit_parts[0]}"
        else
            suggested_msg="同步 RAG 知识库"
        fi
        echo ""
        echo "建议的 commit message:"
        echo "  $suggested_msg"
        echo ""

        if [ "$DRY_RUN" = "true" ]; then
            echo -e "${CYAN}[DRY RUN] 将 git add 上述文件并 commit${NC}"
        else
            local user_input
            read -r -p "使用建议的 message? [回车确认 / 输入自定义内容 / n 取消]: " user_input
            if [[ "$user_input" =~ ^[Nn]$ ]]; then
                echo "已取消"
                exit 0
            fi
            local commit_msg
            if [ -z "$user_input" ]; then
                commit_msg="$suggested_msg"
            else
                commit_msg="$user_input"
            fi
            echo ""
            echo "将使用 commit message: $commit_msg"
            echo ""
            echo "📦 Git：add + commit..."
            for f in "${CHANGED_GITHUB_FILES[@]}"; do
                git add "$f"
            done
            git commit -m "$commit_msg"
        fi
    fi

    if [ "$DRY_RUN" = "true" ]; then
        echo -e "${CYAN}[DRY RUN] 将执行: git push origin main（若存在未推送提交）${NC}"
        GITHUB_RAN_PUSH=false
        return
    fi

    echo "📦 Git：push origin main..."
    local git_log="/tmp/sync_git_$$.log"
    if git push origin main > "$git_log" 2>&1; then
        GITHUB_STATUS=0
        rm -f "$git_log"
    else
        GITHUB_STATUS=$?
        echo -e "${RED}❌ git push 失败 (exit $GITHUB_STATUS)${NC}"
        if [ -f "$git_log" ]; then
            sed 's/^/     /' "$git_log"
        fi
    fi
    GITHUB_RAN_PUSH=true
}

# Block B：比较 HEAD blob 与 .oss_last_upload，按需 ossutil cp
block_oss() {
    OSS_TO_UPLOAD=()
    OSS_DRYRUN_UPLOADS=()
    OSS_UPLOADED_FILES=()
    OSS_SKIPPED_FILES=()
    OSS_FAIL_FILES=()
    local f blob stored entry path
    echo ""
    echo "☁️  Block B：阿里云 OSS（增量，状态文件 .oss_last_upload）"

    for f in "${OSS_SYNC_FILES[@]}"; do
        blob=$(get_head_blob "$f")
        if [ -z "$blob" ]; then
            echo -e "${YELLOW}⚠️  跳过（无法得到 blob）: $f${NC}"
            OSS_FAIL_FILES+=("$f")
            continue
        fi
        stored=$(read_oss_state_blob "$f" "$OSS_STATE_FILE")
        if [ "$blob" = "$stored" ]; then
            OSS_SKIPPED_FILES+=("$f")
            echo -e "  ${GREEN}○${NC} $f （与上次 OSS 一致，blob ${blob:0:7}…）"
            continue
        fi
        OSS_TO_UPLOAD+=("$f|$blob")
    done

    if [ ${#OSS_TO_UPLOAD[@]} -eq 0 ]; then
        if [ ${#OSS_FAIL_FILES[@]} -gt 0 ]; then
            echo -e "${RED}❌ 部分文件无法计算 HEAD blob，请确认文件已纳入 git 且路径正确${NC}"
            return 1
        fi
        echo -e "${GREEN}✓ 无需上传：三个 RAG 文件相对上次 OSS 均无变化${NC}"
        return 0
    fi

    echo ""
    echo "以下文件将上传至 OSS（相对 .oss_last_upload 已变化）："
    local entry path b
    for entry in "${OSS_TO_UPLOAD[@]}"; do
        path="${entry%%|*}"
        b="${entry#*|}"
        echo "  - $path  (HEAD blob ${b:0:7}…)"
    done
    echo ""

    if [ "$DRY_RUN" = "true" ]; then
        for entry in "${OSS_TO_UPLOAD[@]}"; do
            OSS_DRYRUN_UPLOADS+=("${entry%%|*}")
        done
        echo -e "${CYAN}[DRY RUN] 将 ossutil cp 上述文件至 $OSS_BUCKET/ ，且不更新 .oss_last_upload${NC}"
        return 0
    fi

    if [ "$AUTO_YES" != "true" ]; then
        local cont
        read -r -p "确认上传到 OSS? [回车确认 / n 取消]: " cont
        if [[ "$cont" =~ ^[Nn]$ ]]; then
            echo "已跳过 OSS 上传"
            return 2
        fi
    fi

    local oss_log="/tmp/sync_oss_$$.log"
    : > "$oss_log"
    local st=0
    for entry in "${OSS_TO_UPLOAD[@]}"; do
        path="${entry%%|*}"
        b="${entry#*|}"
        echo -n "  - $path ... "
        if ossutil cp "$path" "$OSS_BUCKET/$path" -f --endpoint "$OSS_ENDPOINT" >> "$oss_log" 2>&1; then
            echo -e "${GREEN}✅${NC}"
            upsert_oss_state_blob "$path" "$b" "$OSS_STATE_FILE"
            OSS_UPLOADED_FILES+=("$path")
        else
            echo -e "${RED}❌${NC}"
            OSS_FAIL_FILES+=("$path")
            st=1
        fi
    done
    if [ $st -eq 0 ]; then
        rm -f "$oss_log"
    fi
    return $st
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
    
    echo ""
    echo "======== sync.sh v3：Prep → Block A（GitHub）→ Block B（OSS）========"
    echo ""

    prep_sync

    echo ""
    echo "🔍 Block A 前置：检查工单/CS_KI 未提交变更..."
    
    block_github

    echo ""
    block_oss
    local oss_rc=$?

    echo ""
    echo "================================"
    echo "         同步结果报告"
    echo "================================"
    echo ""
    echo -e "${BLUE}Block A（GitHub）${NC}"
    if [ -n "$GITHUB_SKIPPED_REASON" ]; then
        echo "  状态：已跳过"
        echo "  原因：$GITHUB_SKIPPED_REASON"
    elif [ "$DRY_RUN" = "true" ]; then
        echo "  状态：[DRY RUN] 未执行 push"
    elif [ "$GITHUB_RAN_PUSH" = "true" ]; then
        if [ "$GITHUB_STATUS" -eq 0 ]; then
            echo -e "  状态：${GREEN}✅ push 成功${NC}"
            echo "  分支：main"
            echo "  HEAD：$(git log -1 --oneline 2>/dev/null)"
        else
            echo -e "  状态：${RED}❌ push 失败 (exit $GITHUB_STATUS)${NC}"
        fi
    else
        echo "  状态：未执行 push"
    fi

    echo ""
    echo -e "${BLUE}Block B（OSS）${NC}"
    if [ "$DRY_RUN" = "true" ] && [ ${#OSS_DRYRUN_UPLOADS[@]} -gt 0 ]; then
        echo -e "  状态：${CYAN}[DRY RUN] 将上传（相对 .oss_last_upload 有变化）${NC}"
        local df
        for df in "${OSS_DRYRUN_UPLOADS[@]}"; do
            echo "    - $df → $OSS_BUCKET/$df"
        done
    elif [ "$oss_rc" -eq 2 ]; then
        echo -e "  状态：${YELLOW}已跳过（用户取消 OSS 上传）${NC}"
    elif [ "$oss_rc" -ne 0 ]; then
        echo -e "  状态：${RED}❌ 部分或全部上传失败${NC}"
    elif [ ${#OSS_UPLOADED_FILES[@]} -gt 0 ]; then
        echo -e "  状态：${GREEN}✅ 已上传${NC}"
        local uf
        for uf in "${OSS_UPLOADED_FILES[@]}"; do
            echo "    - $uf → $OSS_BUCKET/$uf"
        done
    else
        echo -e "  状态：${GREEN}✓ 无需上传（与 .oss_last_upload 一致）${NC}"
    fi
    if [ ${#OSS_SKIPPED_FILES[@]} -gt 0 ]; then
        echo "  未变化（未传）："
        local sf
        for sf in "${OSS_SKIPPED_FILES[@]}"; do
            echo "    ○ $sf"
        done
    fi
    if [ ${#OSS_FAIL_FILES[@]} -gt 0 ]; then
        echo -e "  ${RED}失败：${NC}"
        local ff
        for ff in "${OSS_FAIL_FILES[@]}"; do
            echo "    ✗ $ff"
        done
    fi

    echo ""
    echo "================================"

    if [ -z "$GITHUB_SKIPPED_REASON" ] && [ "$DRY_RUN" != "true" ] && [ "$GITHUB_RAN_PUSH" = "true" ] && [ "$GITHUB_STATUS" -ne 0 ]; then
        exit 1
    fi
    if [ "$oss_rc" -eq 1 ]; then
        exit 1
    fi
    if [ "$oss_rc" -eq 0 ] || [ "$oss_rc" -eq 2 ]; then
        if [ "$DRY_RUN" = "true" ]; then
            echo -e "${GREEN}✅ [DRY RUN] 流程预览结束（未修改 git / OSS / .oss_last_upload）。${NC}"
        elif [ "$oss_rc" -eq 0 ] && [ ${#OSS_UPLOADED_FILES[@]} -gt 0 ]; then
            echo -e "${GREEN}🎉 同步流程结束。${NC}"
            echo "OSS 新上传文件约 1-2 分钟后在百炼平台自动生效"
        elif [ "$oss_rc" -eq 0 ]; then
            echo -e "${GREEN}🎉 同步流程结束（OSS 无增量）。${NC}"
        else
            echo -e "${YELLOW}流程结束（已跳过 OSS）。${NC}"
        fi
        exit 0
    fi
    exit 1
}

# 运行主程序
main "$@"
