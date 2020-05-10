#Removing the pre-loaded variables from the screen 
rm(list = ls())

#Clearing the screen
cat("\014")

#Installing the required files
library(downloader)

library(tidyr)

library(rvest)

library(dplyr)

#Selecting the URL you want to scrape
url <- 'https://www.futwiz.com/en/fifa20/players'

#We first create a html document from a URL 
webpage <- read_html(url)

#Selecting parts of the HTML document using CSS selector
table <- html_nodes(webpage,'.col-12')

#Now we select all the text inside the tag
table_text <- html_text(table)

#Cleansing the data 
table_text <- str_replace_all(table_text, "\n", " ")

#Splitting the data based on spaces
temp <- str_split(table_text[1]," ")

#Removing the space characters from the list
temp <- lapply(temp, function(x) x[nchar(x) >= 1])
 
#Selecting the relevant parts of the list
temp <- temp[[1]][1:225]

#Converting data into a df
df <- data.frame(matrix(temp, nrow=25, byrow=T))

#Renaming columns 
colnames(df) <- c("Player Name","Rating","Position","Pace","Dribbling","Shot","Defense","Passing","Physicality")

#Removing irrelevant stuff
df[,4:9] <- sapply(df[,4:9],function(x) gsub('[A-Z]+','',x))

#Selecting the attributes of images here 
ImageURL <- webpage%>%
html_nodes(css = "img") %>%
  html_attr("src")

#Setting wd for storing the images 
setwd("C:/Users/aishwarya.sharma/OneDrive - insidemedia.net/Dell Lattitude - 5300/Aishwarya/Office Training/Images")

#For downloading images on the website
for (i in 0:(length(ImageURL)-1)){
  j = i + 1 
  download(paste0("https://www.futwiz.com/",ImageURL[j]),paste0("test",j,".jpg"), mode =  "wb" )
}
