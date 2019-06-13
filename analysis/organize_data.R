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

pew$nativity <- factor(ifelse(pew$qn4>=8, NA,
                              ifelse(pew$qn4==2, "Native-born", "Foreign-born")),
                       levels=c("Native-born","Foreign-born"))
table(pew$qn4, pew$nativity, exclude=NULL)

pew$home_own <- factor(ifelse(pew$qn43>3, NA,
                              ifelse(pew$qn43>1, "Do not own", "Own")),
                       levels=c("Do not own","Own"))
table(pew$qn43, pew$home_own, exclude=NULL)

pew$home_investment <- factor(ifelse(pew$qn46>3, NA,
                              ifelse(pew$qn46>1, "Disagree", "Agree")),
                       levels=c("Disagree","Agree"))
table(pew$qn46, pew$home_investment, exclude=NULL)

pew$american_perc <- factor(ifelse(pew$qn54>3, NA,
                              ifelse(pew$qn54>1, "Different from American", "Typical American")),
                       levels=c("Different from American","Typical American"))
table(pew$qn54, pew$american_perc, exclude=NULL)

pew$culture_view <- factor(ifelse(pew$qn63>3, NA,
                                   ifelse(pew$qn63>1, "Different from American", "Typical American")),
                            levels=c("Different from American","Typical American"))
table(pew$qn63, pew$culture_view, exclude=NULL)

pew$minor_succe <- factor(ifelse(pew$qn64>3, NA,
                                   ifelse(pew$qn64>1, "Less successful", "Successful")),
                            levels=c("Less successful", "Successful"))
table(pew$qn64, pew$minor_succe, exclude=NULL)

pew$exper_better_country <- factor(ifelse(pew$qn66a>3, NA, pew$qn66a),
                                levels=c(2,3,1),
                                labels=c("Better in home country",
                                         "Same",
                                         "Better in US"))
table(pew$qn66a, pew$exper_better_country, exclude=NULL)

pew$exper_moral <- factor(ifelse(pew$qn66b>3, NA, pew$qn66b),
                                levels=c(2,3,1),
                                labels=c("Better in home country",
                                         "Same",
                                         "Better in US"))
table(pew$qn66b, pew$exper_moral, exclude=NULL)

pew$exper_family_ties <- factor(ifelse(pew$qn66c>3, NA, pew$qn66c),
                                levels=c(2,3,1),
                                labels=c("Better in home country",
                                         "Same",
                                         "Better in US"))
table(pew$qn66c, pew$exper_family_ties, exclude=NULL)

pew$exper_opportunity <- factor(ifelse(pew$qn66d>3, NA, pew$qn66d),
                                levels=c(2,3,1),
                                labels=c("Better in home country",
                                         "Same",
                                         "Better in US"))
table(pew$qn66d, pew$exper_opportunity, exclude=NULL)

pew$exper_raising_child <- factor(ifelse(pew$qn66f>3, NA, pew$qn66f),
                                levels=c(2,3,1),
                                labels=c("Better in home country",
                                         "Same",
                                         "Better in US"))
table(pew$qn66f, pew$exper_raising_child, exclude=NULL)

pew$age <- ifelse(pew$qn95>97, NA, pew$qn95)

tab <- table(pew$home_own, pew$home_investment, pew$exper_better_country, pew$exper_moral, pew$exper_family_ties, pew$exper_opportunity, pew$exper_raising_child)
round(100*prop.table(tab, 1),1)
library(ggplot2)


pew <- subset(pew, 
              select=c("home_own","home_investment","american_perc","culture_view",
                       "nativity","age","minor_succe","exper_better_country",
                       "exper_moral","exper_family_ties","exper_opportunity",
                       "exper_raising_child"))

save(pew, file="output/analytical_data.RData")
