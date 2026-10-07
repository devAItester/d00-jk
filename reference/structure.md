---
layout: default
title: structure
---

# Structure

The site separates content, navigation structure, presentation, and binary resources.

## Repository tree

    index.html
    _config.yml
    _layouts/
        default.html
    _includes/
        nav.html
        style.css

    audio/
        index.md
        aliceffekt/
            index.md
            notes.md

    reference/
        index.md
        structure.md
        content.md
        styleguide.md
        navigation.md
        media.md
        html.md
        spacing.md
        color.md

    media/
        README.md

## Roles

### Markdown page

A Markdown file with Jekyll front matter is public site content and becomes an HTML document.

### Directory

A directory is a structural namespace. It groups pages and defines their navigation context.

### index.md

index.md is the public landing page of a directory. It gives the section a stable URL and a public node for navigation.

### README.md

README.md is repository documentation, not site content. It explains the source tree to maintainers and is intentionally excluded from the Jekyll page collection.

Do not use README.md as a replacement for a public index.md.

### media/

media/ is a resource namespace, not a content section. It contains binary and static resources used by pages.

Its README documents the resource tree for maintainers. Public documentation about media belongs under reference/.

## Rule of thumb

    public content      -> *.md
    section landing     -> index.md
    repository notes    -> README.md
    binary/static data  -> media/
    layout              -> _layouts/
    reusable fragments  -> _includes/
    presentation        -> _includes/style.css

This separation prevents repository metadata from becoming public content and prevents resources from being mistaken for pages.
