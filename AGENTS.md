# AGENTS.md - Repository Guidelines

This is a **documentation/knowledge base repository** containing customer support ticket data and known issues for Agora SDK products.

## Repository Structure

This repo contains RAG (Retrieval-Augmented Generation) training data:
- `工单训练 RAG 集.md` - Support tickets with Q&A pairs
- `CS_KI_RAG优化版.md` - Known issues database
- `RTC_SDK_错误码_RAG优化版.md` - Error code documentation
- `*.canvas` - Obsidian canvas files (visual diagrams)
- `error_code.h` - C header with error codes

## Build/Test Commands

**No build system** - This is a documentation repository.

Validation commands available:
```bash
# Check for broken markdown links (if md linter installed)
find . -name "*.md" -exec markdown-link-check {} \;

# Preview markdown formatting
mdv "工单训练 RAG 集.md"
```

## Code Style Guidelines

### File Naming
- Use **Chinese filenames** with spaces for main documents
- Format: `{描述} {类型}.{扩展名}` (e.g., `工单训练 RAG 集.md`)
- Keep original filenames when updating existing files

### Document Structure

**Support Tickets** (`工单训练 RAG 集.md`):
```markdown
# ID: {number}

SDK Product: {RTC|RTM|...}

SDK Platform: {Android|iOS|Unity|所有平台|...}

SDK Version: {version|所有版本}

Request Type: {集成问题|效果不佳|不达预期|其他问题|...}

Request Description: {问题描述}

Reply: {客服回复}

---
```

**Known Issues** (`CS_KI_RAG优化版.md`):
```markdown
# CS_KI_{ID}
问题ID:{ID}  
问题描述: {详细描述}  
影响范围: {版本范围}  
影响平台: {平台}  
修复方案及进展: {解决方案}

---
```

### Formatting Rules

1. **Separators**: Use `---` on its own line between entries
2. **Line Endings**: Use Unix line endings (LF)
3. **Encoding**: UTF-8 for Chinese characters
4. **Headers**: Use `#` for entry IDs, no sub-headers within entries
5. **Lists**: Use standard markdown lists for multi-item replies
6. **Code Blocks**: Use triple backticks with language identifier:
   ```markdown
   ```java
   // code here
   ```
   ```

### Content Guidelines

1. **Preserve Original Content**: Do not modify existing ticket data
2. **Append Only**: Add new entries at the end of files
3. **ID Uniqueness**: Ensure new IDs don't conflict with existing ones
4. **Consistency**: Follow existing formatting patterns exactly
5. **Links**: Use markdown format `[text](url)` for hyperlinks
6. **SDK Versions**: Use standard format (e.g., `4.6.2`, `4.5.2.6`)

### Git Workflow

```bash
# Stage changes
git add "文件名.md"

# Commit with descriptive message
git commit -m "Add tickets {ID range} to 工单训练 RAG 集"

# Or for known issues
git commit -m "Update CS_KI entries for RTC Android v4.6.x"
```

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
- 删除或修改超过 10 个条目时，将只显示数量而非具体 ID（如：`删除 15 条工单`）
- 检测基于条目内容哈希，忽略格式变化（空格、换行）
- 首次提交时所有条目标记为新增

### Sensitive Data

**DO NOT commit** (already in `.gitignore`):
- `CS_KI.json`
- `error_code.h`
- `MCP_SERVER_V3_API.md`
- `云服务砖家提示词.md`
- `.env` files

### Naming Conventions

- **Entry IDs**: Use numeric format for tickets (e.g., `10`, `39194`), use `CS_KI_{XXX}` for known issues
- **SDK Products**: Use uppercase abbreviations (RTC, RTM, FPA)
- **Platforms**: Use standard names (Android, iOS, Unity, macOS, Windows, Web, Electron, Flutter, React Native)
- **Version Format**: Use dot-separated version numbers (4.6.2, 4.5.2.6)
- **Request Types**: Use consistent categories (集成问题, 效果不佳, 不达预期, 其他问题, 功能咨询)

### Error Handling

- **Broken Links**: Verify all hyperlinks are accessible before committing
- **Encoding Issues**: Ensure Chinese characters display correctly in UTF-8
- **ID Conflicts**: Check for duplicate IDs before adding new entries
- **Format Validation**: Ensure `---` separators exist between all entries

### Testing Documentation

While there's no code to test, verify:
```bash
# Check file encoding
file "工单训练 RAG 集.md"

# Count entries
grep -c "^# ID:" "工单训练 RAG 集.md"
grep -c "^# CS_KI_" CS_KI_RAG优化版.md

# Verify no broken separators
grep -v "^---$" "工单训练 RAG 集.md" | grep "---"
```

## AI Agent Instructions

When editing this repository:
1. Always read existing file format before adding new entries
2. Maintain exact separator and field naming conventions
3. Use Chinese for user-facing content (descriptions, replies)
4. Keep technical terms in English (SDK methods, class names, error codes)
5. Validate markdown syntax after edits
6. Run `git diff` before committing to review changes
7. Never delete or modify existing ticket data
8. Add entries in chronological order when possible
