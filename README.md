# phylodisc

phylodisc provides tools for analysing discrete character data (typically morphological) in a phylogenetic context. It includes matrix homoplasy indices (RHI, HSR, HER), and allows calculation of per-character RHI and with multiphylo trees, as well as utilities to handle polymorphisms, uncertainties, invariant characters, accommodating character matrix changes in lists of ordered characters, and support for ordered multistate characters using cost matrices. It contains several wrappers and helpers to utilise functions from the 'ape' (Paradis and Schliep 2019), 'phangorn' (Schliep, 2011) and 'corHMM' (Boyko & Beaulieu, 2021) packages, including creating a phydat object for morphological data that contains specific polymorphic states, a function to estimate ancestral states for discrete phylogenetic characters, and a function to create a MORD (based on Gower distance) matrix that accounts for character ordering. Previous versions of this code were developed in the repository https://github.com/LizzySteell/Homoplasy with the original versions accompanying 'Revealing patterns of homoplasy in discrete phylogenetic datasets with a cross-comparable index' (Steell et al, 2025).


## Installation

```r
# install.packages("remotes")
remotes::install_github("LizzySteell/phylodisc@r-package")
library(phylodisc)
```

The original function files remain in `functions/` and can still be loaded with `source()`.


## Quick example



## Citation and reproducibility


## Contributing

Please open issues for bug reports and feature requests. If you'd like to contribute, fork the repo, create a branch, and open a pull request.

## References

Boyko JD, Beaulieu JM. Generalized hidden Markov models for phylogenetic comparative datasets. Methods in Ecology and Evolution. 2021 Mar;12(3):468-78.

Paradis E, Schliep K (2019). “ape 5.0: an environment for modern phylogenetics and evolutionary analyses in R.” _Bioinformatics_, *35*, 526-528. doi:10.1093/bioinformatics/bty633

Schliep K.P. 2011. phangorn: phylogenetic analysis in R. Bioinformatics, 27(4) 592-593

Schliep, K., Potts, A. J., Morrison, D. A., Grimm, G. W. (2017), Intertwining phylogenetic trees and networks. Methods in Ecology and Evolution, 8: 1212--1220. doi: 10.1111/2041-210X.12760

Revell, L. J. (2024) phytools 2.0: an updated R ecosystem for phylogenetic comparative methods (and other things). PeerJ, 12, e16505.

Steell EM, Hsiang AY, Field DJ, Revealing patterns of homoplasy in discrete phylogenetic datasets with a cross-comparable index, Zoological Journal of the Linnean Society, Volume 204, Issue 1, May 2025, zlaf024, https://doi.org/10.1093/zoolinnean/zlaf024

Archie JW (1989) Homoplasy excess ratios: new indices for measuring levels of homoplasy in phylogenetic systematics and a critique of the consistency index. Systematic Zoology 38(3):253-269.

Beaulieu JM, O'Meara BC, Donoghue MJ (2013) Identifying hidden rate changes in the evolution of a binary morphological character: the evolution of plant habit in campanulid angiosperms. Systematic Biology 62(5):725-737.

Brocklehurst N, Panciroli E, Benevento GL, Benson RB (2021) Mammaliaform extinctions as a driver of the morphological radiation of Cenozoic mammals. Current Biology 31(13):2955-2963.

Brocklehurst N, Benson RJ (2021) Multiple paths to morphological diversification during the origin of amniotes. Nature Ecology & Evolution 5(9):1243-1249.

Brocklehurst N, Ford DP, Benson RB (2022) Early origins of divergent patterns of morphological evolution on the mammal and reptile stem-lineages. Systematic Biology 71(5):1195-1209.

Delignette-Muller ML, Dutang C (2015) fitdistrplus: an R package for fitting distributions. Journal of Statistical Software 64(4):1-34.

Gower JC (1971) A general coefficient of similarity and some of its properties. Biometrics 27(4):857-871.

Guillerme T (2018) dispRity: a modular R package for measuring disparity. Methods in Ecology and Evolution 9(7):1755-1763.

Meier R, Kores P, Darwin S (1991) Homoplasy slope ratio: a better measurement of observed homoplasy in cladistic analyses. Systematic Zoology 40(1):74-88.

Nixon KC (1999) The parsimony ratchet, a new method for rapid parsimony analysis. Cladistics 15(4):407-414.

Pennell MW, Eastman JM, Slater GJ, Brown JW, Uyeda JC, FitzJohn RG, Alfaro ME, Harmon LJ (2014) geiger v2.0: an expanded suite of methods for fitting macroevolutionary models to phylogenetic trees. Bioinformatics 30(15):2216-2218.

Ronquist F, Teslenko M, van der Mark P, Ayres DL, Darling A, Hohna S, Larget B, Liu L, Suchard MA, Huelsenbeck JP (2012) MrBayes 3.2: efficient Bayesian phylogenetic inference and model choice across a large model space. Systematic Biology 61(3):539-542.

Sankoff D, Rousseau P (1975) Locating the vertices of a Steiner tree in an arbitrary metric space. Mathematical Programming 9:240-246.

Smith MR (2019) TreeTools: create, modify and analyze phylogenetic trees. Comprehensive R Archive Network. https://doi.org/10.5281/zenodo.3522725

## License

phylodisc is free software, released under the GNU General Public License, version 3 or (at your option) any later version (GPL-3.0-or-later). See the [LICENSE](LICENSE) file.
