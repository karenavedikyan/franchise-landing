#!/bin/bash

# Автоматическая отправка после создания репозитория

echo "🚀 Автоматическая публикация на GitHub"
echo ""

REPO_NAME="franchise-landing"
GITHUB_USER="karenavedikyan"

# Проверка remote
if git remote get-url origin &> /dev/null; then
    REMOTE_URL=$(git remote get-url origin)
    echo "✅ Remote настроен: $REMOTE_URL"
else
    echo "🔗 Настройка remote..."
    git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git
fi

# Попытка отправить
echo "📤 Отправка файлов на GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Успешно опубликовано!"
    echo ""
    echo "🌐 Репозиторий: https://github.com/$GITHUB_USER/$REPO_NAME"
    echo ""
    echo "📋 Включите GitHub Pages:"
    echo "👉 https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
    echo ""
    echo "Настройки:"
    echo "  - Source: Deploy from a branch"
    echo "  - Branch: main"
    echo "  - Folder: / (root)"
    echo ""
    echo "После включения сайт будет доступен:"
    echo "👉 https://$GITHUB_USER.github.io/$REPO_NAME/"
else
    echo ""
    echo "⚠️  Репозиторий еще не создан на GitHub"
    echo ""
    echo "📋 Создайте репозиторий:"
    echo "1. Откройте: https://github.com/new"
    echo "2. Название: $REPO_NAME"
    echo "3. Public"
    echo "4. НЕ добавляйте README"
    echo "5. Нажмите Create repository"
    echo ""
    echo "Затем запустите этот скрипт снова:"
    echo "  ./auto_push.sh"
fi
