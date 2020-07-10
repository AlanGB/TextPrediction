library(readr)
library(quanteda)

train <- read_lines("./final/en_US/train_US.txt")

# Data Pipeline: ####
# 0. Tokenize
# 1. Lowercase
# 2. Remove stop words
# 3. Stemming words
# 4. Unigram-model

train.tokens <- tokens(train, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE, split_hyphens = TRUE)

train.tokens <- tokens_tolower(train.tokens)
train.tokens <- tokens_select(train.tokens, stopwords(), selection = "remove")
train.tokens <- tokens_wordstem(train.tokens, language = "english")
train.tokens.dfm <- dfm(train.tokens, tolower = FALSE)