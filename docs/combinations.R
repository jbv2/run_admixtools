library(dplyr)

## Read args from command line
args = commandArgs(trailingOnly=TRUE)

## Passing args to named objects
combinations <- args[1]
output_name <- gsub(x = combinations, pattern = ".tmp", replacement = ".txt")

df = read.csv(file = combinations, stringsAsFactors = F, header = F, sep = "\t")

df = df[!duplicated(t(apply(df[c("V3", "V4")], 1, sort))), ]

## Write output
write.table(x = df, file = output_name, append = F, quote = F, sep = "\t", row.names = F, col.names = F)



