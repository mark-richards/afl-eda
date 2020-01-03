install.packages("devtools")
devtools::install_github("jimmyday12/fitzRoy")
library(fitzRoy)
library(dplyr)
library(ggplot2)
results <- get_match_results()

stats <- get_afltables_stats(start_date = "2000-01-01", end_date = "2019-11-01")
dat <- update_footywire_stats()
