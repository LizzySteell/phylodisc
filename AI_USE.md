# AI use in phylodisc

This file records where generative AI was used in the package. The same
information appears in the **AI use** section of each function's help page
(`?function_name`).

## Tools and models

| Tool | Model | Used for |
|------|-------|----------|
| GitHub Copilot | GPT-4.1 | Parts of `rhi()`; `mrbayes_partition_block()`; three helpers inside `phylo_gdist()` |
| GitHub Copilot | GPT-5 mini | `adjust_ord()` |
| GitHub Copilot | Not named in the original source notes | Editing `anc_discrete()` for smoother running (marked 'MODIFIED' in the source); the rate-matrix helper in `rate_index()`; troubleshooting `RHI.char` (archived) |
| GitHub Copilot | Claude Sonnet 5.5 | R package structure, roxygen documentation, snake_case renaming, deprecated wrappers (`R/deprecated.R`), and the AI use sections |

The notes on GPT-4.1, GPT-5 mini and unnamed models come from the author's
comments in the original function files in `functions/`. They have been
carried over without change.

## What the author did

- Wrote the original functions and the analyses that use them.
- Edited the Copilot-generated `mrbayes_partition_block()` by hand.
- Fixed bugs in the original `RHI.char` and compared old and new `rhi()` output
  on the same dataset with `set.seed`.

## Dates

Dates of individual changes are in the git history. Where the author recorded
a date in the original source, it is given in the function's help page.
