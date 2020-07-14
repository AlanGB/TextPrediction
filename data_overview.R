setwd("~/Alán/CapstoneProject")

library(readr)
library(tm)
library(stringi)
library(formattable)

#### Data Downloading and Extraction####

URL <- c("https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip")
download.file(URL, "./Coursera-Swiftkey.zip")

unzip("Coursera-Swiftkey.zip", list = FALSE,files = c("final/en_US/en_US.twitter.txt",
                                                       "final/en_US/en_US.blogs.txt",
                                                       "final/en_US/en_US.news.txt"))

#### Data Overview ####

twitter.file <- ("./final/en_US/en_US.twitter.txt")
blogs.file <- ("./final/en_US/en_US.blogs.txt")
news.file <- ("./final/en_US/en_US.news.txt")

twitter <- read_lines(twitter.file)
blogs <- read_lines(blogs.file)
news <- read_lines(news.file)


rows <- c("Twitter", "Blogs", "News")

Size.MB <- setNames(as.data.frame(
                        file.size(twitter.file, blogs.file, news.file)/1024,
                        row.names = rows),
                    c("Size.MB"))

Rows <- setNames(as.data.frame(c(length(twitter), length(blogs), length(news)),
                               row.names = rows),
                 c("Rows"))

Words <- setNames(as.data.frame(c(sum(stri_count_words(twitter)),
                         sum(stri_count_words(blogs)),
                         sum(stri_count_words(news))),
                         row.names= rows),
                  c("Total Words"))

Words.Ave <- setNames(as.data.frame(c(mean(stri_count_words(twitter)),
                                      mean(stri_count_words(blogs)),
                                      mean(stri_count_words(news))),
                                    row.names = rows),
                      c("Average Words"))

data.overview <- cbind(Size.MB, Rows, Words, Words.Ave)

data.overview$`Average Words` <- format(round(as.numeric(data.overview$`Average Words`),digits = 0), nsmall = 0)
data.overview$`Total Words` <- format(as.numeric(data.overview$`Total Words`), nsmall = 0, big.mark =",")
data.overview$Rows <- format(as.numeric(data.overview$Rows), nsmall=0, big.mark=",")
data.overview$Size.MB <- format(round(as.numeric(data.overview$Size.MB), 1), nsmall=1, big.mark=",")

formattable(data.overview, align = c("l", "c", "C", "c", "c"))