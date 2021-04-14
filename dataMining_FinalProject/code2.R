

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
df%>%count(FactLevel)
head(df)
###3level
df$FactLevel<-as.factor(df$FactLevel)
df$Content <- str_replace_all(df$Content, "Trump", "DJT") 
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


tidy_df1 <- inner_join(tidy_df, get_sentiments("bing")) 
tidy_df2 <- count(tidy_df1, FactLevel, index = index, sentiment) 
tidy_df3 <- spread(tidy_df2, sentiment, n, fill = 0)
tidy_df4 <- mutate(tidy_df3, sentiment = positive - negative)

head(tidy_df4)
tidy_df4%>%count(FactLevel)
colorlist <- c('#721121', '#a5402d', '#F1A66A', '#BBDEF0', '#658da4', '#0d324d') 
              # pantsfire, false, mostlyfalse, halftrue, mostlytrue, true
colorlist2<-c("#a5402d","#BBDEF0","#F1A66A","#658da4","#721121","#0d324d")
ggplot(tidy_df4, aes(sentiment, fill = FactLevel)) +
  geom_density(alpha=1) +
  scale_fill_manual(values = colorlist2)+
  facet_wrap(~FactLevel, nrow = 3)+
  ggtitle("Density Plot of Sentiment Distribution")+
  xlab("Sentiment") +
  ylab("Density")+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))
  


tidy_df1 %>%
  filter(FactCheck=="False")%>%
  count(sentiment, word) %>%
  ungroup() %>%
  filter(n>=5)%>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(word, n)) %>%
  ggplot(aes(n,term, fill = sentiment)) +
  geom_bar(stat = "identity") +
  xlab("Contribution to sentimentword") +
  ylab("word")+
  ggtitle("Top Hot Words in False Information-Sentiment Analysis")+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

tidy_df1 %>%
  filter(FactCheck=="True")%>%
  count(sentiment, word) %>%
  ungroup() %>%
  filter(n>=3)%>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(word, n)) %>%
  ggplot(aes(n,term, fill = sentiment)) +
  geom_bar(stat = "identity") +
  xlab("Contribution to sentimentword") +
  ylab("word")+
  ggtitle("Top Hot Words in True Information-Sentiment Analysis")+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))

tidy_df1 %>%
  filter(FactCheck=="Half-true")%>%
  count(sentiment, word) %>%
  ungroup() %>%
  filter(n>=3)%>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(term = reorder(word, n)) %>%
  ggplot(aes(n,term, fill = sentiment)) +
  geom_bar(stat = "identity") +
  xlab("Contribution to sentimentword") +
  ylab("word")+
  ggtitle("Top Hot Words in Half-true Information-Sentiment Analysis")+
  theme(axis.text=element_text(size=16),
        legend.title = element_text(color = "black", size = 16),
        axis.title.x =element_text(size=16), 
        axis.title.y=element_text(size=16),
        legend.text = element_text(color = "black", size = 16),
        plot.title = element_text(hjust = 0.5,size = 24))




