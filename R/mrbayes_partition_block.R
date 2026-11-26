### 27-Oct-2025

# V1.0 mrbayes_partition_block function

#' Write a MrBayes partition block from homoplasy bins
#'
#' Prints `charset`, `partition` and `set partition` commands that can be
#' pasted into a MrBayes block. This code is a wedding gift to my dear friend
#' Juan Benito.
#'
#' @param homoplasy_bins Output from [homoplasy_bin()].
#' @param partition_name Name for the partition scheme.
#' @return Called for its printed output (via `cat()`); returns `NULL`
#'   invisibly.
#' @examples
#' bins <- list(bins = list(low = c(1, 2, 3), high = c(4, 5)))
#' mrbayes_partition_block(bins)
#' @section AI use:
#' Written with GitHub Copilot (GPT-4.1) on 27 October 2025. The prompt was
#' to 'write a function that creates a MrBayes partition block from the
#' output from phylodisc::homoplasy_bin()', with a sample partition block
#' pasted in. The author then edited the function manually so that the
#' output code was concatenated. The roxygen documentation and the
#' snake_case name were produced with GitHub Copilot (Claude Sonnet 5.5);
#' see `AI_USE.md`.
#' @export
mrbayes_partition_block <- function(homoplasy_bins, partition_name = "homoplasy") {
  bins <- homoplasy_bins$bins
  bin_names <- names(bins)
  n_bins <- length(bins)
  charset_lines <- character(n_bins)
  set_names <- character(n_bins)
  set_idx <- 1
  for (i in seq_along(bins)) {
    chars <- paste(sort(as.integer(bins[[i]])), collapse = " ")
    set_name <- paste0("set", set_idx)
    charset_lines[set_idx] <- sprintf("charset %s = %s;", set_name, chars)
    set_names[set_idx] <- set_name
    set_idx <- set_idx + 1
  }
  partition_line <- sprintf("partition %s = %d: %s;", partition_name, n_bins, paste(set_names, collapse = ", "))
  set_line <- sprintf("set partition = %s;", partition_name)
  block <- c(charset_lines, partition_line, set_line)
  cat(paste(block, collapse = "\n"))
}

# This function was written using the GitHub copilot LLM GPT-4.1 (created 27-Oct-2025).
# The prompt was to 'write a function that creates a MrBayes partition block from the output from phylodisc::homoplasy_bin()', and a sample partition block was copy pasted into the prompt.
# The function was then edited manually to ensure the output code was concatenated.
