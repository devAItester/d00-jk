---
layout: default
title: navigation
---

# Navigation

The defining feature of this navigation model is a multi-column representation of a hierarchy.

The hierarchy can be arbitrarily deep. The viewport, not the data model, limits how many columns are displayed comfortably.

## Reference model

The reference sitemap demonstrates levels substantially deeper than the three levels currently represented by this test implementation.

    home
    ├── audio
    │   ├── aliceffekt
    │   │   ├── laeisthic
    │   │   │   ├── children of bramble
    │   │   │   └── known magye
    │   │   └── duomic
    │   │       └── ver iytsl
    │   └── soundtrack
    ├── visual
    │   └── photography
    │       └── travel
    │           └── japan
    │               └── tokyo
    └── software
        └── games
            └── oquonie
                └── camilare

There is no architectural reason to stop at level three.

## Columns versus levels

A level is a property of the content tree.

A column is a presentation choice.

They must not be confused.

A hierarchy can contain:

    audio
      aliceffekt
        laeisthic
          children of bramble
            detail
              example

while the rendered navigation may display only the currently useful path and its immediate siblings across a limited number of horizontal groups.

The number of columns is therefore a layout constraint, not a content-depth constraint.

## Current implementation

The current test implementation recognizes:

- top-level section indexes;
- pages directly inside the current section;
- pages one branch below the current section.

It is therefore not yet an unlimited-depth navigation engine.

The reference architecture is deeper than the current implementation.

## Why columns

Each navigation group is an inline-block column. This keeps hierarchy visible without turning the page into a permanently open vertical tree.

The model preserves:

- local context;
- sibling visibility;
- short scanning paths;
- dense information;
- a direct relation between hierarchy and navigation.

## Active path

The current path is represented by visual state. The current CSS distinguishes parent and self links.

This makes the active branch visible without requiring a separate breadcrumb widget.

## Arbitrary depth

A robust implementation should derive navigation from the directory tree rather than hard-code path positions such as parts[0], parts[1], parts[2].

It should:

1. split the current path;
2. identify every ancestor;
3. collect siblings at each relevant level;
4. render those levels as navigation groups;
5. limit only the visible number of groups, not the underlying tree depth.

The content tree remains the source of truth.

## Adding a deep branch

    research/
        index.md
        computation/
            index.md
            complexity/
                index.md
                knots.md
                paper-computing/
                    index.md
                    paper-register.md

No manually maintained global menu should be required.

## Empty directories

A directory with no public page should not become a navigation node merely because the filesystem contains the directory.

A navigable branch needs a public landing page or another explicit content node.

## Navigation and search

Use ordinary HTML a href links for primary discovery.

Do not make primary navigation depend on JavaScript.

Google explicitly recommends crawlable anchor links with descriptive anchor text.

## Principle

The navigation is a view of the tree.

It is not the tree.

The filesystem/content hierarchy should remain capable of expressing more depth than the current visual viewport displays.
