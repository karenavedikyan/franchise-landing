#!/bin/bash

# Быстрая публикация на GitHub Pages
# Скопируйте и выполните эти команды в терминале

echo "🚀 Публикация лендинга франшизы на GitHub Pages"
echo ""
echo "📋 Инструкция:"
echo "1. Создайте репозиторий на https://github.com/new"
echo "2. Название: franchise-landing (или любое другое)"
echo "3. Выберите Public, НЕ добавляйте README"
echo "4. Нажмите Create repository"
echo ""
read -p "Нажмите Enter после создания репозитория..."

# Запрос GitHub username
read -p "Введите ваш GitHub username: " GITHUB_USER
read -p "Введите имя репозитория (по умолчанию: franchise-landing): " REPO_NAME
REPO_NAME=${REPO_NAME:-franchise-landing}

echo ""
echo "📦 Инициализация git..."
git init
git add .
git commit -m "Initial commit: Franchise landing page"

echo "🔗 Настройка remote..."
git branch -M main
git remote add origin https://github.com/$GITHUB_USER/$REPO_NAME.git

echo "📤 Отправка на GitHub..."
git push -u origin main

echo ""
echo "✅ Файлы отправлены!"
echo ""
echo "📋 Теперь включите GitHub Pages:"
echo "1. Перейдите: https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
echo "2. Source → Deploy from a branch"
echo "3. Branch: main, Folder: / (root)"
echo "4. Save"
echo ""
echo "🌐 Ваш сайт: https://$GITHUB_USER.github.io/$REPO_NAME/"
