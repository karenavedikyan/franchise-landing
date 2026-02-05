# 🤖 Автоматическое создание репозитория

Для автоматического создания репозитория на GitHub нужен Personal Access Token.

## Быстрый способ:

### Вариант 1: Используйте скрипт с токеном

```bash
cd /Users/karenavedikyan/testcursor/franchise
GITHUB_TOKEN=your_token_here ./create_repo_with_token.sh
```

Или просто запустите скрипт - он запросит токен:
```bash
./create_repo_with_token.sh
```

### Вариант 2: Создайте токен и используйте

1. **Создайте токен:**
   - Откройте: https://github.com/settings/tokens
   - Нажмите "Generate new token (classic)"
   - Название: "Franchise Landing"
   - Права: выберите **repo**
   - Нажмите "Generate token"
   - Скопируйте токен

2. **Используйте токен:**
   ```bash
   export GITHUB_TOKEN=your_token_here
   ./create_repo_with_token.sh
   ```

### Вариант 3: Установите GitHub CLI

```bash
# macOS
brew install gh

# Затем авторизуйтесь
gh auth login

# Создайте репозиторий
gh repo create franchise-landing --public --source=. --remote=origin --push
```

## После создания репозитория:

1. Включите GitHub Pages:
   👉 https://github.com/karenavedikyan/franchise-landing/settings/pages
   - Source: Deploy from a branch
   - Branch: main
   - Folder: / (root)

2. Сайт будет доступен:
   ```
   https://karenavedikyan.github.io/franchise-landing/
   ```
