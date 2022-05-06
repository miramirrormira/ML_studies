install.packages(c("twitteR", "RCurl","RJSONIO","stringr","tm","wordcloud","SnowballC", "ggplot2", "plyr","reshape2"))
library(twitteR)
library(RCurl)
library(RJSONIO)
library(stringr)
library(tm)
library(wordcloud)
library(SnowballC)


library(httr)
oauth_endpoints("twitter")
myapp <- oauth_app("MiraMirror",
                   key = "XQEWW1MRz0dkCGvSXlSR5p5zd",
                   secret = "WzA9Z3oIbx3pCmO5bxpnYnVbZqgtLXMUE4ME0mn0rXr5GihGuQ"
)

#Get OAuth credentials
twitter_token <- oauth1.0_token(oauth_endpoints("twitter"), myapp)

clean.text <- function(some_txt)
{
  some_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", some_txt)
  some_txt = gsub("@\\w+", "", some_txt)
  some_txt = gsub("[[:punct:]]", "", some_txt)
  some_txt = gsub("[[:digit:]]", "", some_txt)
  some_txt = gsub("http\\w+", "", some_txt)
  some_txt = gsub("[ \t]{2,}", "", some_txt)
  some_txt = gsub("^\\s+|\\s+$", "", some_txt)
  some_txt = gsub("amp", "", some_txt)
  # define "tolower error handling" function
  try.tolower = function(x)
  {
    y = NA
    try_error = tryCatch(tolower(x), error=function(e) e)
    if (!inherits(try_error, "error"))
      y = tolower(x)
    return(y)
  }
  
  some_txt = sapply(some_txt, try.tolower)
  some_txt = some_txt[some_txt != ""]
  names(some_txt) = NULL
  return(some_txt)
}

#Grab the tweets
rdmTweets <- searchTwitter("Donald Trump", 1000, lang="en")
#Use a handy helper function to put the tweets into a dataframe
tw.df=twListToDF(rdmTweets)
write.csv(tw.df,"Trump tweets.csv")

#Then for example, remove @'d names
tweets <- as.vector(sapply(tw.df$text, clean.text))

tweets <- iconv(tweets, to = "utf-8-mac")
tweets <- removeWords(tweets, c("and", "the", "Donald", "Trump", "donald", "trump"))

corpus <- Corpus(VectorSource(tweets))
tdm = TermDocumentMatrix(corpus,
              control = list(removePunctuation = TRUE,
                             stopwords = stopwords("english"),
                             removeNumbers = TRUE))
m = as.matrix(tdm)
word_freqs = sort(rowSums(m), decreasing=TRUE) 
dm = data.frame(word=names(word_freqs), freq=word_freqs)
wordcloud(words = dm$word, freq = dm$freq)

