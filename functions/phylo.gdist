### 2025-10-28
### Gower distance matrix for phylogenetic datasets - phylo.gdist() v2.1
### This generates a distance matrix from discrete phylogenetic data where missing data are ignored so they are not considered in the calculations and do not skew the matrix.
### StatMatch dependency in this version is no longer necessary due to need for creating custom code to obtain Gower distances when polymorphisms are included.
### Notes:
### Preprocessing requirements: Exclude invariant characters using phylodisc::remove.invar. Gaps and ambiguities are treated the same as missing data (encoded as NA within function).
###	Ordered characters are allowed and can be specified in the optional argument 'ord'. Use phylodisc::adjust.ord to generate a new vector of ordered characters if remove.invar applied to matrix.
### Distances between states in ordered characters are step-wise and the values normalised so all pairwise per-character distances calculated across matrix are either 0, 1 or a value between in the case of ordered multistate characters.
### NEW: Polymorphisms and character ordering have been dealt with but need closer scrutiny with test data.
### NEW: Options to deal with taxon pairs with non-overlapping character scorings. Use argument 'incompat_handling'. Default option is to leave untreated so resulting distance matrix will contain NaNs indicating
### non-overlap (incompatible taxon pairs). Addition options: 'median' calculates the median pairwise distance across the matrix and swaps NaNs with median distance.
### 'empirical' samples values randomly from all calculated pairwise distances. Preferred option if NaNs must be avoided in downstream analyses (e.g. for ordination).


#######

phylo.gdist <- function(matrix, ord=NULL, incompat_handling=NULL){
	
	# If not specified, default to "NaN"
	if (is.null(incompat_handling)) incompat_handling <- "NaN"
	incompat_handling <- match.arg(incompat_handling, choices = c("NaN", "median", "empirical"))
	
	# Matrix - phylogenetic dataset; ord - vector of ordered characters (default = null)
	
	# Helper to parse polymorphisms coded within round brackets [copilot GPT-4.1 assisted]
	parse_states <- function(x) {
	  # Handle missing, blank, empty input robustly
	  if (is.null(x) || length(x) == 0 || any(is.na(x)) || any(x == "")) return(NA)
	  s <- as.character(x)
	  if (any(is.na(s)) || any(s == "")) return(NA)
	  out <- unlist(lapply(s, function(si) {
	    if (is.na(si) || si == "") return(NA)
	    if (grepl("^\\([0-9]+\\)$", si)) {
	      si <- gsub("[()]", "", si)
	    }
	    split_states <- strsplit(si, "")[[1]]
	    # If split_states is empty, treat as missing
	    if (length(split_states) == 0 || all(is.na(split_states)) || all(split_states == "")) return(NA)
	    split_states
	  }))
	  # Key fix: if out is empty or only NA, treat as missing
	  if (is.null(out) || length(out) == 0 || all(is.na(out)) || all(out == "")) return(NA)
	  return(out)
	}
	
	# Custom ordered distance for polymorphisms (minimum pairwise distance) [copilot GPT-4.1 assisted]
	ordered.poly.distance <- function(a_idx, b_idx, levels) {
	  # OPTIMISED: Pass indices directly, skip parsing
	  if (is.null(a_idx) || is.null(b_idx) || length(a_idx) == 0 || length(b_idx) == 0 ||
	      any(is.na(a_idx)) || any(is.na(b_idx))) return(NA)
	  dists <- abs(outer(a_idx, b_idx, "-"))
	  return(min(dists))
	}
	
	# Custom unordered (Gower) distance for polymorphisms (minimum, i.e. 0 if any overlap in states between taxon pairs) [copilot GPT-4.1 assisted]
	unordered.poly.distance <- function(a, b) {
	  # OPTIMISED: Use pre-parsed states
	  if (is.null(a) || is.null(b) || length(a) == 0 || length(b) == 0 ||
	      all(is.na(a)) || all(is.na(b))) return(NA)
	  if (length(intersect(a, b)) > 0) {
	    return(0)
	  } else {
	    return(1)
	  }
	}
	
	# Convert matrix to dataframe
	df <- data.frame(matrix, stringsAsFactors=FALSE)
	df[df == "-"] <- NA
	df[df == "?"] <- NA
	
	n <- nrow(df)
	p <- ncol(df)
	parsed_states <- matrix(vector("list", n * p), nrow = n, ncol = p)
	parsed_lengths <- matrix(0, nrow = n, ncol = p) # OPTIMISED: Precompute lengths
	for (i in 1:n) {
		for (k in 1:p) {
			ps <- parse_states(df[i, k])
			parsed_states[[i, k]] <- ps
			parsed_lengths[i, k] <- ifelse(is.null(ps), 0, length(ps))
		}
	}
	
	ordered_levels_list <- list()
	parsed_indices <- matrix(vector("list", n * p), nrow = n, ncol = p)
	if (!is.null(ord)) {
		for (i in ord) {
			levels <- get.states(df[, i]) # use phylodisc function get.states
			ordered_levels_list[[as.character(i)]] <- levels
			for (row in 1:n) {
				states <- parsed_states[[row, i]]
				if (is.null(states) || length(states) == 0 || all(is.na(states))) {
					parsed_indices[[row, i]] <- NA
				} else {
					parsed_indices[[row, i]] <- match(states, levels)
				}
			}
		}
	}
	
	dist <- matrix(NA, n, n)
	rownames(dist) <- rownames(df)
	colnames(dist) <- rownames(df)
	
	# OPTIMISED: Use precomputed parsed_states, parsed_indices, parsed_lengths
	for (i in 1:n) {
		for (j in i:n) {
			total <- 0
			n_valid <- 0
			for (k in 1:p) {
				if (!is.null(ord) && k %in% ord) {
					levels <- ordered_levels_list[[as.character(k)]]
					a_idx <- parsed_indices[[i, k]]
					b_idx <- parsed_indices[[j, k]]
					# Use precomputed lengths and indices
					if (is.null(a_idx) || is.null(b_idx) || length(a_idx) == 0 || length(b_idx) == 0 ||
					    any(is.na(a_idx)) || any(is.na(b_idx))) {
						d <- NA
					} else {
						d <- ordered.poly.distance(a_idx, b_idx, levels)
						if (length(levels) > 1) d <- d / (length(levels) - 1)
					}
				} else {
					a <- parsed_states[[i, k]]
					b <- parsed_states[[j, k]]
					# Use precomputed lengths
					if (parsed_lengths[i, k] == 0 || parsed_lengths[j, k] == 0 ||
					    is.null(a) || is.null(b) || all(is.na(a)) || all(is.na(b))) {
						d <- NA
					} else {
						d <- unordered.poly.distance(a, b)
					}
				}
				if (!is.na(d)) {
					total <- total + d
					n_valid <- n_valid + 1
				}
			}
			if (n_valid > 0) {
				dist[i, j] <- dist[j, i] <- total / n_valid
			} else {
				dist[i, j] <- dist[j, i] <- NaN
			}
		}
	}
	
	if (incompat_handling == "median") {
		median_dist <- median(dist[!is.nan(dist)], na.rm=TRUE)
		dist[is.nan(dist)] <- median_dist
	} else if (incompat_handling == "empirical") {
		obs <- dist[!is.nan(dist)]
		dist[is.nan(dist)] <- sample(obs, sum(is.nan(dist)), replace=TRUE)
	}
	
	return(dist)
}
