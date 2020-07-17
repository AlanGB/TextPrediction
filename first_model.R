setwd("~/Alán/CapstoneProject")

library(quanteda)
library(readr)

# Tokenization ####

train <- read_lines("./final/en_US/train_US.txt")
train.tokens <- tokens(train, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE, split_hyphens = TRUE)
train.tokens <- tokens_tolower(train.tokens)
train.tokens.dfm <- dfm(train.tokens, tolower = FALSE)
train.trigrams <- tokens_ngrams(train.tokens, n = 3)