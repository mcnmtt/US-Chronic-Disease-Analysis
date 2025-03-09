library(dplyr)

dataset_path <- "u_s_chronic_disease_indicators_cdi.csv"

df <- read.csv(dataset_path, na.strings = c("", "NA", "NULL", "null"))

# Filtra per i datavaluetypeid di interesse
df_filtered <- df %>%
  filter(datavaluetypeid %in% c("LclCntrlAlc", "CommHstLiab", "YesNo"))

# Funzione per calcolare la moda
calculate_mode <- function(x) {
  uniq_x <- unique(x)
  uniq_x[which.max(tabulate(match(x, uniq_x)))]
}

# Calcola la moda per ogni combinazione di topic, questionid e datavaluetypeid
modes_df <- df_filtered %>%
  group_by(topic, questionid, datavaluetypeid) %>%
  summarise(mode_value = calculate_mode(datavalue), .groups = "drop")

write.csv(modes_df, "moda_per_topic_questionid_datavaluetypeid.csv", row.names = FALSE)