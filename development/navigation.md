---
layout: default
title: navigation development
---

# Navigation development

Эта статья описывает реализацию меню с нуля в чистом Jekyll-репозитории.

Цель — получить статическую навигацию, которая автоматически следует дереву Markdown-файлов, не требует отдельного manifest меню и не ограничивает глубину вложенности.

## 1. Создать чистый репозиторий

Минимальная структура:

    .
    ├── _config.yml
    ├── _includes/
    │   └── nav.html
    ├── _layouts/
    │   └── default.html
    ├── index.md
    └── section/
        ├── index.md
        └── page.md

В `_config.yml` достаточно определить permalink и Markdown-конвертер:

    title: Example
    permalink: /:path/:basename.html
    markdown: kramdown

## 2. Определить контракт страницы

Каждая публичная Markdown-страница должна иметь непустой `title`:

    ---
    layout: default
    title: section
    ---

Без этого страницу нельзя надёжно использовать как пункт автоматически построенного меню.

## 3. Нормализовать имя узла

Для меню URL не используется как структура данных.

Используется путь исходной страницы:

    page.path

Нормализация:

    foo.md       → foo
    foo/index.md → foo
    index.md     → пустая строка
    index.html   → пустая строка

Корневая страница этого репозитория — `index.html`, поэтому она нормализуется отдельно.

В Liquid это можно выразить так:

    {% raw %}{% assign node = p.path | remove: ".md" | remove: "/index" %}{% endraw %}

Так `foo/index.md` и логический узел `foo` становятся одним объектом.

## 4. Вычислить непосредственного родителя

У нормализованного пути последний компонент — имя текущего узла.

Например:

    reference/navigation

разбивается на:

    reference
    navigation

Удаление последнего компонента даёт:

    reference

В Liquid массив можно обработать фильтром `pop`:

    {% raw %}{% assign parts = node | split: "/" %}
    {% assign parent_parts = parts | pop %}
    {% assign parent = parent_parts | join: "/" %}{% endraw %}

Для верхнего уровня результатом будет пустая строка.

## 5. Построить первую колонку

Для текущей страницы вычисляются:

    current
    current_parent

Первая колонка выбирает все страницы, у которых:

    parent == current_parent

Например, для:

    audio/aliceffekt

первая колонка содержит:

    aliceffekt
    generative
    machines
    offline

если все эти узлы являются непосредственными детьми `audio`.

Текущая страница получает:

    class="self"

## 6. Построить вторую колонку

Вторая колонка выбирает:

    parent == current

Для:

    audio/aliceffekt

это будут непосредственные страницы и разделы внутри:

    audio/aliceffekt/

Если детей нет, вторая колонка не выводится.

## 7. Полный шаблон

Минимальная реализация `_includes/nav.html`:

    {% raw %}{% assign current = page.path | remove: ".md" | remove: ".html" | remove: "/index" %}
    {% if current == "index" %}{% assign current = "" %}{% endif %}
    {% assign current_parts = current | split: "/" %}
    {% assign current_parent_parts = current_parts | pop %}
    {% assign current_parent = current_parent_parts | join: "/" %}

    <nav>
      <ul>
        {% for p in site.pages %}
          {% if p.title and p.title != "" %}
            {% assign node = p.path | remove: ".md" | remove: ".html" | remove: "/index" %}
            {% if node == "index" %}{% assign node = "" %}{% endif %}
            {% assign parts = node | split: "/" %}
            {% assign parent_parts = parts | pop %}
            {% assign parent = parent_parts | join: "/" %}

            {% if parent == current_parent %}
              <li>
                <a href="{{ p.url | relative_url }}"{% if node == current %} class="self"{% endif %}>{{ p.title }}</a>
              </li>
            {% endif %}
          {% endif %}
        {% endfor %}
      </ul>

      {% unless current == "" %}
        <ul>
          {% for p in site.pages %}
            {% if p.title and p.title != "" %}
              {% assign node = p.path | remove: ".md" | remove: ".html" | remove: "/index" %}
              {% if node == "index" %}{% assign node = "" %}{% endif %}
              {% assign parts = node | split: "/" %}
              {% assign parent_parts = parts | pop %}
              {% assign parent = parent_parts | join: "/" %}

              {% if parent == current %}
                <li>
                  <a href="{{ p.url | relative_url }}">{{ p.title }}</a>
                </li>
              {% endif %}
            {% endif %}
          {% endfor %}
        </ul>
      {% endunless %}
    </nav>{% endraw %}

