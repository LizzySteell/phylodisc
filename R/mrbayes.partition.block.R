### 27-Oct-2025

# V1.0 mrbayes.partition.block function

#' Write a MrBayes partition block from homoplasy bins
#'
#' Prints `charset`, `partition` and `set partition` commands that can be
#' pasted into a MrBayes block. This code is a wedding gift to my dear friend
#' Juan Benito.
#'
#' @param homoplasy_bins Output from [homoplasy.bin()].
#' @param partition_name Name for the partition scheme.
#' @return Called for its printed output (via `cat()`); returns `NULL`
#'   invisibly.
#' @examples
#' bins <- list(bins = list(low = c(1, 2, 3), high = c(4, 5)))
#' mrbayes.partition.block(bins)
#' @export
mrbayes.partition.block <- function(homoplasy_bins, partition_name = "homoplasy") {
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
# The prompt was to 'write a function that creates a MrBayes partition block from the output from phylodisc::homoplasy.bin()', and a sample partition block was copy pasted into the prompt.
# The function was then edited manually to ensure the output code was concatenated.
