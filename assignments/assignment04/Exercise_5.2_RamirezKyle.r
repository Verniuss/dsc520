# Assignment: ASSIGNMENT 5.2 Exercise
# Name: Ramirez, Kyle
# Date: 2022-1-2

#downloading data from a article called "Effects of Vegetation Structure on the location of lion kill sites in african thicket"
download.file("https://doi.org/10.1371/journal.pone.0149098.s002","df.csv")

#setting data frame
df <- read.csv("df.csv", stringsAsFactors = FALSE)

#Looking for variabilities in the data set.
unique(df$Prey.species)

#loading dplyr
library(dplyr)

#Removing the unknowns and blanks from the data set
df1 <- filter(df, Prey.species != "Unknown" & nchar(Prey.species) > 0) %>%
  
  #changing the prey species to lower case
  mutate(prey.species = tolower(prey.species)) %>%
  
  #Finding out the number of species that each lion killed
  group_by(Lion.ID, Prey.species) %>%
  summarise(nb_killed = sum(State..kill..1..or.non.kill..0..)) %>%
  
  #Sorting results by the highest number to lowest number of kills
  arrange(desc(nb_killed)) %>%
  
  #renaming the categories
  select(Lion = Lion.ID,
         Prey = prey.species,
         nb_killed)

