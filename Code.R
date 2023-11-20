if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GenVisR")


# Load GenVisR and set seed
library(GenVisR)


brca_data <- read.csv("brcaMAF_data.csv")


# Plot only genes with mutations in 6% or more of samples
waterfall(brcaMAF, mainRecurCutoff = 0.06)


dev.new()

# Plot only the specified genes
waterfall(brcaMAF, plotGenes = c("PIK3CA", "TP53", "USH2A", "MLL3", "BRCA1"))


dev.new()

# Create clinical data
subtype <- c("lumA", "lumB", "her2", "basal", "normal")
subtype <- sample(subtype, 50, replace = TRUE)
age <- c("20-30", "31-50", "51-60", "61+")
age <- sample(age, 50, replace = TRUE)
sample <- as.character(unique(brcaMAF$Tumor_Sample_Barcode))
clinical <- as.data.frame(cbind(sample, subtype, age))

# Melt the clinical data into 'long' format.
library(reshape2)
clinical <- melt(clinical, id.vars = c("sample"))

# Run waterfall
waterfall(brcaMAF, clinDat = clinical, clinVarCol = c(lumA = "blue4", lumB = "deepskyblue",
    her2 = "hotpink2", basal = "firebrick2", normal = "green4", `20-30` = "#ddd1e7",
    `31-50` = "#bba3d0", `51-60` = "#9975b9", `61+` = "#7647a2"), plotGenes = c("PIK3CA",
    "TP53", "USH2A", "MLL3", "BRCA1"), clinLegCol = 2, clinVarOrder = c("lumA", "lumB",
    "her2", "basal", "normal", "20-30", "31-50", "51-60", "61+"))

