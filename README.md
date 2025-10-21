# phylodisc

phylodisc provides tools for analysing discrete character data (typically morphological) in a phylogenetic context. It includes matrix homoplasy indices (RHI, HSR, HER), and allows calculation of per-character RHI and with multiphylo trees, as well as utilities to handle polymorphisms, uncertainties, invariant characters, accommodating character matrix changes in lists of ordered characters, and support for ordered multistate characters using cost matrices. It containts several wrappers and helpers to utilise functions from the 'ape' (Paradis and Schliep 2019), 'phangorn' (Schliep, 2011) and 'phytools' (Revell, 2024) packages, including creating a phydat object for morphological data that contains specific polymorphic states, a function to estimate ancestral states for discrete phylogenetic characters, and a function to create a Gower distance matrix that accounts for character ordering. Previous versions of this code were developed in the repository github.com/LizzySteell/Homoplasy with the original versions accompanying 'Revealing patterns of homoplasy in discrete phylogenetic datasets with a cross-comparable index' (Steell et al, 2025).

Paradis E, Schliep K (2019). “ape 5.0: an environment for modern phylogenetics and evolutionary analyses in R.” _Bioinformatics_, *35*, 526-528. doi:10.1093/bioinformatics/bty633
Schliep K.P. 2011. phangorn: phylogenetic analysis in R. Bioinformatics, 27(4) 592-593
Schliep, K., Potts, A. J., Morrison, D. A., Grimm, G. W. (2017), Intertwining phylogenetic trees and networks. Methods in Ecology and Evolution, 8: 1212--1220. doi: 10.1111/2041-210X.12760
Revell, L. J. (2024) phytools 2.0: an updated R ecosystem for phylogenetic comparative methods (and other things). PeerJ, 12, e16505.
Steell EM, Hsiang AY, Field DJ, Revealing patterns of homoplasy in discrete phylogenetic datasets with a cross-comparable index, Zoological Journal of the Linnean Society, Volume 204, Issue 1, May 2025, zlaf024, https://doi.org/10.1093/zoolinnean/zlaf024


## Installation

Install the development version from GitHub:

```r
# install remotes if needed
install.packages("remotes")
remotes::install_github("LizzySteell/phylodisc")
```

## Quick example

```r
library(phylodisc)
# example usage (replace with real objects)
# RHI.char(my_phydat, my_tree, n = 100)
```

## Citation and reproducibility


## Contributing

Please open issues for bug reports and feature requests. If you'd like to contribute, fork the repo, create a branch, and open a pull request.

## License

MIT — see LICENSE file.
