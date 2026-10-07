---
layout: default
title: navigation
---

# Navigation

Навигация в референсе XXIIVV — не отдельное меню и не раскрытое дерево. Это локальный срез дерева терминов, который Oscean вычисляет для каждой страницы из отношения parent/child.

Исходник механизма находится в `src/oscean.tal`, в процедурах `page/<build-nav>`, `page/<build-children>` и `html/<local>`.

## Что показывает референс

Для страницы строятся до трёх соседних `ul`:

    column 1 = siblings(parent)
    column 2 = siblings(current)
    column 3 = children(current)

В терминах дерева:

    grandparent
      ├── parent        ← column 1
      │   ├── current   ← column 2
      │   └── sibling
      └── other-parent

При малой глубине часть колонок естественно отсутствует.

### Корень

Для `home` показываются его непосредственные дети:

    audio
    visual
    research
    about

### Глубина 1

Для `about`:

    column 1 = siblings(about)
    column 2 = children(about)

То есть сначала `audio / visual / research / about`, затем `meta / devine lu linvega / hundred rabbits / merveilles`.

### Глубина 2+

Для `uxntal` референс показывает:

    column 1 = uxn / rejoice / forth / postscript
    column 2 = uxntal / varvara / uxn devlog
    column 3 = uxntal stacks / uxntal notation / ...

Это непосредственно соответствует вызовам Oscean: для глубины 2+ сначала строятся дети grandparent, затем дети parent, затем дети current.

## HTML

Колонки — не вложенные списки:

    <nav>
      <ul>
        <li><a href="...">...</a></li>
      </ul>
      <ul>
        <li><a href="...">...</a></li>
      </ul>
      <ul>
        <li><a href="...">...</a></li>
      </ul>
    </nav>

В Oscean это буквально последовательные `ul`. CSS размещает их через `display:inline-block`.

JavaScript для меню не нужен.

## Состояния ссылок

Oscean помечает две ссылки:

    class="self"

для текущего узла;

    class="parent"

для непосредственного родителя текущего узла.

В референсном CSS обе ссылки подчёркиваются:

    nav ul li a.parent,
    nav ul li a.self {
      text-decoration:underline;
    }

Это важно: `parent` — не декоративный класс для произвольной ссылки, а структурное состояние навигации.

## Алгоритм

Пусть текущий узел — `C`, его родитель — `P`, родитель `P` — `G`.

    depth(C) = 0:
        children(C)

    depth(C) = 1:
        children(root)
        children(C)

    depth(C) >= 2:
        children(G)
        children(P)
        children(C)

Каждая группа выводится как отдельный `ul`. Пустая группа не должна создаваться.

Важное отличие от обычного «siblings + children»:

    siblings(current)

само по себе достаточно только для одной колонки. На глубине 2+ референс добавляет ещё один уровень контекста — siblings(parent).

## Источник данных

Oscean не получает меню из HTML или из отдельного manifest-файла. Он читает lexicon, определяет parent для терма и затем последовательно печатает нужные уровни дерева.

Для Jekyll-реплики источником истины является дерево публичных Markdown-страниц:

    directory
        ↓
    index.md / page.md
        ↓
    page.path
        ↓
    parent / current / children
        ↓
    nav

Каталог без публичной страницы не становится пунктом меню.

## Порядок

В этой реплике страницы сортируются по `path`. Это деталь реализации Jekyll, а не часть исходного Oscean-механизма. Сам референс получает порядок из lexicon.

Если проекту нужен другой порядок, его следует определить на уровне структуры данных, а не через ручной HTML-список.

## Проверка

Для корректности нужны минимум четыре теста:

    /
    /audio/
    /audio/aliceffekt/
    /reference/navigation-depth/level-01/.../level-60/

Проверять нужно не только сборку, но и полученный HTML:

    <nav>
      <ul>...</ul>
      <ul>...</ul>
      <ul>...</ul>
    </nav>

а также:

- текущая ссылка имеет `self`;
- непосредственный родитель имеет `parent`;
- дети текущей страницы находятся в третьей группе;
- пустые группы отсутствуют;
- вложенных `ul` внутри навигационных `ul` нет;
- глубина дерева не ограничена шаблоном.

## Что не является референсом

Не следует заменять эту модель:

- раскрытым sidebar-tree;
- dropdown/accordion;
- рекурсивно вложенными `ul`;
- JavaScript-навигацией;
- глобальным вручную поддерживаемым меню;
- двухколоночной моделью без третьего контекстного уровня.

Главный принцип:

    глубина дерева данных ≠ число навигационных колонок

Референс показывает максимум три локальные группы и вычисляет их относительно текущего узла.
