library(dplyr)
library(ggplot2)

file_path <- "Chronic_Obstructive_Pulmonary_Disease_subdataset.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

# Conta le occorrenze di ogni questionid, escludendo datavalue NULL, 0 o stringa vuota
question_counts <- data %>%
  filter(!is.na(datavalue) & datavalue != 0 & datavalue != "") %>%
  group_by(questionid) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

ggplot(question_counts, aes(x = count, y = reorder(questionid, count))) +  # Usa questionid per ordinare
  geom_col(fill = "steelblue") + 
  labs(
    title = "Distribuzione delle question NON NULLE \n (Chronic Obstructive Pulmonary Disease)",
    x = "Quantità di record",
    y = "Question ID"
  ) +
  theme_minimal() + 
  theme(
    axis.text.y = element_text(size = 10), 
    plot.title = element_text(hjust = 0.5)
  )