---
layout: default
title: navigation development
---

# Navigation development

Эта статья описывает воспроизводимую реализацию навигации XXIIVV/Oscean в чистом Jekyll-репозитории.

Важно: референсное меню — не двухколоночное `siblings + children`. На глубине 2+ оно показывает три локальные группы:

    siblings(parent)
    siblings(current)
    children(current)

Именно эту модель нужно воспроизводить.

## 1. Что является референсом

Живой сайт:

    https://wiki.xxiivv.com/site/home.html

Описание движка:

    https://wiki.xxiivv.com/site/oscean.html

В исходнике Oscean соответствующая логика находится в:

    src/oscean.tal

Ключевые процедуры:

    page/<build-nav>
    page/<build-children>
    html/<local>

`page/<build-nav>` выбирает, сколько групп построить в зависимости от глубины текущего терма.

`page/<build-children>` печатает одну группу как обычный `ul`.

`html/<local>` создаёт ссылку и добавляет `self` для текущего терма и `parent` для его родителя.

## 2. Создать чистый репозиторий

Минимальная структура:

    .
    ├── _config.yml
    ├── _includes/
    │   ├── nav.html
    │   └── style.css
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

## 3. Определить узлы дерева

Каждая публичная страница должна иметь непустой `title`:

    ---
    layout: default
    title: section
    ---

Каталог становится навигационным узлом только тогда, когда существует его публичная страница:

    section/index.md

Обычная страница внутри узла:

    section/page.md

Отдельный manifest меню не создаётся.

## 4. Нормализовать путь

Для Jekyll-реплики используется `page.path`.

Нормализация:

    foo.md       → foo
    foo/index.md → foo
    index.md     → ""
    index.html   → ""

Пример Liquid:

    {% raw %}{% assign node = p.path | remove: ".md" | remove: ".html" | remove: "/index" %}
    {% if node == "index" %}
      {% assign node = "" %}
    {% endif %}{% endraw %}

После этого `section/index.md` становится логическим узлом `section`.

## 5. Вычислить текущий путь и родителей

Для текущего узла:

    current
    current_parent
    current_grandparent

Например:

    reference/navigation-depth/level-01

даёт:

    current            = reference/navigation-depth/level-01
    current_parent     = reference/navigation-depth
    current_grandparent = reference

В Liquid:

    {% raw %}{% assign current_parts = current | split: "/" %}
    {% assign current_parent_parts = current_parts | pop %}
    {% assign current_parent = current_parent_parts | join: "/" %}

    {% assign current_grandparent_parts = current_parent_parts | pop %}
    {% assign current_grandparent = current_grandparent_parts | join: "/" %}{% endraw %}

## 6. Построить группы по глубине

Это центральное правило.

### Root

Для корневой страницы:

    current = ""

выводятся:

    children(root)

### Depth 1

Для узла верхнего уровня:

    children(root)
    children(current)

### Depth 2+

Для любого более глубокого узла:

    children(grandparent)
    children(parent)
    children(current)

Количество данных уровней может быть любым. Число визуальных групп — максимум три.

## 7. Что такое children

Для узла `X`:

    children(X) = все публичные страницы N,
                 для которых parent(N) == X

Для каждой группы создаётся отдельный соседний `ul`.

Не делать:

    <ul>
      <li>
        <ul>...</ul>
      </li>
    </ul>

для имитации колонок.

Должно быть:

    <nav>
      <ul>...</ul>
      <ul>...</ul>
      <ul>...</ul>
    </nav>

## 8. Состояния self и parent

Текущая страница получает:

    class="self"

Её непосредственный родитель получает:

    class="parent"

Пример для:

    audio/aliceffekt

группа соседей содержит:

    audio
    ...

Если `audio` является непосредственным родителем, ссылка на `audio` получает:

    class="parent"

Сама `aliceffekt` получает:

    class="self"

Это соответствует Oscean `html/<local>` и CSS:

    nav ul li a.parent,
    nav ul li a.self {
      text-decoration:underline;
    }

## 9. Реализовать Liquid

Псевдокод:

    {% raw %}current = normalize(page.path)
    parent = parent(current)
    grandparent = parent(parent)

    if current == "":
        groups = [children(root)]
    elsif parent == "":
        groups = [
            children(root),
            children(current)
        ]
    else:
        groups = [
            children(grandparent),
            children(parent),
            children(current)
        ]
    endif{% endraw %}

Liquid не предоставляет удобный способ создать массив групп и пройти его как обычную структуру, поэтому на практике три `ul` пишутся явно с условиями. Это не рекурсия и не отдельная модель данных.

## 10. Подключить меню

В layout:

    <body>
    <header>...</header>

    {% raw %}{% include nav.html %}{% endraw %}

    <main>
    {{ content }}
    </main>

    <footer>...</footer>
    </body>

Базовая навигация не требует JavaScript.

## 11. CSS референса

Основные правила:

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

    nav ul li a.parent,
    nav ul li a.self {
      text-decoration:underline;
    }

Колонка — следствие `inline-block`, а не отдельный layout-компонент.

## 12. Тестировать реальное дерево

Создать:

    test/
        index.md
        level-01/
            index.md
            level-02/
                index.md
                level-03/
                    index.md

Продолжить хотя бы до 60 уровней.

Проверять нужно страницы разных глубин:

    /
    /test/
    /test/level-01/
    /test/level-01/level-02/
    ...
    /test/.../level-60/

Особенно важен глубокий узел: он должен показывать ровно три локальные группы, если у текущего узла есть дети.

## 13. Проверять HTML

Успешный Jekyll build недостаточен.

Проверить:

    <nav>
      <ul>...</ul>
      <ul>...</ul>
      <ul>...</ul>
    </nav>

И состояния:

    class="parent"
    class="self"

Проверить также:

- `href` ведут на существующие страницы;
- пустые `ul` не выводятся;
- внутри navigation нет вложенных `ul`;
- нет JavaScript для построения меню;
- нет фиксированного ограничения глубины;
- на root не выводится сам root как пункт.

## 14. Что было ошибочно в предыдущей версии

Предыдущая документация описывала модель как:

    siblings(current)
    children(current)

и поэтому фактически теряла контекст родителя на глубине 2+.

Референс Oscean делает иначе:

    children(grandparent)
    children(parent)
    children(current)

Кроме того, предыдущая версия не воспроизводила состояние:

    class="parent"

Это влияет не только на HTML, но и на визуальное подчёркивание активной ветви.

## 15. Правило сопровождения

Разработчик не редактирует меню при добавлении страницы.

Достаточно создать узел в дереве:

    development/
        new-topic.md

с корректным front matter.

Структура исходников остаётся единственным источником истины. Если для добавления страницы требуется изменение `nav.html`, сначала нужно проверить алгоритм и модель дерева.

## Итог

Минимальная архитектура:

    filesystem
        ↓
    site.pages
        ↓
    current / parent / grandparent
        ↓
    children(grandparent)
    children(parent)
    children(current)
        ↓
    1–3 соседних <ul>
        ↓
    inline-block CSS

Это реплика именно модели Oscean, а не абстрактного многоуровневого sidebar.
