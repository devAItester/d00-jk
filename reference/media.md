---
layout: default
title: media
---

# Media

Media is a resource layer, not a page hierarchy.

The reference resource tree separates binary assets by role:

    media/
        diary/
        generic/
        icon/
        identity/
        refs/
        services/

The reference repository contains about 1,900 media-tree entries, dominated by JPG and PNG, with SVG, GIF, MP4 and other formats also present.

## Roles

generic/ contains reusable photographs, illustrations and other general content assets.

icon/ contains small interface and decorative assets.

identity/ contains identity assets such as marks and logos.

refs/ contains reference material and locally retained external visual resources.

services/ contains assets associated with external services.

diary/ is a chronological image collection. Numeric filenames are appropriate there because sequence is the semantic identity.

## README versus media

media/README.md documents the resource repository for maintainers.

It is not an article and should not appear in public navigation.

Public documentation about the media system belongs under reference/, for example:

    reference/media.md

## File naming

For ordinary content images prefer descriptive names:

    paper-computer.jpg
    paper-computer-detail.jpg
    directory-tree.svg

Avoid meaningless names such as IMG_0382.jpg where the filename can convey useful context.

For numbered sequences, numeric names are acceptable.

## Formats

JPEG: photographs and continuous-tone images.

PNG: lossless raster graphics, transparency and hard-edged artwork where appropriate.

SVG: vector diagrams and simple icons where appropriate.

GIF: only when its animation or compatibility characteristics are actually required.

MP4: native browser video when local video is appropriate.

## Dimensions

There is no universal required pixel size.

The reference presentation has two important measures:

    main text measure: approximately 624px
    lead figure width: approximately 800px

Ordinary content images should normally be prepared around their rendered content width.

Lead figures can use larger sources because they can extend beyond the prose measure.

Do not serve a 4000px source when a 624px rendering is sufficient unless the larger source has a real user benefit.

## Intrinsic dimensions

When intrinsic dimensions are known, put width and height on the img element:

    <img src="/media/photo.jpg"
         width="1600"
         height="1067"
         alt="...">

CSS can still make the image responsive.

These attributes communicate the intrinsic aspect ratio and help the browser reserve layout space before the image loads.

## Responsive images

When multiple useful resolutions exist:

    <img src="/media/photo-1200.jpg"
         srcset="/media/photo-600.jpg 600w,
                 /media/photo-1200.jpg 1200w,
                 /media/photo-2400.jpg 2400w"
         sizes="(max-width: 624px) 100vw, 624px"
         width="2400"
         height="1600"
         alt="...">

Use srcset and sizes when they materially reduce transferred bytes. Do not manufacture variants without a performance reason.

## Alt text

Informative:

    alt="Hand-drawn diagram of the directory hierarchy"

Decorative:

    alt=""

Functional link:

    <a href="/gallery/">
      <img src="/media/gallery.svg" alt="Gallery">
    </a>

Alt text is an alternative to the information or function of an image. It is not a filename and not necessarily a caption.

## Captions and credits

    <figure>
      <img src="/media/photo.jpg"
           width="1600"
           height="1067"
           alt="Aerial photograph of the coastline">
      <figcaption>
        Coastline, 2026. Photograph by Example Author.
      </figcaption>
    </figure>

A credit is not a substitute for useful alt text.

## Licensing metadata

Where authorship or licensing matters, retain provenance in repository metadata or a dedicated record.

Google supports image metadata such as:

- creator;
- credit text;
- copyright notice;
- license;
- acquisition/license page.

This can be supplied through structured data or embedded IPTC photo metadata. Claim only rights that actually exist.

## Search visibility

Google recommends:

- public crawlable image URLs;
- descriptive filenames;
- useful alt text;
- relevant surrounding text;
- relevant page context;
- valid HTML;
- canonical URLs in a sitemap;
- no accidental robots or noindex blocking.

Lazy loading is acceptable when implemented with crawlable image elements and without requiring user interaction to reveal essential content.

## Full-width images

The reference CSS intentionally permits the first figure to exceed the ordinary text measure.

This is a composition rule, not an SEO rule.

Use the wide treatment when the image benefits from a larger visual field. Do not enlarge every image merely to imitate it.

## Checklist

Before adding an asset:

- choose its media class;
- use a descriptive filename unless sequence is meaningful;
- preserve intrinsic dimensions;
- choose an appropriate format;
- record provenance/license where required;
- prepare appropriate alt text;
- add a caption when context or credit is needed;
- check rendered dimensions;
- verify a real img element is present;
- verify the URL is crawlable.
