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


# UNIGRAMS ####
train.unigram.freq <- textstat_frequency(train.tokens.dfm, n = 20)
train.unigram.freq$feature <- factor(train.unigram.freq$feature,
                                     levels = train.unigram.freq$feature[order(train.unigram.freq$frequency)])
unigrams.plot <- ggplot(train.unigram.freq, 
                        aes(x = train.unigram.freq$feature,
                            y = train.unigram.freq$frequency)) +
        geom_col() + coord_flip() + labs(x = NULL, y = "Frequency") +
        ggtitle("Top 20 Unigrams Frequency")
unigrams.plot

# BIGRAMS ####
train.bigrams <- tokens_ngrams(train.tokens, n = 2)
train.bigrams.dfm <- dfm(train.bigrams)
train.bigrams.freq <- textstat_frequency(train.bigrams.dfm, n = 20)
train.bigrams.freq$feature <- factor(train.bigrams.freq$feature,
                                     levels = train.bigrams.freq$feature[order(train.bigrams.freq$frequency)])


bigrams.plot <- ggplot(train.bigrams.freq, 
                        aes(x = train.bigrams.freq$feature,
                            y = train.bigrams.freq$frequency)) +
        geom_col() + coord_flip() + labs(x = NULL, y = "Frequency") +
        ggtitle("Top 20 Bigrams Frequency")
bigrams.plot

# TRIGRAMS ####
train.trigrams <- tokens_ngrams(train.tokens, n = 3)
train.trigrams.dfm <- dfm(train.trigrams)
train.trigrams.freq <- textstat_frequency(train.trigrams.dfm, n = 20)
train.trigrams.freq$feature <- factor(train.trigrams.freq$feature,
                                     levels = train.trigrams.freq$feature[order(train.trigrams.freq$frequency)])


trigrams.plot <- ggplot(train.trigrams.freq, 
                       aes(x = train.trigrams.freq$feature,
                           y = train.trigrams.freq$frequency)) +
        geom_col() + coord_flip() + labs(x = NULL, y = "Frequency") +
        ggtitle("Top 20 Trigrams Frequency")
trigrams.plot


grid.arrange(bigrams.plot, trigrams.plot, nrow = 1)
