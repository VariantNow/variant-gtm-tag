# Variant — A/B Testing & Pixel (Google Tag Manager Template)

A Google Tag Manager **custom tag template** that installs Variant on a store
with a single tag. It loads two scripts:

1. **Variant analytics pixel** — `https://storage.googleapis.com/variant_scripts/pixel.js`
2. **Variant storefront SDK / A/B test runner** — `https://sdk.variantnow.com/test-runner.js`

Because GTM runs templates in [sandboxed JavaScript](https://developers.google.com/tag-platform/tag-manager/templates/sandboxed-javascript)
(which cannot add `data-*` attributes to an injected `<script>`), the SDK
configuration is passed through the `window.GB_CONFIG` global, which
`test-runner.js` reads before falling back to script-tag attributes. The pixel
is configured by calling `VariantPixel.init()` once it has loaded.

## Fields

| Field | Required | Description |
| ----- | -------- | ----------- |
| **Variant Shop ID** | Yes | Your Variant Shop ID (Variant dashboard → Settings → Install). |
| **Variant SDK Key** | Yes | Your Variant SDK / client key (Variant dashboard → Settings → Install). |
| **Enable DOM event tracking** | No (default on) | Automatic click & scroll-depth tracking via the pixel. |

## Usage in GTM

1. Add this template to your container (from the Community Template Gallery, or
   import `template.tpl` via **Templates → New → Import**).
2. Create a new tag using the **Variant — A/B Testing & Pixel** template.
3. Enter your **Shop ID** and **SDK Key**.
4. Set the trigger to **Initialization - All Pages** (recommended) so Variant
   loads as early as possible.
5. Publish the container.

## Repository structure (Community Template Gallery)

To submit to the [Community Template Gallery](https://developers.google.com/tag-platform/tag-manager/templates/gallery),
these files must live at the **root of a dedicated public GitHub repository**:

- `template.tpl` — the exported template
- `metadata.yaml` — homepage, documentation, and version history
- `LICENSE` — Apache 2.0 (required, filename in all caps)
- `README.md` — this file (optional but recommended)

### Publishing / updating

`metadata.yaml` controls which version the gallery serves. After committing the
`template.tpl` you want to publish:

1. Copy the **full commit SHA** of that commit.
2. Put it as the top `sha` entry under `versions:` in `metadata.yaml` (newest
   first), with a short `changeNotes`.
3. Commit and push. Updates typically appear in the gallery within 2–3 days.

Make sure **Issues** are enabled on the repository so users can report bugs.
