---
layout: default
title: content
---

# Content

This page defines the reproducible content workflow.

## One page

A page is a single Markdown document.

    audio/aliceffekt/notes.md

Front matter:

    ---
    layout: default
    title: notes
    date: 2026-10-07
    ---

    # Notes

    Content.

The filename defines the stable path component. The title defines the document label.

The current permalink configuration is:

    /:path/:basename.html

Therefore changing a filename or directory normally changes its public URL.

## A section containing pages

    audio/
        index.md
        aliceffekt/
            index.md
            notes.md
            field-recording.md

The branch landing page is aliceffekt/index.md. The individual pages are ordinary Markdown files beside it.

## Add a page

1. Create the file in the intended directory.
2. Add valid front matter.
3. Add a meaningful title.
4. Add semantic content.
5. Add useful internal links.
6. Build the site.
7. Check the generated URL and navigation.

## Add a section

Create the directory and its landing page:

    science/
        index.md
        physics.md
        chemistry.md

For deeper structure:

    science/
        index.md
        physics/
            index.md
            quantum.md
            optics.md

The index files establish public landing pages at the intended levels.

## Remove a page

1. Search for incoming links.
2. Decide whether the URL is obsolete or moved.
3. Update or remove internal links.
4. Delete the source file.
5. Rebuild.
6. Check for stale links.

If an old URL has external traffic or search visibility, use a deliberate redirect or replacement strategy instead of silently abandoning it.

## Move a page

Treat a move as a URL migration:

    old URL -> new URL

Update internal links and, where appropriate, provide a redirect.

## Delete a section

Remove its public content and landing page, then update incoming links and remove resources only when they are no longer referenced.

## Content versus repository metadata

    README.md       = repository documentation
    index.md        = public section landing page
    post.md         = public content
    media/*         = resource
