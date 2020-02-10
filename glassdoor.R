library(lubridate)
library(dplyr)
library(ggplot2)
google = read.csv('google.csv')
fb = read.csv('fb.csv')
nflx = read.csv('nflx.csv')

?rbind()

class(nflx)
glassdoor = rbind(google, fb, nflx)
head(glassdoor)
tail(glassdoor)
colnames(glassdoor)
glassdoor$interview = NULL
glassdoor$application = NULL
head(glassdoor)

head(glassdoor$date)
head(as.Date(glassdoor$date, "%b %d, %Y"))
month(as.Date(glassdoor$date, "%b %d, %Y"))

colnames(glassdoor)
glassdoor$month = month(as.Date(glassdoor$date, "%b %d, %Y")) 
glassdoor$newdate = as.Date(glassdoor$date, "%b %d, %Y")

head(glassdoor)
unique(glassdoor$offer)
glassdoor$offerstatus = ifelse(glassdoor$offer == "No Offer", F, T)
mean(glassdoor$offerstatus)
length((glassdoor$offerstatus))


glassdoor %>% 
  group_by(month) %>% 
  mutate(offers = n()) %>%
  ggplot(aes(x = month)) + 
  geom_bar(aes(fill = offerstatus), position = "fill", width = 0.8) + 
  scale_x_continuous(breaks=c(1:12)) +
  ggtitle("Offers by Month") +
  xlab("Month") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), name = ('Offer Status'), labels = c('No Offer', 'Offer'))
  
glassdoor %>% 
  group_by(month) %>% 
  filter(company == 'Facebook') %>% 
  mutate(offers = n()) %>%
  ggplot(aes(x = month)) + 
  geom_bar(aes(fill = offerstatus), position = "fill", width = 0.8) + 
  scale_x_continuous(breaks=c(1:12)) +
  ggtitle("Offers by Month") +
  xlab("Month") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), name = ('Offer Status'), labels = c('No Offer', 'Offer'))

glassdoor %>% 
  group_by(month) %>% 
  filter(company == 'Facebook') %>% 
  mutate(offers = n()) %>%
  ggplot(aes(x = month)) + 
  geom_bar(aes(fill = offerstatus), position = "fill", width = 0.8) + 
  scale_x_continuous(breaks=c(1:12)) +
  ggtitle("Offers by Month") +
  xlab("Month") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), name = ('Offer Status'), labels = c('No Offer', 'Offer'))

glassdoor %>% 
  group_by(month) %>% 
  filter(company == 'Netflix') %>% 
  mutate(offers = n()) %>%
  ggplot(aes(x = month)) + 
  geom_bar(aes(fill = offerstatus), position = "fill", width = 0.8) + 
  scale_x_continuous(breaks=c(1:12)) +
  ggtitle("Offers by Month") +
  xlab("Month") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), name = ('Offer Status'), labels = c('No Offer', 'Offer'))


glassdoor %>% 
  group_by(month) %>% 
  filter(company == 'Google') %>% 
  mutate(offers = n()) %>%
  ggplot(aes(x = month)) + 
  geom_bar(aes(fill = offerstatus), position = "fill", width = 0.8) + 
  scale_x_continuous(breaks=c(1:12)) +
  ggtitle("Offers by Month") +
  xlab("Month") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), name = ('Offer Status'), labels = c('No Offer', 'Offer'))
