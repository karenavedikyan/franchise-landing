#!/bin/bash

# Автоматическое создание репозитория и публикация на GitHub

REPO_NAME="franchise-landing"
GITHUB_USER="karenavedikyan"

echo "🚀 Создание репозитория и публикация лендинга франшизы"
echo ""

# Проверка GitHub CLI
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI найден"
    
    # Проверка аутентификации
    if gh auth status &> /dev/null; then
        echo "✅ GitHub CLI аутентифицирован"
        
        # Создание репозитория
        echo "📦 Создание репозитория $REPO_NAME..."
        gh repo create $REPO_NAME --public --description "Лендинг франшизы - минимализм + доверие + конверсия" --source=. --remote=origin --push 2>&1
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "✅ Репозиторий создан и файлы отправлены!"
            echo ""
            echo "🌐 Репозиторий: https://github.com/$GITHUB_USER/$REPO_NAME"
            echo ""
            echo "📋 Теперь включите GitHub Pages:"
            echo "👉 https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
            echo ""
            echo "Настройки:"
            echo "  - Source: Deploy from a branch"
            echo "  - Branch: main"
            echo "  - Folder: / (root)"
            echo ""
            echo "После включения сайт будет доступен:"
            echo "👉 https://$GITHUB_USER.github.io/$REPO_NAME/"
            exit 0
        fi
    else
        echo "⚠️  GitHub CLI не аутентифицирован"
        echo "Выполните: gh auth login"
    fi
fi

# Если GitHub CLI недоступен, создаем инструкции
echo "📋 GitHub CLI не найден или не аутентифицирован"
echo ""
echo "Создайте репозиторий вручную:"
echo "1. Откройте: https://github.com/new"
echo "2. Название: $REPO_NAME"
echo "3. Выберите Public"
echo "4. НЕ добавляйте README, .gitignore или лицензию"
echo "5. Нажмите Create repository"
echo ""
read -p "Нажмите Enter после создания репозитория..."

# Отправка файлов
echo "📤 Отправка файлов на GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Файлы отправлены!"
    echo ""
    echo "🌐 Репозиторий: https://github.com/$GITHUB_USER/$REPO_NAME"
    echo ""
    echo "📋 Включите GitHub Pages:"
    echo "👉 https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
else
    echo "❌ Ошибка при отправке файлов"
    echo "Проверьте, что репозиторий создан и remote настроен правильно"
fi
