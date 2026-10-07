---
layout: default
title: color
---

# Color

The reference uses color as a scarce semantic resource.

The default interface is deliberately monochrome:

    foreground: #000
    background: #fff

Dark mode reverses the relationship:

    foreground: #fff
    background: #000

## Philosophy

Most relationships are expressed through:

- position;
- typography;
- underline;
- spacing;
- borders;
- hierarchy;
- repetition.

Color is not assigned to every category.

## Interaction

Hover uses inversion:

    light mode:
      black background
      white text

    dark mode:
      white background
      black text

This makes interaction visible without adding a palette of status colors.

## Selection

The reference reserves a single accent for text selection:

    #72dec2

This is restrained use of color: one accent can identify an interaction state without becoming a general decorative palette.

## Dark mode

The reference uses:

    @media (prefers-color-scheme: dark)

The transformation is essentially:

    white page -> black page
    black text -> white text

Code blocks become near-black and selected raster formats may be inverted where appropriate.

## What not to do

Do not assign a different color to every navigation level.

Do not use color as the only indicator of state.

Do not add gradients, cards, badges or colored panels merely to enrich the interface.

## Accessibility

A monochrome palette is not automatically accessible.

Contrast, focus indication, text size and interaction behavior still matter.

Color must not be the sole carrier of information.

## Design principle

The palette is intentionally smaller than the information architecture.

The tree can have arbitrary depth. The color system does not need a new color for each depth.

## Practical rule

When considering another color, first ask whether the distinction can be expressed with:

    structure -> typography -> spacing -> line/border -> color

Color should normally be the later tool, not the first.
