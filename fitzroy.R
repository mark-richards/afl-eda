install.packages("devtools")
devtools::install_github("jimmyday12/fitzRoy")
library(fitzRoy)
library(dplyr)
library(ggplot2)

stats <- get_afltables_stats(start_date = "2000-01-01", end_date = "2019-11-01")
footywire_data <- update_footywire_stats()
match_results <- get_match_results()


currentDate <- format(Sys.time(), "%Y-%m-%d_%H-%M")
csvFileName <- paste("match_results ",currentDate,".csv",sep="") 
write.csv(match_results, csvFileName)
