library(ggplot2)
library(dplyr)

output_folder <- "F_Distribution"

# Crea la cartella se non esiste
if (!dir.exists(output_folder)) {
  dir.create(output_folder, recursive = TRUE)
}

df <- read.csv("u_s_chronic_disease_indicators_cdi.csv", na.strings = c("", "NA", "NULL", "null"))

# Rendi tutti i nomi delle colonne in minuscolo per uniformità
colnames(df) <- tolower(colnames(df))

# Controlla i nomi delle colonne
print(colnames(df))

# Controlla se 'datavalue' esiste e convertila in numerico
if ("datavalue" %in% colnames(df)) {
  df$datavalue <- as.numeric(df$datavalue)
} else {
  stop("La colonna 'datavalue' non esiste nel dataset.")
}

# Rimuove eventuali valori nulli
df <- df %>% filter(!is.na(datavalue))

# Controlla se 'questionid' e 'datavaluetype' esistono
if (!("questionid" %in% colnames(df)) || !("datavaluetype" %in% colnames(df))) {
  stop("Le colonne 'questionid' o 'datavaluetype' non esistono nel dataset.")
}

# Ottiene tutte le combinazioni uniche di questionid e datavaluetype
combinations <- df %>% select(questionid, datavaluetype) %>% distinct()

# Loop attraverso ogni combinazione per creare e salvare i plot
for (i in 1:nrow(combinations)) {
  question_id <- as.character(combinations$questionid[i])  
  data_value_type <- as.character(combinations$datavaluetype[i])
  
  # Salta se ci sono NA
  if (is.na(question_id) || is.na(data_value_type)) next
  
  # Filtra i dati per la combinazione corrente
  subset_df <- df %>% filter(questionid == question_id, datavaluetype == data_value_type)
  
  if (nrow(subset_df) == 0) next
  
  # Calcola la distribuzione di frequenza
  freq_table <- as.data.frame(table(subset_df$datavalue))
  colnames(freq_table) <- c("datavalue", "frequency")
  
  # Converte datavalue in numerico per l'ordinamento
  freq_table$datavalue <- as.numeric(as.character(freq_table$datavalue))
  
  # Ordina per datavalue
  freq_table <- freq_table[order(freq_table$datavalue), ]
  
  # Crea il plot
  plot <- ggplot(freq_table, aes(x = datavalue, y = frequency)) +
    geom_bar(stat = "identity", fill = "blue", alpha = 0.7) +
    labs(title = paste("Distribuzione di Frequenza per", question_id, "-", data_value_type),
         x = "Valore di datavalue",
         y = "Frequenza") +
    theme_minimal()
  
  # Genera un nome file sicuro
  filename <- paste0("Plot_", gsub("[^A-Za-z0-9]", "_", question_id), "_", 
                     gsub("[^A-Za-z0-9]", "_", data_value_type), ".jpg")
  
  filepath <- file.path(output_folder, filename)
  
  # Salva il plot
  ggsave(filepath, plot, width = 8, height = 6, dpi = 300)
}

print(paste("Tutti i grafici sono stati salvati nella cartella:", output_folder))
