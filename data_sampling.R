setwd("~/Alán/CapstoneProject")

#### Data Loading and Sampling####


library("readr")

n.twitter <- length(read_lines("./final/en_US/en_US.twitter.txt"))
n.blogs <- length(read_lines("./final/en_US/en_US.blogs.txt"))
n.news <- length(read_lines("./final/en_US/en_US.news.txt"))


# Sampling from the .txt files and saving the backup file
# TWITTER #
set.seed(123)
con <- file("./final/en_US/en_US.twitter.txt", "r")
for (i in 1:n.twitter) {
        if (rbinom(1,1,.15) == 1) {
                if (rbinom(1,1, .7) == 1) {
                        write(readLines(con,1), file = "./final/en_US/train_US.twitter.txt", append = TRUE)     
                } else {
                        if (rbinom(1,1, .2) == 1) {
                                write(readLines(con,1), file = "./final/en_US/validation_US.twitter.txt", append = TRUE)
                        } else {
                                write(readLines(con, 1), file = "./final/en_US/test_US.twitter.txt", append = TRUE)
                        }
                }
                
        }
}
close(con)

# BLOGS #

set.seed(456)
con <- file("./final/en_US/en_US.blogs.txt", "r")
for (i in 1:n.blogs) {
        if (rbinom(1,1,.15) == 1) {
                if (rbinom(1,1, .7) == 1) {
                        write(readLines(con,1), file = "./final/en_US/train_US.blogs.txt", append = TRUE)     
                } else {
                        if (rbinom(1,1, .2) == 1) {
                                write(readLines(con,1), file = "./final/en_US/validation_US.blogs.txt", append = TRUE)
                        } else {
                                write(readLines(con, 1), file = "./final/en_US/test_US.blogs.txt", append = TRUE)
                        }
                }
                
        }
}
close(con)


# NEWS #
news <- read_lines("./final/en_US/en_US.news.txt")
set.seed(789)
for (i in 1:length(news)) {
        if(rbinom(1,1,.15) == 1) {
                if (rbinom(1,1,.7) == 1) {
                        write(news[i], file = "./final/en_US/train_US.news.txt", append = TRUE)
                } else {
                        if (rbinom(1,1,.2) == 1) {
                                write(news[i], file = "./final/en_US/validation_US.news.txt", append = TRUE)
                        } else {
                                write(news[i], file = "./final/en_US/test_US.news.txt", append = TRUE)
                        }
                }
        }
}
rm(list = "news")
# remove files

rm(list = c('con', 'i', 'n.blogs', 'n.news', 'n.twitter', 'news', 'URL'))

# Consolidating files ####
# training file
con <- file("./final/en_US/train_US.twitter.txt", "r")
write(readLines(con), file = "./final/en_US/train_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/train_US.blogs.txt", "r")
write(readLines(con), file = "./final/en_US/train_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/train_US.news.txt", "r")
write(readLines(con), file = "./final/en_US/train_US.txt", append = TRUE)
close(con)

# training file
con <- file("./final/en_US/validation_US.twitter.txt", "r")
write(readLines(con), file = "./final/en_US/validation_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/validation_US.blogs.txt", "r")
write(readLines(con), file = "./final/en_US/validation_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/validation_US.news.txt", "r")
write(readLines(con), file = "./final/en_US/validation_US.txt", append = TRUE)
close(con)

# testing file
con <- file("./final/en_US/test_US.twitter.txt", "r")
write(readLines(con), file = "./final/en_US/test_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/test_US.blogs.txt", "r")
write(readLines(con), file = "./final/en_US/test_US.txt", append = TRUE)
close(con)

con <- file("./final/en_US/test_US.news.txt", "r")
write(readLines(con), file = "./final/en_US/test_US.txt", append = TRUE)
close(con)

# Samples overview ####

library(stringi)
library(formattable)

twitter.file <- ("./final/en_US/train_US.twitter.txt")
blogs.file <- ("./final/en_US/train_US.blogs.txt")
news.file <- ("./final/en_US/train_US.news.txt")

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

train.data.overview <- cbind(Size.MB, Rows, Words, Words.Ave)

train.data.overview$`Average Words` <- format(round(as.numeric(train.data.overview$`Average Words`),digits = 0), nsmall = 0)
train.data.overview$`Total Words` <- format(as.numeric(train.data.overview$`Total Words`), nsmall = 0, big.mark =",")
train.data.overview$Rows <- format(as.numeric(train.data.overview$Rows), nsmall=0, big.mark=",")
train.data.overview$Size.MB <- format(round(as.numeric(train.data.overview$Size.MB), 1), nsmall=1, big.mark=",")

formattable(train.data.overview, align = c('l', 'c', 'C', 'c', 'c'))