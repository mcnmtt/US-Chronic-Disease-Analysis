library(dplyr)

dataset <- "u_s_chronic_disease_indicators_cdi.csv"
df <- read.csv(dataset, stringsAsFactors = FALSE)

# Conta le occorrenze per ciascuna combinazione unica di stratificationcategory1 e stratification1
result <- df %>%
  group_by(questionid, stratificationcategory1, stratification1) %>%
  summarise(Num_Entry = n(), .groups = "drop")

colnames(result) <- c("QuestionID", "Stratification_Category", "Stratification", "Num_Entry")

write.csv(result, "stratification.csv", row.names = FALSE)