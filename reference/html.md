---
layout: default
title: html
---

# HTML

The objective is valid, semantic, crawlable HTML with a small presentation layer.

## Document metadata

The head should contain only valid metadata elements.

At minimum:

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Descriptive page title</title>

The current layout supplies the first two and constructs the title from the page title.

A future SEO layer should add page-specific description and canonical URL where appropriate.

## Title

Every indexable page should have a unique descriptive title.

The HTML specification requires at most one title element in a document and expects the title to identify the document out of context.

## Headings

Use:

    h1
      h2
        h3
          h4
            h5
              h6

Do not skip levels merely to obtain a desired visual size.

## Paragraphs

Use p for paragraphs. Do not create paragraphs from repeated br elements.

## Links

Use real hyperlinks:

    <a href="/reference/styleguide.html">styleguide</a>

The destination belongs in href, not only in JavaScript.

Anchor text should describe the destination.

## Images

Informative:

    <img src="/media/architecture.jpg"
         width="1600"
         height="1067"
         alt="Diagram of the site's directory structure">

Decorative:

    <img src="/media/ornament.svg" alt="">

Functional:

    <a href="/gallery/">
      <img src="/media/gallery.svg" alt="Gallery">
    </a>

Do not omit alt on an HTML img.

Width and height should be supplied when intrinsic dimensions are known. They reserve aspect-ratio space and reduce layout shift.

## Responsive images

    <img src="/media/photo-1200.jpg"
         srcset="/media/photo-600.jpg 600w,
                 /media/photo-1200.jpg 1200w,
                 /media/photo-2400.jpg 2400w"
         sizes="(max-width: 624px) 100vw, 624px"
         width="2400"
         height="1600"
         alt="...">

## Figure

Use figure when image and caption form one semantic unit:

    <figure>
      <img ...>
      <figcaption>...</figcaption>
    </figure>

## Video

    <video controls width="1280" height="720">
      <source src="/media/example.mp4" type="video/mp4">
    </video>

## Iframe

Use iframe only for an actual external document or service. Do not use it as a substitute for ordinary site content.

## Language

Set the primary document language:

    <html lang="en">

Mark genuine language changes with lang.

## Accessibility

Minimum rules:

- informative images have useful alt;
- decorative images use alt="";
- links have an accessible name;
- headings express hierarchy;
- tables express data relationships;
- important information exists as text in the DOM.

## Search indexing

Google discovers pages through crawlable links, sitemaps and redirects. Primary discovery should therefore remain ordinary HTML navigation.

Important image content should use ordinary img elements, descriptive filenames, useful alt text and relevant surrounding text.

A sitemap should contain canonical URLs that the site wants indexed.

## References

Primary sources:

- WHATWG HTML Living Standard
- W3C WCAG 2.2 techniques
- Google Search Central: SEO for developers
- Google Search Central: image SEO
- Google Search Central: crawlable links
- Google Search Central: sitemaps
