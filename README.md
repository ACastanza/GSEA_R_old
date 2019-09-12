# GSEA R Implementation v1.1
## Revisions to the GSEA-P R Application (Subramanian and Tamayo et al 2005)

Preliminary revisions to the original GSEA implementation in R to enable it to run on modern R distributions.
Recommended R minimum version: 3.6

Additionally, a rudimentary Collapse dataset function has been backported from the Java GSEA application, however differences in the implementation result in inconsistencies with the desktop collapse function.

GSEA-R v1.1 contains a preliminary implementation of GSEA-preranked. This implementation has not been thoroughly tested and is reliant on undocumented gene set permutation code.

The collapse dataset feature requires the <tt>dplyr</tt> package from <tt>tidyverse</tt>

You may install this requirement from CRAN with <tt>install.packages("dplyr")</tt>

The original R-GSEA documentation indicates that it supports "phenotype permutation" mode only, however, code was present in the application to perform gene set permutation testing. This code has been enabled, but not tested.

R-GSEA remains unsupported by the GSEA-MSigDB Team.

See the original R-GSEA readme here: https://software.broadinstitute.org/cancer/software/gsea/wiki/index.php/R-GSEA_Readme

<b>Known Issues:</b> FDR q-value reporting is broken in GSEA-preranked in this build. Code currently reports "1" for all results.
