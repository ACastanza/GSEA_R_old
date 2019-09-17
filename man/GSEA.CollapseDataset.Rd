\name{GSEA.CollapseDataset}
\alias{GSEA.CollapseDataset}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Applies a .CHIP file to a .GCT to map identifiers to gene symbols using a specified collapse function}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
GSEA.CollapseDataset(dataplatform = chip, gct = dataset, collapse.mode = collapsemode)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataplatform}{
%%     ~~Describe \code{dataplatform} here~~
}
  \item{gct}{
%%     ~~Describe \code{gct} here~~
}
  \item{collapse.mode}{
%%     ~~Describe \code{collapse.mode} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (dataplatform = chip, gct = dataset, collapse.mode = collapsemode) 
{
    probemap <- unique(dataplatform[, c("Probe.Set.ID", "Gene.Symbol")])
    annotate <- unique(dataplatform[, c("Gene.Symbol", "Gene.Title")])
    mappedgct <- merge(x = probemap, y = gct, by.x = 1, by.y = 1, 
        all = FALSE, no.dups = FALSE)
    mappedgct = unique(subset(mappedgct, select = -c(1)))
    mappedgct <- unique(mappedgct[, -c(2)])
    mappedgct[, c(2:ncol(mappedgct))] <- sapply(mappedgct[, c(2:ncol(mappedgct))], 
        as.numeric)
    if (collapse.mode == 1) {
        mappedexp <- mappedgct \%>\% group_by(Gene.Symbol) \%>\% 
            summarise_all(max) \%>\% data.frame()
    }
    if (collapse.mode == 2) {
        mappedexp <- mappedgct \%>\% group_by(Gene.Symbol) \%>\% 
            summarise_all(median) \%>\% data.frame()
    }
    if (collapse.mode == 3) {
        mappedexp <- mappedgct \%>\% group_by(Gene.Symbol) \%>\% 
            summarise_all(sum) \%>\% data.frame()
    }
    mappedexp_2 <- unique(merge(x = annotate, y = mappedexp, 
        by.x = "Gene.Symbol", by.y = "Gene.Symbol"))
    colnames(mappedexp_2)[2] <- "Description"
    return(mappedexp_2)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
