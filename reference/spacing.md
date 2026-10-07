---
layout: default
title: spacing
---

# Spacing

The spacing system combines web implementation with principles familiar from typography and print composition.

## Reference measurements

    body text: 16px
    paragraph line-height: 160%
    main left offset: 30px
    standard vertical rhythm: 30px
    navigation padding: 45px 30px
    navigation column gap: 45px
    header margin: 50px 30px
    header right margin: 60px
    article inner padding: 25px
    list line-height: 25px
    figure caption padding: 15px 0
    ordinary image bottom margin: 25px
    lead figure width: 800px
    main text max-width: 624px

These measurements create a repeated rhythm rather than unrelated margins.

## 30px rhythm

The dominant interval separates paragraphs, blocks, navigation/content and footer regions.

A repeated interval is easier to perceive than a collection of unrelated values.

## Line-height

At 16px body text, 160% produces approximately:

    16 × 1.6 = 25.6px

This is close to the 25px list line-height and produces a coherent baseline rhythm.

## Text measure

The main column is about 624px.

This is a reference implementation value, not a universal typographic law.

## Print-derived principle: measure before decoration

Constrain prose first. Let images and navigation exceed the prose measure only when their visual role requires it.

## Print-derived principle: whitespace is structural

Whitespace should separate conceptual units.

The reference intervals can be read as:

    15px -> tight association
    25px -> image/list rhythm
    30px -> block separation
    45px -> navigation/header breathing room

These are implementation values, not standards.

## Print-derived principle: hierarchy by proportion

Use:

- size;
- position;
- whitespace;
- weight;
- repetition;

before introducing additional colors or ornamental components.

## Vertical rhythm

Prefer a small family of repeated intervals. Avoid inventing a new margin for every component.

## Full-width composition

A lead figure can break the prose measure. This is analogous to a print figure crossing the normal text column to establish a visual opening.

The reference limits this special treatment to the first figure.

## Responsive behavior

Desktop measurements yield to viewport boundaries.

The lead figure is capped by:

    max-width: 100vw

Do not create horizontal scrolling merely to preserve a desktop measurement.

## Accessibility

Do not encode meaning solely through spacing. Whitespace should support semantic structure, not replace headings, lists, paragraphs or landmarks.

## Review

For every new component ask:

- What semantic unit is this?
- Which existing rhythm does it belong to?
- Does it need tight, normal or structural separation?
- Is the text measure readable?
- Is whitespace communicating hierarchy?
- Could the same hierarchy be expressed without another color or decorative element?
