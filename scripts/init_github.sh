#!/bin/bash
# Script d'initialisation Git et préparation GitHub
# LLMUI Core v2.0

cd ~/Bureau/projet/llmui-core

# ============================================================================
# ÉTAPE 1: CORRECTIONS PRÉALABLES
# ============================================================================

echo "📝 第 1 步：预先修正..."

# 1.1 Créer config.yaml.example
cp config.yaml config.yaml.example
echo "✅ 已创建 config.yaml.example"

# 1.2 Corriger les modèles dans config.yaml
sed -i 's/- "gemma2:2b"/- "granite3.1:2b"/' config.yaml
sed -i 's/- "qwen2.5:4b"/- "qwen2.5:3b"/' config.yaml
sed -i 's/merger_model: "qwen2.5:8b"/merger_model: "mistral:7b"/' config.yaml
sed -i 's/simple_model: "qwen2.5:8b"/simple_model: "qwen2.5:3b"/' config.yaml
echo "✅ 已修正 config.yaml 中的 Ollama 模型配置"

# 1.3 Ajouter config.yaml au .gitignore
if ! grep -q "^config.yaml$" .gitignore; then
    sed -i '/# Configuration (local)/a config.yaml' .gitignore
    echo "✅ 已将 config.yaml 添加到 .gitignore"
fi

# 1.4 Retirer !config.yaml
sed -i '/^!config\.yaml$/d' .gitignore
echo "✅ 已清理 .gitignore"

echo ""

# ============================================================================
# ÉTAPE 2: CONFIGURATION GIT
# ============================================================================

echo "📝 第 2 步：配置 Git..."

git config --global user.name "François Chalut"
git config --global user.email "contact@llmui.org"
echo "✅ 已配置 Git 身份信息"

git init
echo "✅ 已初始化 Git 仓库"

git branch -M main
echo "✅ 已创建 main 分支"

echo ""

# ============================================================================
# ÉTAPE 3: PREMIER COMMIT
# ============================================================================

echo "📝 第 3 步：首次提交..."

git add .
echo "✅ 已添加文件到暂存区"

git commit -m "Initial commit - LLMUI Core v2.0.0

🎉 Premier commit du projet LLMUI Core v2.0

✨ Fonctionnalités:
- Mode Simple: Conversation directe avec un LLM
- Mode Consensus: Fusion intelligente de plusieurs modèles
- Mémoire hybride avec compression
- Support multi-fichiers avec drag & drop
- Persistance SQLite
- Support SSL/HTTPS
- Interface bilingue FR/EN (i18n)
- Installation guidée avec interface UI
- Tests automatiques complets (70+ tests)

📦 Structure:
- Backend FastAPI (src/)
- Interface web moderne (web/)
- Scripts d'installation (scripts/)
- Documentation complète (docs/)
- Tests unitaires (tests/)
- Exemples d'utilisation (examples/)

🔧 Technologies:
- Python 3.8+ avec FastAPI
- SQLite pour la persistance
- Ollama pour les LLMs locaux
- JavaScript vanilla avec i18n
- CSS moderne avec dark mode

👤 Auteur: François Chalut
🌐 Website: https://llmui.org
📧 Email: contact@llmui.org
📜 Licence: MIT"

echo "✅ 已创建首次提交"
echo ""

# ============================================================================
# RÉSUMÉ
# ============================================================================

echo "═══════════════════════════════════════════════════════════"
echo "  ✅ 初始化完成"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "📊 统计信息："
echo "   已提交文件数：$(git ls-files | wc -l)"
echo ""
echo "📌 下一步："
echo ""
echo "1️⃣  在 GitHub 创建仓库："
echo "   https://github.com/new"
echo "   - Name：llmui-core"
echo "   - Public（公开）"
echo "   - 不要用 README 初始化（避免冲突）"
echo ""
echo "2️⃣  关联远程并推送（把 YOUR_USERNAME 替换成你的用户名）："
echo ""
echo "   git remote add origin https://github.com/YOUR_USERNAME/llmui-core.git"
echo "   git push -u origin main"
echo ""
echo "3️⃣  在 GitHub 添加 topics："
echo "   llm, ollama, ai, consensus, fastapi, python, i18n, sqlite"
echo ""
echo "4️⃣  创建 release v2.0.0"
echo ""
echo "═══════════════════════════════════════════════════════════"
