---
layout: default
title: reference
permalink: /reference/
---
# Reference

Тестовый раздел для пошагового визуального сравнения с оригиналом XXIIVV.

Все примеры ниже воспроизводят элементы, которые реально используются в wiki. Для каждого блока указан прямой переход к оригиналу.

## Типографика

Основной текст использует системный generic-family `serif`, размер 16px. Отдельный webfont для интерфейса не подключается.

**Жирный**, *курсив*, `inline code`, <kbd>Ctrl</kbd>+<kbd>S</kbd>, обычная [ссылка](https://wiki.xxiivv.com/site/styleguide.html).

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html#header1) · [типографика](https://wiki.xxiivv.com/site/typography.html)

## Заголовки

# header 1

## header 2

### header 3

#### header 4

##### header 5

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html#header1)

## Paragraph

Обычный абзац с длинной строкой текста. В оригинале основной текст имеет line-height 160%, а стандартные вертикальные интервалы задаются через правило `margin-bottom: 30px`.

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Article

<article>
<h2>article</h2>
<p>Блок article получает левую dotted-границу и внутренний отступ. Заголовок article скрывается стилем оригинала.</p>
</article>

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Lists

- первый пункт
- второй пункт
  - вложенный пункт
  - ещё один вложенный пункт

1. первый
2. второй

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Table

| элемент | значение |
| --- | --- |
| text | serif |
| size | 16px |
| line-height | 160% |

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Horizontal rule

---

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Pre / code

    preformatted text
      preserves indentation
      and uses tab-size: 2

`inline code` остаётся обычным текстовым элементом.

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Quote / cite

> This is a quote block, with bold, italic, code and a link.

<cite>Author, Source</cite>

Оригинал: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

## Media

Правила оригинала:

- `main img, main svg`: max-width 100%;
- `display: inline-block`;
- нижний margin 25px;
- изображения в `figure` и `center` выводятся как block;
- первая `figure` может выходить за ширину основного текста;
- `figcaption` получает padding 15px 0.

Пример:

<figure>
<img src="https://wiki.xxiivv.com/media/generic/aliceffekt.photo2.jpg" alt="Оригинальный media asset">
<figcaption>Тест изображения и figcaption. Пока используется прямой URL оригинального asset.</figcaption>
</figure>

Оригинальный элемент: [styleguide](https://wiki.xxiivv.com/site/styleguide.html)

Оригинальный asset: [aliceffekt.photo2.jpg](https://wiki.xxiivv.com/media/generic/aliceffekt.photo2.jpg)

## Navigation

Оригинальная навигация строится из нескольких `ul`, расположенных горизонтально как inline-block. Это принципиально отличается от обычного вертикального меню.

CSS:

- `nav { padding: 45px 30px; }`
- `nav ul { display: inline-block; vertical-align: top; }`
- `nav ul li { white-space: pre; }`
- `nav ul li a { padding: 0 4px; }`

Оригинал: [home](https://wiki.xxiivv.com/) · [sitemap](https://wiki.xxiivv.com/site/sitemap.html) · [CSS](https://github.com/XXIIVV/oscean/blob/main/links/main.css)

## Цветовая схема

В light mode основной фон страницы белый, текст чёрный.

В dark mode оригинальный CSS переключает:

- body background → black;
- текст → white;
- hover → white background / black text;
- изображения SVG/PNG → invert;
- pre → #111.

Оригинал: [meta](https://wiki.xxiivv.com/site/meta.html) · [CSS](https://github.com/XXIIVV/oscean/blob/main/links/main.css)

## Media architecture

В оригинальном проекте media хранится отдельно от HTML и исходных текстов:

    media/
        generic/
        icon/
        identity/
        services/
        refs/
        diary/

Руны Oscean определяют тип ссылки, в том числе `img` и `img+txt`.

Оригинал: [oscean](https://wiki.xxiivv.com/site/oscean.html) · [meta](https://wiki.xxiivv.com/site/meta.html)

## Reference source

Эталонная страница элементов: [XXIIVV styleguide](https://wiki.xxiivv.com/site/styleguide.html)

Эталонный CSS: [XXIIVV main.css](https://github.com/XXIIVV/oscean/blob/main/links/main.css)

Описание движка: [XXIIVV oscean](https://wiki.xxiivv.com/site/oscean.html)
