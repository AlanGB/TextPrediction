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