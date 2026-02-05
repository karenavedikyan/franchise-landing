#!/bin/bash

# Скрипт для публикации лендинга на GitHub Pages

echo "🚀 Публикация лендинга франшизы на GitHub Pages"
echo ""

# Проверка наличия git
if ! command -v git &> /dev/null; then
    echo "❌ Git не установлен. Установите Git и попробуйте снова."
    exit 1
fi

# Проверка наличия GitHub CLI (опционально)
if command -v gh &> /dev/null; then
    echo "✅ GitHub CLI найден"
    USE_GH_CLI=true
else
    echo "⚠️  GitHub CLI не найден. Будет использован стандартный git."
    USE_GH_CLI=false
fi

# Инициализация git репозитория (если еще не инициализирован)
if [ ! -d .git ]; then
    echo "📦 Инициализация git репозитория..."
    git init
    git branch -M main
fi

# Добавление всех файлов
echo "📝 Добавление файлов..."
git add .

# Коммит
echo "💾 Создание коммита..."
git commit -m "Deploy franchise landing page to GitHub Pages" || echo "⚠️  Нет изменений для коммита"

# Запрос имени репозитория
if [ -z "$1" ]; then
    read -p "Введите имя репозитория (например: franchise-landing): " REPO_NAME
else
    REPO_NAME=$1
fi

# Запрос GitHub username
if [ -z "$2" ]; then
    read -p "Введите ваш GitHub username: " GITHUB_USER
else
    GITHUB_USER=$2
fi

# Проверка remote
if git remote get-url origin &> /dev/null; then
    echo "✅ Remote уже настроен"
else
    echo "🔗 Настройка remote..."
    git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git
fi

# Создание репозитория через GitHub CLI (если доступен)
if [ "$USE_GH_CLI" = true ]; then
    echo "🔨 Создание репозитория через GitHub CLI..."
    gh repo create $REPO_NAME --public --source=. --remote=origin --push 2>/dev/null || {
        echo "⚠️  Репозиторий уже существует или ошибка создания"
        echo "📤 Отправка изменений..."
        git push -u origin main || git push
    }
else
    echo "📤 Отправка изменений..."
    echo "⚠️  Убедитесь, что репозиторий $REPO_NAME создан на GitHub!"
    read -p "Нажмите Enter после создания репозитория на GitHub..."
    git push -u origin main || git push
fi

echo ""
echo "✅ Файлы отправлены на GitHub!"
echo ""
echo "📋 Следующие шаги:"
echo "1. Перейдите в Settings репозитория: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "2. В разделе 'Source' выберите 'Deploy from a branch'"
echo "3. Выберите ветку 'main' и папку '/' (root)"
echo "4. Нажмите 'Save'"
echo ""
echo "🌐 Ваш сайт будет доступен по адресу:"
echo "   https://$GITHUB_USER.github.io/$REPO_NAME/"
echo ""
