setwd("~/Alán/CapstoneProject")

library(readr)
library(quanteda)
library(tm)
library(ggplot2)
library(gridExtra)
train <- read_lines("./final/en_US/train_US.txt")

# Data Pipeline: ####

# 0. Tokenize
# 1. Lowercase
# 2. Remove punctuation
# 3. Remove numbers
# 4. Tokenization
#       4.1 1-gram model
#       4.2 2-gram model
#       4.3 3-gram model
# tokenization ####

train.tokens <- tokens(train, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE, split_hyphens = TRUE)

train.tokens <- tokens_tolower(train.tokens)
#train.tokens <- tokens_select(train.tokens, stopwords(), selection = "remove")
#train.tokens <- tokens_wordstem(train.tokens, language = "english")
train.tokens.dfm <- dfm(train.tokens, tolower = FALSE)



train.unigram.freq <- textstat_frequency(train.tokens.dfm, n = 20)
train.unigram.freq$feature <- factor(train.unigram.freq$feature,
                                     levels = train.unigram.freq$feature[order(train.unigram.freq$frequency)])



unigrams.plot <- ggplot(train.unigram.freq, 
                        aes(x = train.unigram.freq$feature,
                            y = train.unigram.freq$frequency)) +
        geom_col() + coord_flip() + labs(x = NULL, y = "Frequency")

textplot_wordcloud(train.tokens.dfm, max_words = 100)


wordcloud
unigrams.plot
