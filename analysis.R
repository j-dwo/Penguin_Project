# Data came from:
# https://github.com/allisonhorst/palmerpenguins/blob/master/README.md
install.packages("palmerpenguins")

# load required packages
library(here)
library(tidyverse)
library(ggplot2)
library(viridis)
library(palmerpenguins)

penguin_dat <- penguins

# get all the penguins from Biscoe island (n = 163)
gunters <- penguin_dat %>% 
  drop_na() %>% 
  filter(island == "Biscoe") %>% 
  select(-bill_length_mm, -bill_depth_mm, -flipper_length_mm,
         -year)

# drop first 13 rows (so that n = 150)
gunters <- gunters[-c(1,2,3,4,5,6,7,8,9,10,11,12,13),]

# get the chunkiness levels of the population
weights <- gunters$body_mass_g
pop_mean <- mean(weights)
pop_std <- sd(weights)

# create empty lists to store sample data
sample = c()
samples = list()
sample_means = list()
sample_stds = list()

# create 30 samples of 5 observations
index <- seq(from = 1, to = 150, by = 5)
j = 1
for (i in index) {
  sample <- c(weights[i], weights[i+1], weights[i+2], weights[i+3],
                 weights[i+4])
  samples[[j]] <- sample
  j = j + 1
}

# compute chunkiness levels of each sample of penguins
for (j in 1:30) {
  sample_means[j] <- lapply(samples[j], mean)
  sample_stds[j] <- lapply(samples[j], sd)
}

# histogram of the chunkiness of each penguin
gunters %>% 
ggplot(aes(x = body_mass_g, fill = sex, color = sex)) +
  geom_histogram(binwidth = 50, 
                 alpha = 0.5,
                 position = "identity") +
  xlab("weight (grams)") +
  ylab("count") +
  theme_bw() +
  theme(legend.position = "bottom") +
  labs(title = "Weight of Penguins on Biscoe Island")

# histogram of the mean chunkiness of each sample of penguins
sample_means_df <- as.data.frame(sample_means)
rownames(sample_means_df) <- "mean_weight"
colnames(sample_means_df) <- c(1:30)
sample_means_df <- as.data.frame(t(sample_means_df))

sample_means_df %>% 
  ggplot(aes(x = mean_weight, fill = ..count..)) +
  geom_histogram(binwidth = 50,
                 alpha = 1,
                 position = "identity") +
  xlab("mean weight (in grams)") +
  ylab("count") +
  labs(title = "Point Estimates of Sample Mean Weight 
       of Penguins on Biscou Island",
       legend = "") +
  theme_bw()