Шаблон намеренно не является рекурсивным.

Рекурсия здесь была бы неправильной моделью представления: дерево контента может быть глубоким, но меню показывает только локальный контекст.

## 8. Подключить меню

В основном layout:

    <body>
    <header>...</header>

    {% raw %}{% include nav.html %}{% endraw %}

    <main>
    {{ content }}
    </main>
    </body>

Никакого JavaScript для построения меню не требуется.

## 9. Сделать две колонки визуально

Минимальный CSS:

    nav {
      padding:45px 30px;
      margin:0;
    }

    nav ul {
      padding:0;
      margin:0 45px 0 0;
      display:inline-block;
      vertical-align:top;
    }

    nav ul li {
      list-style-type:none;
      white-space:pre;
    }

    nav ul li a {
      padding:0 4px;
    }

    nav ul li a.self {
      text-decoration:underline;
    }

Таким образом HTML остаётся обычным списком, а колонка является только способом его размещения.

## 10. Проверить произвольную глубину

Создать тест:

    test/
        index.md
        level-01/
            index.md
            level-02/
                index.md
                level-03/
                    index.md

и продолжить его до требуемой глубины.

Для проверки именно алгоритма полезно создать не менее 60 уровней.

На странице:

    test/level-01/.../level-60/

должно выполняться то же правило, что и на странице второго или третьего уровня:

    column 1 = siblings
    column 2 = children

Никакой специальной ветки для `level-60` не должно существовать.

## 11. Проверить крайние случаи

### Корень

Для `index.md`:

    current = ""
    current_parent = ""

Первая колонка содержит верхний уровень.

Вторая колонка не нужна.

### Верхний раздел

Для:

    audio/index.md

первая колонка содержит другие верхнеуровневые разделы и `audio`, а вторая — непосредственных детей `audio`.

### Обычная страница

Для:

    audio/aliceffekt/notes.md

первая колонка содержит соседей внутри `audio/aliceffekt/`.

Вторая колонка отсутствует, если у `notes` нет детей.

### Глубокая страница

Для:

    level-01/.../level-60/index.md

первая колонка определяется только непосредственным родителем.

Количество предшествующих уровней не имеет значения.

## 12. Проверять результат на HTML, а не только на сборке

Успешный Jekyll build означает только то, что генератор смог построить сайт.

Для меню отдельно проверяются:

    <nav>
      <ul>...</ul>
      <ul>...</ul>
    </nav>

и отсутствие:

    <ul>
      <li>
        <ul>
          <li>
            ...

если вложенность не предусмотрена дизайном.

Также проверяется:

- текущая ссылка;
- отсутствие пустых пунктов;
- корректность `href`;
- наличие только публичных страниц;
- отсутствие циклического include;
- отсутствие лишних колонок;
- корректная работа на глубоком тестовом узле.

## 13. Почему эта реализация лучше рекурсивного дерева

Рекурсивный шаблон естественно моделирует дерево:

    node
      └── children
            └── children
                  └── ...

Но референсное меню не является раскрытым деревом.

Оно является **локальным срезом дерева**:

    siblings(current)
    children(current)

Поэтому прямой двухколоночный алгоритм:

- проще;
- не требует рекурсивного include;
- не создаёт вложенных `ul`;
- не зависит от максимальной глубины;
- проще проверяется;
- лучше соответствует CSS-модели.

## 14. Правило сопровождения

При добавлении новой страницы разработчик не должен редактировать меню.

Достаточно создать страницу в правильном каталоге:

    development/
        new-topic.md

с корректным front matter:

    ---
    layout: default
    title: new topic
    ---

После сборки она автоматически появляется в соответствующей локальной колонке.

Если изменение структуры страницы требует правки `nav.html`, это повод проверить сам алгоритм: структура контента должна оставаться источником истины.

## Итог

Минимальная архитектура состоит из трёх частей:

    filesystem
        ↓
    site.pages
        ↓
    siblings + children
        ↓
    two <ul> columns
        ↓
    CSS inline-block

Глубина дерева не кодируется в шаблоне.

Количество колонок не кодируется в дереве.

Именно это разделение позволяет воспроизвести модель в чистом репозитории без ручного меню и без JavaScript.
