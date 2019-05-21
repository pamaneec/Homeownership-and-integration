#' ---
#' title: "organize_data.R"
#' author: ""
#' ---

# This script will read in raw data from the input directory, clean it up to produce 
# the analytical dataset, and then write the analytical data to the output directory. 

#source in any useful functions
source("useful_functions.R")

library(haven)
pew <- read_sav("input/PHCNSL2011PubRelease.sav")

pew$home_own <- factor(ifelse(pew$qn43>3, NA,
                              ifelse(pew$qn43>1, "Do not own", "Own")),
                       levels=c("Do not own","Own"))
table(pew$qn43, pew$home_own, exclude=NULL)

