library(dplyr)
library(ggplot2)

file_path <- "subdataset.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

sub_data <- data %>% filter(topic == "Arthritis")

# Conta le occorrenze di ogni question
question_counts <- sub_data %>%
  group_by(question) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# Plotta tutte le question
ggplot(question_counts, aes(x = count, y = reorder(question, count))) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    title = "Distribuzione delle Question per Arthritis",
    x = "num. di record",
    y = "question"
  ) +
  theme_minimal() +
  scale_y_discrete(drop = FALSE)
