# Variant — A/B Testing & Pixel

A Google Tag Manager tag that installs [Variant](https://www.variantnow.com) on
your store with a single tag. It loads two Variant scripts:

1. **Variant analytics pixel** — collects analytics and (optionally) automatic
   click & scroll-depth events.
2. **Variant storefront SDK / A/B test runner** — runs your A/B tests and
   experiences on the storefront.

## Fields

| Field                         | Required        | Description                                                             |
| ----------------------------- | --------------- | ----------------------------------------------------------------------- |
| **Variant Shop ID**           | Yes             | Your Variant Shop ID (Variant dashboard → Settings → Install).          |
| **Variant SDK Key**           | Yes             | Your Variant SDK / client key (Variant dashboard → Settings → Install). |
| **Enable DOM event tracking** | No (default on) | Automatic click & scroll-depth tracking via the pixel.                  |

## Usage

1. Add a new tag and choose the **Variant — A/B Testing & Pixel** template.
2. Enter your **Shop ID** and **SDK Key**.
3. Set the trigger to **Initialization - All Pages** so Variant loads as early
   as possible.
4. Publish the container.

## How it works

The tag injects the two scripts above from Variant's CDN. Your Shop ID and SDK
Key are passed to the SDK via the `window.GB_CONFIG` global and to the pixel via
`VariantPixel.init()`. Both values are publishable client-side identifiers.

## Support

Found a bug or have a question? Open an issue on this repository.
