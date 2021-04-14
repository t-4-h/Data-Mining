
library(tidyverse) 
library(tidytext)
library(repr)
library(stringr)
options(repr.plot.width=20, repr.plot.height=20)

setwd("~/Desktop/Data Mining Project")
df<-read_csv("Data.csv")
df <- na.omit(df)
index<-seq.int(nrow(df))
df<-cbind(index=index,df)
df$X1=NULL
summary(df)
df%>%count(FactCheck)
head(df)
###3level
df$FactCheck<-as.factor(df$FactCheck)
df$FactLevel<-as.factor(df$FactLevel)
tidy_df <- df %>%
  unnest_tokens(word, Content, token = "ngrams", n = 2)
word_separated <- tidy_df %>%
  separate(word, c("word1", "word2"), sep = " ")

word_filtered <- word_separated %>%
  filter(!word1 %in% stop_words$word) %>%
  filter(!word2 %in% stop_words$word)
  
word_united <- word_filtered %>%
  count(word1, word2, sort = TRUE)
word_united

tidy_2word<-tidyr::unite(word_filtered, "word", word1, word2)


tidy_2word %>%
  filter(FactCheck=="False")%>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n,word,fill='#fa7f72')) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  ylab("High Frequency Word")+
  ggtitle("High Frequency Word in False Information")+
  theme(legend.position = "none")+
  scale_fill_manual(values = '#fa7f72')+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

tidy_2word %>%
  filter(FactCheck=="True")%>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n,word,fill='#389393')) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  ylab("High Frequency Word")+
  ggtitle("High Frequency Word in True Information")+
  theme(legend.position = "none") +
  scale_fill_manual(values = '#389393')+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

tidy_2word %>%
  filter(FactCheck=="Half-true")%>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(n,word,fill='#ffe05d')) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  ylab("High Frequency Word")+
  ggtitle("High Frequency Word in Half-true Information")+
  theme(legend.position = "none") +
  scale_fill_manual(values = '#ffe05d')+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

Colorlist<-c('#fa7f72','#ffe05d','#389393')
tidy_2word %>%
  group_by(FactCheck)%>%
  count(word, sort = TRUE) %>%
  top_n(15) %>%
  mutate(word = reorder(word, n)) %>%
  ungroup()%>%
  ggplot(aes(n,word,fill=FactCheck)) +
  geom_bar(stat = "identity") +
  xlab(NULL) +
  ylab("High Frequency Word")+
  ggtitle("High Frequency Word in Information")+
  theme(axis.text=element_text(size=18),
        legend.title = element_text(color = "black", size = 26),
        axis.title.x =element_text(size=18), 
        axis.title.y=element_text(size=18),
        legend.text = element_text(color = "black", size = 26))+
  scale_fill_manual(values = Colorlist)+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

