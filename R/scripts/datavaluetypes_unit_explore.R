library(dplyr)

df <- read.csv("diabetes_subdataset.csv", stringsAsFactors = FALSE)

# Estrai valori univoci di datavaluetype e il rispettivo datavalueunit per ogni questionid
unique_values <- df %>%
  select(questionid, datavaluetype, datavalueunit) %>%
  distinct() %>%
  arrange(questionid)

write.csv(unique_values, "dia_datavaluetypes.csv", row.names = FALSE)