#!/bin/bash

# Создание репозитория с использованием токена

echo "🚀 Создание репозитория franchise-landing на GitHub"
echo ""

REPO_NAME="franchise-landing"
GITHUB_USER="karenavedikyan"

# Запрос токена
if [ -z "$GITHUB_TOKEN" ]; then
    echo "📋 Для создания репозитория нужен GitHub Personal Access Token"
    echo ""
    echo "Создайте токен:"
    echo "1. Откройте: https://github.com/settings/tokens"
    echo "2. Нажмите 'Generate new token (classic)'"
    echo "3. Выберите права: repo"
    echo "4. Скопируйте токен"
    echo ""
    read -sp "Введите токен: " GITHUB_TOKEN
    echo ""
fi

if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ Токен не введен"
    exit 1
fi

# Создание репозитория через API
echo "📦 Создание репозитория..."

RESPONSE=$(curl -s -w "\n%{http_code}" -X POST \
  "https://api.github.com/user/repos" \
  -H "Authorization: token $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Content-Type: application/json" \
  -d "{
    \"name\": \"$REPO_NAME\",
    \"description\": \"Лендинг франшизы - минимализм + доверие + конверсия\",
    \"private\": false,
    \"auto_init\": false
  }")

HTTP_CODE=$(echo "$RESPONSE" | tail -n1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "201" ]; then
    echo "✅ Репозиторий создан успешно!"
    REPO_URL=$(echo "$BODY" | python3 -c "import sys, json; print(json.load(sys.stdin)['html_url'])" 2>/dev/null)
    echo "🌐 URL: $REPO_URL"
    echo ""
    echo "📤 Отправка кода..."
    git push -u origin main
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "✅ Код успешно отправлен!"
        echo ""
        echo "📋 Включите GitHub Pages:"
        echo "👉 https://github.com/$GITHUB_USER/$REPO_NAME/settings/pages"
        echo ""
        echo "Настройки:"
        echo "  - Source: Deploy from a branch"
        echo "  - Branch: main"
        echo "  - Folder: / (root)"
    fi
elif [ "$HTTP_CODE" = "422" ]; then
    if echo "$BODY" | grep -q "already exists"; then
        echo "ℹ️  Репозиторий уже существует"
        echo "📤 Отправка кода..."
        git push -u origin main
    else
        echo "❌ Ошибка создания репозитория:"
        echo "$BODY" | python3 -c "import sys, json; print(json.load(sys.stdin).get('message', 'Unknown error'))" 2>/dev/null || echo "$BODY"
    fi
else
    echo "❌ Ошибка HTTP $HTTP_CODE:"
    echo "$BODY" | head -5
fi
