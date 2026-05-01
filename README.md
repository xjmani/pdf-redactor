# pdf-redactor

A privacy-first PDF redactor with real content-stream removal. Runs entirely in your browser. Nothing is uploaded.

Part of the [xjmani](https://xjmani.com) tools collection.

## What it does

- Opens PDFs in the browser using pdfjs-dist; never uploads
- Lets you draw rectangles over sensitive content, or auto-detects emails, phone numbers, addresses, IDs, money, tax IDs, URLs, ZIP codes
- Custom regex patterns built from a single example you paste
- On export, rewrites the page content stream so the targeted glyphs are actually deleted, then paints black rectangles for visual confirmation
- Verifies the export by re-reading it and counting any text still inside a redaction rect (zero is success)

## Why use it

Most browser PDF redactors paint a black rectangle on top of the text and call it done. The text is still in the file, copy-pasteable. This one walks the page content stream, tracks the text matrix and graphics state, reads each font's per-glyph widths, and surgically removes only the targeted glyphs. Open the redacted PDF in any reader, press Ctrl+F, search for what you redacted. It's gone.

There is no backend. After the page loads, no network requests are made. Open DevTools and watch the Network tab while you redact a file. Nothing fires. The Content-Security-Policy meta tag in the page enforces this — the page is locked to its own origin.

## Three ways to run it

1. **Open the website:** [pdf.xjmani.com](https://pdf.xjmani.com) (coming soon)
2. **Download the standalone HTML:** clone this repo (or grab the zip) and open `index.html`. Libraries are vendored under `vendor/`, so no internet is required after that
3. **Self-host:** drop `index.html` and `vendor/` on any static host (NAS, intranet, SharePoint). Anyone who can reach the page can use it without bytes leaving the network

## Privacy

- No uploads, ever
- No analytics, no telemetry
- No cookies, no tracking
- Content-Security-Policy locks the page to its own origin
- Only data stored on your device is your custom regex patterns and theme preference (`localStorage`)

## Vendored libraries

`vendor/` contains the two libraries that do the real work, pinned to specific versions:

- `pdf.min.mjs` and `pdf.worker.min.mjs` — pdfjs-dist 4.7.76 (rendering and text extraction)
- `pdf-lib.min.mjs` — pdf-lib 1.17.1 (content-stream rewriting and serialization)

## Development

Open `index.html` directly in a browser (or serve the directory with any static server). All state is in `<script type="module">` at the bottom of the file. The redaction core is in `walkAndBlank` and `surgicalBlank` — see the architecture comment at the top of the file for the full flow.

## License

MIT, see [LICENSE](LICENSE).
