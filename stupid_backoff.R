setwd("~/Alán/CapstoneProject")

library(quanteda)
library(readr)
library(tm)
library(stringi)

# Tokenization and N-grams frequencies ####

train <- read_lines("./final/en_US/train_US.txt")
train <- removePunctuation(train)
train.tokens <- tokens(train, what = "word",
                       remove_numbers = TRUE, remove_punct = TRUE,
                       remove_symbols = TRUE, split_hyphens = TRUE)
train.tokens <- tokens_tolower(train.tokens)
train.tokens.dfm <- dfm(train.tokens, tolower = FALSE)


train.unigrams <- tokens_ngrams(train.tokens, n = 1)
train.unigrams.dfm <- dfm(train.unigrams)
unigrams <- textstat_frequency(train.unigrams.dfm)[,1:2]
rm(list=c("train.unigrams", "train.unigrams.dfm"))


train.bigrams <- tokens_ngrams(train.tokens, n = 2)
train.bigrams.dfm <- dfm(train.bigrams)
bigrams <- textstat_frequency(train.bigrams.dfm)[,1:2]
rm(list=c("train.bigrams","train.bigrams.dfm"))

train.trigrams <- tokens_ngrams(train.tokens, n = 3)
train.trigrams.dfm <- dfm(train.trigrams)
trigrams <- textstat_frequency(train.trigrams.dfm)
rm(list=c("train.trigrams", "train.trigrams.dfm"))

train.fourgrams <- tokens_ngrams(train.tokens, n = 4)
train.fourgrams.dfm <- dfm(train.fourgrams)
fourgrams <- textstat_frequency(train.fourgrams.dfm)
rm(list = c("train.fourgrams", "train.fourgrams.dfm"))

train.fivegrams <- tokens_ngrams(train.tokens, n = 5)
train.fivegrams.dfm <- dfm(train.fivegrams)
fivegrams <-  textstat_frequency(train.fivegrams.dfm)
rm(list = c("train.fivegrams", "train.fivegrams.dfm"))

# Stupid Backoff Model####

input <- "Hey sunshine, can you follow me and make me the"

# Data processing
# Get 4 to 1 grams

make.ngrams <- function(x){
        
        library(tm)
        
        x <- removePunctuation(x)
        x <- iconv(x)
        x <- tolower(x)
        x <- removeNumbers(x)
        x <- stripWhitespace(x)
        
        total.words <- min(4,sapply(strsplit(x, " "), length))
        total.ngrams <<- as.data.frame(NULL)
                
        while (total.words > 0){
                
                patt = sprintf("\\w+( \\w+){0,%d}$", total.words-1)
                ngram <- stri_extract(x, regex = patt)
                ngram <- gsub(" ","_", ngram)
                total.ngrams <<- rbind(total.ngrams,ngram)
                total.words <- total.words - 1
        }
        colnames(total.ngrams) <- "ngrams"
}
