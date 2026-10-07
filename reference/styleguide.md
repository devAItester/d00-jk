---
layout: default
title: styleguide
---

# Styleguide

Это функциональная спецификация визуального и HTML-стиля сайта.

Референсный стиль минимален: семантический HTML задаёт структуру, CSS управляет типографикой, интервалами, монохромным контрастом, навигационными колонками и небольшим количеством специальных композиционных приёмов.

## Document skeleton

    <header>...</header>
    <nav>...</nav>
    <main>
      <h1>Page title</h1>
      <p>...</p>
    </main>
    <footer>...</footer>

Элементы выбираются по смыслу, а не ради их стандартного визуального вида.

## Headings

Один логический заголовок страницы — `h1`, затем последовательная иерархия:

    # Page
    ## Section
    ### Subsection
    #### Detail

Уровень заголовка нельзя выбирать только потому, что его размер визуально удобнее.

## Paragraph

    <p>
      A paragraph with inline markup.
    </p>

CSS референса использует `160%` line-height для абзацев и общий вертикальный ритм около `30px`.

## Article

    <article>
      <h2>Related note</h2>
      <p>...</p>
    </article>

Визуально article получает пунктирную левую границу и внутренний отступ.

## Links

    <a href="/audio/">audio</a>
    <a href="https://example.org/">example</a>

Текст ссылки должен описывать назначение перехода. Пустые ссылки и бессодержательные подписи не используются.

## Image

Информативное изображение:

    <img src="/media/example.jpg"
         alt="Краткое описание информации на изображении">

Декоративное:

    <img src="/media/ornament.svg" alt="">

Функциональное изображение-ссылка:

    <a href="/gallery/">
      <img src="/media/gallery.png" alt="Gallery">
    </a>

## Figure

    <figure>
      <img src="/media/example.jpg"
           width="1200"
           height="800"
           alt="...">
      <figcaption>Caption or credit.</figcaption>
    </figure>

`figure` используется, когда изображение и подпись образуют единый смысловой объект.

## 3/4-width and full-width images

Основная текстовая мера референса — около `624px`. Обычные изображения ограничены этой композицией.

Первый `figure` получает специальную широкую обработку:

    width: 800px;
    max-width: 100vw;
    margin-left: -30px;

Поэтому lead image может выходить за пределы текстовой меры, но обычные изображения остаются внутри неё.

## Lists

    - first
    - second
      - nested

    1. first
    2. second

Референс использует line-height списка около `25px` и структурный левый отступ.

## Tables

Таблицы предназначены для табличных отношений, а не для компоновки страницы.

    | property | value |
    | --- | --- |
    | size | 16px |
    | rhythm | 30px |

## Code

Строчный код:

    command

Блок кода:

        command --option
          argument

В light mode code block имеет светлый фон; в dark mode — почти чёрный.

## Quote

    > A quotation.

    <cite>Source</cite>

## Horizontal rule

    ---

`hr` используется как тематический разделитель, а не как универсальный spacer.

## Keyboard input

    <kbd>Ctrl</kbd>+<kbd>S</kbd>

## Functional checklist

Каждая публичная страница должна иметь:

- осмысленный `title`;
- ясный основной заголовок;
- читаемый текст в DOM;
- обычные crawlable `a href` links;
- подходящие text alternatives для изображений;
- размеры изображений, когда они известны;
- captions, когда они нужны по смыслу;
- отсутствие случайных дублирующих URL;
- отсутствие битых внутренних ссылок.

Требования сопоставляются с HTML Living Standard, WCAG и рекомендациями Google Search.
