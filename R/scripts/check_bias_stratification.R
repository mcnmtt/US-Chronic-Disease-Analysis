ggplot(df, aes(x = stratificationid1, fill = stratificationcategoryid1)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ topic, scales = "free_x") +
  theme_minimal() +
  labs(title = "Analisi della Rappresentatività dei Dati per Topic",
       x = "stratification",
       y = "count",
       fill = "stratification category") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))