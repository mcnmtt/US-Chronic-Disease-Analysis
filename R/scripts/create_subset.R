file_path <- "u_s_chronic_disease_indicators_cdi.csv"
data <- read.csv(file_path, stringsAsFactors = FALSE)

subdataset <- subset(data, topic == "Alcohol")

output_path <- "Progetto/data/processed/alcohol_subdataset.csv"

write.csv(subdataset, file = output_path, row.names = FALSE)