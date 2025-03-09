file_path <- "alcohol_subdataset.csv"
dataset <- read.csv(file_path, stringsAsFactors = FALSE)

dataset$yearstart <- as.numeric(dataset$yearstart)

# Conta numero record
record_counts <- table(dataset$yearstart)

# Plotta l'istogramma
barplot(
  record_counts,
  main = "Distribuzione dei record per anno (topic: 'Alcohol')",
  xlab = "Anno di acquisizione",
  ylab = "Numero di record",
  col = "blue",
  border = "black"
)