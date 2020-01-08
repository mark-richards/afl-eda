install.packages("devtools")
install.packages("XML")
devtools::install_github("jimmyday12/fitzRoy")
library(fitzRoy)
library(dplyr)
library(ggplot2)
library(stringr)
library(XML)
library(rvest)
library(tidyr)
library(dplyr)
library(ggplot2)

main.page<-read_html(x="http://www.footywire.com/afl/footy/ft_match_list?year=2019")
urls<-main.page %>% ###get main page then we get links from main page
  html_nodes(".data:nth-child(5) a")%>%
  html_attr("href") #extract the urls
scores<-main.page%>%
  html_nodes(".data:nth-child(5) a")%>%
  html_text()
team.names<-main.page%>%
  html_nodes(".data:nth-child(2)")%>%
  html_text()
team.names
matchstats<-data.frame(team.names=team.names,scores=scores,urls=urls,stringsAsFactors = FALSE)
head(matchstats)
head(matchstats)
x1<- matchstats%>%
  separate(urls,c("urls","ID"),sep="=")
x2<-x1%>%separate(team.names,c("Home","Away"),sep="\nv")
x3<-x2%>%separate(scores,c("home.score","away.score"),sep="-")
head(x3) ##looking at our final ID set
head(x1)
default.url <-  "http://www.footywire.com/afl/footy/ft_match_statistics?mid="
basic  <-  data.frame()
for (i in x1$ID) {
  i=i
  print(i) ##prints data as it runs so we don't wait till end
  sel.url      <-  paste(default.url, i, sep="") ##paste forms the url, try a test case when i=2999 and run and see what happens
  htmlcode     <- readLines(sel.url) ###in the same test case type htmlcode hit enter
  export.table <- readHTMLTable(htmlcode) ##like the example before, gets all the tables
  top.table    <- as.data.frame(export.table[12]) ##looking at tables, 13 is the top one
  bot.table    <- as.data.frame(export.table[16]) ## 17 is the bottom table
  ind.table    <- rbind(top.table, bot.table) ##rbind, binds the top table to the bottom table
  ind.table$MatchId <- rep(i, nrow(ind.table)) ##this is adding a match ID which is the unique end of the url
  print(summary(ind.table))
  basic  <- rbind(basic, ind.table)
}
basic

