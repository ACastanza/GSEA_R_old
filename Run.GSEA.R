# GSEA 1.0.1 -- Gene Set Enrichment Analysis / Broad Institute 
#
# Executable R script to run GSEA Analysis
library("utils")
cat("\n")
GSEA.program.location <- readline(prompt = ("Input path to GSEA.1.0.R Source (or drop file into R window): "))   #  R source program (change pathname to the rigth location in local machine)
source(GSEA.program.location, verbose=T, max.deparse.length=9999)
cat("\n")
cat("\n")
cat("Starting...\n")
cat("\n")
inputds <- readline(prompt = ("Input path to GCT formatted gene expression dataset (or drop file into R window): "))
inputcls <- readline(prompt = ("Input path to experiment CLS file (or drop file into R window): "))
gsdb <- readline(prompt = ("Input path to GMT formatted gene set database (or drop file into R window): "))
collapsedataset <- askYesNo("Collapse data set to Gene Symbols? ")
if(collapsedataset == TRUE) {
	inputchip <- readline(prompt = ("Input path to CHIP platform file (or drop file into R window): "))
collapsemode <- menu(c("Max_probe","Median_of_probes","Sum_of_Probes"), graphics = FALSE, title = "Collapsing mode for probe sets => 1 gene")
	} else {
inputchip <- "NOCHIP"
collapsemode <- 0
}

reshuffetype <- menu(c("Phenotype","gene_set"), graphics = FALSE, title = "Select GSEA Permutation Type (recommended: Phenotype)")
cat("\n")
maxsize <- readline(prompt = ("Max size: exclude larger sets (recommended value: 500): "))
minsize <- readline(prompt = ("Min size: exclude smaller sets (recommended value: 15): "))
cat("\n")
outdir <- readline(prompt = ("Drop a directory into R window to use as the output folder or enter directory path: "))
cat("\n")
outname <- readline(prompt = ("Enter a prefix to label output files: "))
cat("\n")

if (reshuffetype == 1){
permutation <- "sample.labels"
} else if (reshuffetype == 2){
permutation <- "gene.labels"
}

GSEA(
# Input/Output Files :-------------------------------------------------------------------------------
 input.ds = inputds,                    # Input gene expression dataset file in GCT format
 input.cls = inputcls,                  # Input class vector (phenotype) file in CLS format
 gs.db = gsdb,                          # Gene set database in GMT format
 input.chip = inputchip,               # CHIP File
 output.directory      = outdir,        # Directory where to store output and results (default: "")
#  Program parameters :-------------------------------------------------------------------------------
 doc.string            = outname,         # Documentation string used as a prefix to name result files (default: "GSEA.analysis")
 non.interactive.run   = F,               # Run in interactive (i.e. R GUI) or batch (R command line) mode (default: F)
 reshuffling.type      = permutation,     # Type of permutation reshuffling: "sample.labels" or "gene.labels" (default: "sample.labels" 
 nperm                 = 1000,            # Number of random permutations (default: 1000)
 weighted.score.type   =  1,              # Enrichment correlation-based weighting: 0=no weight (KS), 1= weigthed, 2 = over-weigthed (default: 1)
 nom.p.val.threshold   = -1,              # Significance threshold for nominal p-vals for gene sets (default: -1, no thres)
 fwer.p.val.threshold  = -1,              # Significance threshold for FWER p-vals for gene sets (default: -1, no thres)
 fdr.q.val.threshold   = 0.25,            # Significance threshold for FDR q-vals for gene sets (default: 0.25)
 topgs                 = 20,              # Besides those passing test, number of top scoring gene sets used for detailed reports (default: 10)
 adjust.FDR.q.val      = F,               # Adjust the FDR q-vals (default: F)
 gs.size.threshold.min = minsize,         # Minimum size (in genes) for database gene sets to be considered (default: 25)
 gs.size.threshold.max = maxsize,         # Maximum size (in genes) for database gene sets to be considered (default: 500)
 reverse.sign          = F,               # Reverse direction of gene list (pos. enrichment becomes negative, etc.) (default: F)
 preproc.type          = 0,               # Preproc.normalization: 0=none, 1=col(z-score)., 2=col(rank) and row(z-score)., 3=col(rank). (def: 0)
 random.seed           = as.numeric(as.POSIXct(Sys.time())),            # Random number generator seed. (default: 123456)
 perm.type             = 0,               # For experts only. Permutation type: 0 = unbalanced, 1 = balanced (default: 0)
 fraction              = 1.0,             # For experts only. Subsampling fraction. Set to 1.0 (no resampling) (default: 1.0)
 replace               = F,               # For experts only, Resampling mode (replacement or not replacement) (default: F)
 collapse.dataset      = collapsedataset, # Collapse dataset to gene symbols using a user provided chip file (default: F)
 collapse.mode         = collapsemode,
 save.intermediate.results = F,           # For experts only, save intermediate results (e.g. matrix of random perm. scores) (default: F)
 use.fast.enrichment.routine = T          # Use faster routine to compute enrichment for random permutations (default: T)
)
#----------------------------------------------------------------------------------------------------------

# Overlap and leading gene subset assignment analysis of the GSEA results

GSEA.Analyze.Sets(
   directory           = outdir,        # Directory where to store output and results (default: "")
   topgs = 20,                                                           # number of top scoring gene sets used for analysis
   height = 16,
   width = 16
)
