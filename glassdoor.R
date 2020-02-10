library(lubridate)
library(dplyr)
library(ggplot2)
google = read.csv('google.csv')
fb = read.csv('fb.csv')
nflx = read.csv('nflx.csv')

glassdoor = rbind(fb, nflx, google)
glassdoor$interview = NULL
glassdoor$application = NULL

# Converting String to Date 
glassdoor$month = month(as.Date(glassdoor$date, "%b %d, %Y")) 
glassdoor$newdate = as.Date(glassdoor$date, "%b %d, %Y")

# Categorizing between yes and no offers
glassdoor$offerstatus = ifelse(glassdoor$offer == "No Offer", F, T)




# Total Offers by Month   
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

# Offers by Month - FB
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

# Offers by Month - NFLX
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

# Offers by Month - Google
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

# Data Science Recruitment 

# Data Science Barplot
glassdoor %>% 
  filter(title == "Data Scientist") %>% 
  group_by(company) %>%
  mutate(offers = n()) %>% 
  ggplot(aes(x = company)) +
  geom_bar(aes(fill = offerstatus),
           position = "fill", 
           width = 0.5) + 
  ggtitle("Breakout of Data Scientist Offers") +
  xlab("") +
  ylab("Offers vs No Offers") + 
  theme_classic() + 
  scale_fill_manual(values=c("darkred", "green4"), 
                    name = ('Offer Status'), 
                    labels = c('No Offer', 'Offer'))

# Data Science Job offer rate
glassdoor %>%  
  filter(title == "Data Scientist") %>%  
  group_by(company) %>% 
  arrange(company) %>% 
  summarise(total_offers = sum(offerstatus), 
            total_interviews = n(), 
            offer_rate = total_offers/total_interviews)


# Assigning Numeric to Difficulty 
unique(glassdoor$difficulty)
glassdoor$difficultyscore = ifelse(glassdoor$difficulty == "Difficult Interview", 5, 
                                   ifelse(glassdoor$difficulty == "Average Interview", 3, 1))

glassdoor %>%
  filter(title == "Data Scientist") %>% 
  group_by(company) %>% 
  summarise(mean(difficultyscore))

# Cleaning Experience Data & Average DS Experience Score
glassdoor$expscore = ifelse(glassdoor$experience == "Positive Experience", 5, 
                            ifelse(glassdoor$experience == "Neutral Experience", 3,
                                   ifelse(glassdoor$experience == "Negative Experience", 1, NA)))

glassdoor %>% 
  filter(title == "Data Scientist") %>% 
  group_by(company) %>% 
  summarise(mean(expscore, na.rm = T))

glassdoor



  
  
