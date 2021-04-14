
library(tidyverse) 
library(tidytext)
library(repr)
library(stringr)


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
  unnest_tokens(word, Content)
tidy_df <- tidy_df %>%
  anti_join(stop_words)
tidy_df$word<-gsub("[[:digit:]]", "", tidy_df$word)
tidy_df$word<-gsub("[^[:alnum:][,.]+]", "", tidy_df$word)
tidy_df <- na.omit(tidy_df)
#tidy_df<-filter(tidy_df,word!="##")
i<-which(tidy_df$word=="")
tidy_df<-tidy_df[-i,]
p<-which(tidy_df$word==",")
tidy_df<-tidy_df[-p,]
q<-which(tidy_df$word==".")
tidy_df<-tidy_df[-q,]
head(tidy_df)
tidy_df %>%
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

tidy_df %>%
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

tidy_df %>%
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
tidy_df %>%
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


library(wordcloud)



tidy_df %>%
  count(word,FactCheck, sort = TRUE) %>%
  acast(word ~ FactCheck, value.var = "n", fill = 0) %>%
  comparison.cloud(colors = Colorlist,
                   max.words = 200)

tidy_df %>%
  filter(FactCheck=="False")%>%
  count(word,sort = TRUE) %>%
  with(wordcloud(word, n, max.words = 200,colors ='#fa7f72' ))

tidy_df %>%
  filter(FactCheck=="True")%>%
  count(word,sort = TRUE) %>%
  with(wordcloud(word, n, max.words = 200,colors ='#389393'))

tidy_df %>%
  filter(FactCheck=="Half-true")%>%
  count(word,sort = TRUE) %>%
  with(wordcloud(word, n, max.words = 200,colors ='#ffe05d'))
