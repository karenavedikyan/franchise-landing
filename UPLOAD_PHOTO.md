# 📸 Инструкция по загрузке фотографии

## Проблема
Файл `images/dmitry-goncharenko.jpg` сейчас является SVG placeholder, а не реальной фотографией.

## Решение

### Вариант 1: Через GitHub веб-интерфейс
1. Откройте: https://github.com/karenavedikyan/franchise-landing/tree/main/images
2. Нажмите "Add file" → "Upload files"
3. Перетащите файл фотографии
4. Назовите файл: `dmitry-goncharenko.jpg`
5. Нажмите "Commit changes"

### Вариант 2: Через терминал
```bash
cd /Users/karenavedikyan/testcursor/franchise/images
# Поместите ваше фото сюда и назовите dmitry-goncharenko.jpg
git add images/dmitry-goncharenko.jpg
git commit -m "Add real photo"
git push origin main
```

### Требования к фото:
- Формат: JPG или PNG
- Размер: минимум 300x300px (квадратное)
- Размер файла: от 50KB до 2MB
- Имя файла: `dmitry-goncharenko.jpg`

## Текущий статус
Сейчас отображается SVG placeholder с инициалами "ДГ" в зеленых тонах Tandoor.
