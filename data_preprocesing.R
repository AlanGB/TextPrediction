setwd("~/Alán/CapstoneProject")

library(readr)
library(quanteda)
library(tm)

train <- read_lines("./final/en_US/train_US.txt")

# Data Pipeline: ####
# Profanitry Filtering
# 0. Tokenize
# 1. Lowercase
# 2. Remove stop words
# 3. Stemming words
# 4. Unigram-model

train <- iconv(train, to = "UTF-8")
train <- tolower(train)
train <- removePunctuation(train)
train <- removeNumbers(train)
train <- stripWhitespace(train)


con <- url("http://www.bannedwordlist.com/lists/swearWords.txt","r")
badwords <- readLines(con)
close(con)

train <- removeWords(train, badwords)

start.time <- Sys.time()
train.tokens <- tokens(train, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE, split_hyphens = TRUE)
total.time <- start.time - Sys.time()

start.time <- Sys.time()
train.tokens <- tokens_tolower(train.tokens)
train.tokens <- tokens_select(train.tokens, stopwords(), selection = "remove")
train.tokens <- tokens_wordstem(train.tokens, language = "english")
train.tokens.dfm <- dfm(train.tokens, tolower = FALSE)
total.time <- start.time - Sys.time()