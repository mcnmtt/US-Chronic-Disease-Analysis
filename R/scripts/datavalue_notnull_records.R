library(dplyr)

df <- read.csv("alcohol_subdataset.csv", stringsAsFactors = FALSE)

# Conta i valori per ogni questionid
result <- df %>%
  group_by(questionid) %>%
  summarise(
    Total_Records_DataValue = n(),
    Total_Records_DataValueAlt = n(),
    Null_Records_DataValue = sum(is.na(datavalue) | datavalue == "NA"),
    Null_Records_DataValueAlt = sum(is.na(datavaluealt) | datavaluealt == "NA")
  )

write.csv(result, "alc_analysis.csv", row.names = FALSE)
