---
layout: default
title: styleguide
---

# Styleguide

This is the functional style guide for the replica.

The reference style is sparse: semantic HTML carries structure, CSS controls typography, spacing, monochrome contrast, navigation columns, and a small number of special presentation cases.

## Document skeleton

    <header>...</header>
    <nav>...</nav>
    <main>
      <h1>Page title</h1>
      <p>...</p>
    </main>
    <footer>...</footer>

Use elements for meaning, not for their default visual appearance.

## Headings

Use one logical page title as h1, then descend hierarchically:

    # Page
    ## Section
    ### Subsection
    #### Detail

Do not choose heading levels merely because a smaller visual size looks better.

## Paragraph

    <p>
      A paragraph with inline markup.
    </p>

The reference CSS uses 160% line-height for paragraphs and a 30px vertical rhythm.

## Article

    <article>
      <h2>Related note</h2>
      <p>...</p>
    </article>

The visual style uses a dotted left rule and internal padding.

## Links

    <a href="/audio/">audio</a>
    <a href="https://example.org/">example</a>

Anchor text should describe the destination. Avoid empty links and generic labels.

## Image

Informative:

    <img src="/media/example.jpg"
         alt="A concise description of the information shown">

Decorative:

    <img src="/media/ornament.svg" alt="">

Functional image link:

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

Use figure when the image and caption form one semantic unit.

## 3/4-width and full-width images

The reference CSS has a main text measure of about 624px. Ordinary images are constrained by it.

The first figure receives a special wide treatment:

    width: 800px;
    max-width: 100vw;
    margin-left: -30px;

Therefore a lead image can extend beyond the prose measure while ordinary images remain inside it.

This is a compositional distinction, not a requirement to make every image wide.

## Lists

    - first
    - second
      - nested

    1. first
    2. second

The reference uses a 25px list line-height and a structural left offset.

## Tables

Use tables for tabular relationships, never for page layout.

    | property | value |
    | --- | --- |
    | size | 16px |
    | rhythm | 30px |

## Code

Inline:

    command

Block:

        command --option
          argument

The reference uses a light code block in light mode and a near-black block in dark mode.

## Quote

    > A quotation.

    <cite>Source</cite>

## Horizontal rule

    ---

Use hr as a thematic break, not as a generic spacer.

## Keyboard input

    <kbd>Ctrl</kbd>+<kbd>S</kbd>

## Functional checklist

Every public page should have:

- a meaningful title;
- a clear primary heading;
- readable text in the DOM;
- crawlable a href links;
- appropriate image alternatives;
- dimensions on images when known;
- captions when contextual information is required;
- no accidental duplicate URLs;
- no broken internal links.

The requirements are grounded in the HTML Living Standard, WCAG techniques, and Google Search guidance.
