GSEA.ReadCHIPFile <-
function(file = "NULL") {
 read.table(file, sep = "\t", comment.char = "", quote = "", stringsAsFactors = FALSE,
  fill = TRUE, header = T)
}
