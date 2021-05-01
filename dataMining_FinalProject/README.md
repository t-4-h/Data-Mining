# Disinformation/ Fake News detection: During The Year of COVID-19 and Election (2020 Fall DM)

* Team members:   
Shangbin Tang  
Chengchen Wang <br>
Taylor Herb


## Description  

Over the past few years, people’s access to information has gradually shifted from traditional paper-based media, radio, and television to digital media and social media applications. At the same time, the information explosion also makes the information itself more and more fragmented. It’s become more and more critical for people to distinguish and filter out those false ones, or they can easily plant wrong views in the public’s mind.

Hence, in this project, we aim to figure out a method to detect and classify false and true information—especially those on social media.

### Files:  
* scrapping.ipynb  

this is the program we wrote to scrape the data.    
  
* Scraped data pre-processing1.ipynb  
this file performs some merging and preprocessing work of the just-scrapped half-raw data.  

* code2.r  

this file is the program we wrote about sentiment analysis.  

* code3.r  

this file is the program we wrote about high frequency word(unigram) in information.  

* code4.r  

this file is the program we wrote about high frequency word(bigram) in information.  

* code5.rmd

this file is the program we wrote to merge dataset, and calculate the sentiment score, content length in information.

* data1.rmd/data1.html
this file includes the classification models, predictions and confusion matrices for dataset 1.

* data2.rmd/data2.html
this file includes the classification models, predictions and confusion matrices for dataset 2.

* data3.rmd/data3.html
this file includes the classification models, predictions and confusion matrices for dataset 3.

* data4.rmd/data4.html
this file includes the classification models, predictions and confusion matrices for dataset 4.

* data1_3.csv
this file includes the final dataset 1 included for analysis (3-levels, historical score included, term frequency > 3)

* data2_3.csv
this file includes the final dataset 1 included for analysis (6-levels, historical score included, term frequency > 3)

* data3_3.csv
this file includes the final dataset 1 included for analysis (3-levels, historical score not included, term frequency > 3)

* data4_3.csv
this file includes the final dataset 1 included for analysis (6-levels, historical score not included, term frequency > 3)

* Final Paper_Team11_Disinformation and Fake News detection_During the Year of Covid-19 and Election.pdf  
this is the final paper  


## Prerequisites
### r packages：  
library(tidyverse)   
library(tidytext)  
library(dplyr)  
library(repr)  
library(stringr)  
library(wordcloud)  
library(reshape2)  
library(tm)   
library(ggplot2)<br>
library(caret)<br>
library(tidymodels)

### python packages:
pandas  
numpy  
os  
requests  
BeautifulSoup  

## Authors
Shangbin Tang (sht105@pitt.edu)  
Chengchen Wang (chw183@pitt.edu)  
Taylor Herb (tah77@pitt.edu)

## Acknowledgments

### Inspiration
SBP-BRiMS 2020 Challenge 2 - Disinformation (http://sbp-brims.org/2020/challenge/challenge2_Disinformation.html)  

## License
NA

## Data Sources  
https://www.politifact.com/  
