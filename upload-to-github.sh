#!/bin/bash
# ============================================================
# 上传 ultra-remove-ai 到 GitHub
# ============================================================
# 使用前：
#   1. 在 GitHub 上创建一个新仓库（不要勾选 "Add a README"）
#   2. 复制仓库的远程地址，例如：
#      git@github.com:your-username/ultra-remove-ai.git
#      或 https://github.com/your-username/ultra-remove-ai.git
#   3. 运行：./upload-to-github.sh <你的仓库地址>
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

REPO_URL="${1:-}"

if [ -z "$REPO_URL" ]; then
    echo "❌ 请提供 GitHub 仓库地址"
    echo ""
    echo "用法: ./upload-to-github.sh <仓库地址>"
    echo ""
    echo "示例:"
    echo "  ./upload-to-github.sh git@github.com:myuser/ultra-remove-ai.git"
    echo "  ./upload-to-github.sh https://github.com/myuser/ultra-remove-ai.git"
    echo ""
    echo "提示：请先在 GitHub 上创建仓库（不要勾选 Add a README）"
    exit 1
fi

echo "=========================================="
echo "  ultra-remove-ai → GitHub 上传脚本"
echo "=========================================="
echo ""
echo "📂 当前目录: $SCRIPT_DIR"
echo "🔗 远程地址: $REPO_URL"
echo ""

# Step 1: 初始化 git 仓库
if [ -d ".git" ]; then
    echo "⚠️  .git 已存在，跳过 git init"
else
    echo "1️⃣  初始化 git 仓库..."
    git init
    echo "   ✅ git init 完成"
fi

# Step 2: 创建 .gitignore（如果不存在）
if [ ! -f ".gitignore" ]; then
    echo "2️⃣  创建 .gitignore..."
    cat > .gitignore <<'EOF'
# macOS
.DS_Store
.AppleDouble
.LSOverride
Icon
._*
.DocumentRevisions-V100
.fseventsd
.Spotlight-V100
.TemporaryItems
.Trashes
.VolumeIcon.icns
.com.apple.timemachine.donotpresent

# 脚本自身（可选：如果你想保留则删除这行）
# upload-to-github.sh
EOF
    echo "   ✅ .gitignore 创建完成"
else
    echo "2️⃣  .gitignore 已存在，跳过"
fi

# Step 3: 添加所有文件
echo "3️⃣  添加文件到暂存区..."
git add -A
echo "   ✅ 文件已添加"

# Step 4: 提交
echo "4️⃣  提交..."
git commit -m "feat: 初始提交 — ultra-remove-ai 去AI痕迹改写技能

- 13个专业编辑角色（商业分析/产品测评/技术/自媒体/职场/品牌/小说/随笔/社媒/科普/视频/演讲/通用）
- 共享改写技法（14招 + 节奏法则 + 通用词汇清洗表 + 质量自检）
- 自动文本分类匹配 + 角色化重写

Co-Authored-By: Claude <noreply@anthropic.com>" 2>&1 || {
    echo "   ℹ️  没有可提交的变更（可能已经提交过了）"
}

# Step 5: 添加远程仓库
echo "5️⃣  配置远程仓库..."
if git remote get-url origin 2>/dev/null; then
    echo "   ⚠️  remote 'origin' 已存在，更新为新的地址..."
    git remote set-url origin "$REPO_URL"
else
    git remote add origin "$REPO_URL"
fi
echo "   ✅ remote origin → $REPO_URL"

# Step 6: 推送
echo "6️⃣  推送到 GitHub..."
echo ""
echo "   正在推送...（可能需要输入密码或 SSH 密钥口令）"
echo ""

# 获取当前分支名
BRANCH=$(git branch --show-current)
BRANCH="${BRANCH:-main}"

git push -u origin "$BRANCH"

echo ""
echo "=========================================="
echo "  ✅ 上传完成！"
echo "=========================================="
echo ""
echo "📦 仓库地址: $REPO_URL"
echo "🌿 分支: $BRANCH"
echo ""
