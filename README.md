<p align="center">
  <img width="160" src="https://www.opisalerno.it/wp-content/uploads/2016/11/logo-unisa-png.png" alt="Logo UNISA">
</p>

<h1 align="center">U.S. Chronic Disease Data Analysis</h1>

<p align="center">
  Statistical study on U.S. chronic disease data, based on public health indicators from the CDC.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/language-R-276DC3?logo=r" alt="R">
  <img src="https://img.shields.io/badge/data-CDC%20CDI-blue" alt="CDC">
  <img src="https://img.shields.io/badge/course-Statistics%20%26%20Data%20Analysis%202024%2F2025-lightgrey" alt="Course">
  <img src="https://img.shields.io/badge/university-UNISA-darkred" alt="UNISA">
</p>

---

## Table of Contents

- [Project Description](#project-description)
- [Dataset](#dataset)
- [Repository Structure](#repository-structure)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Research Questions](#research-questions)
- [Key Results](#key-results)
- [Technologies](#technologies)
- [Authors](#authors)

---

## Project Description

This project was developed as part of the **Statistics and Data Analysis** course (A.Y. 2024/2025) at the University of Salerno, under the supervision of professors Stefano Cirillo and Luigi Di Biasi.

The main objective is to conduct an **in-depth statistical study** on U.S. chronic disease indicators, using the public dataset provided by the *Centers for Disease Control and Prevention* (CDC). The project combines exploratory analysis, statistical inference, and machine learning techniques to answer three original research questions.

The full project report is available in [`US-Chronic-Disease-Analysis.pdf`](./US-Chronic-Disease-Analysis.pdf).

---

## Dataset

**Source:** [U.S. Chronic Disease Indicators (CDI) — CDC](https://www.cdc.gov/cdi/)

The dataset collects **124 indicators** related to chronic diseases in the United States, developed through a consensus process to ensure uniformity in definition, collection, and reporting at the state, territorial, and metropolitan level.

| Property | Detail |
|---|---|
| Time coverage | 2001 – 2014 |
| Granularity | U.S. federal state + geospatial information |
| Stratifications | Overall, Gender (Male/Female), Race/Ethnicity |
| Number of topics | 17 |

**Topics in the dataset:**

| | |
|---|---|
| Alcohol | Arthritis |
| Asthma | Cancer |
| Cardiovascular Disease | Chronic Kidney Disease |
| COPD | Diabetes |
| Disability | Immunization |
| Mental Health | Nutrition, PA & Weight Status |
| Older Adults | Oral Health |
| Overarching Conditions | Reproductive Health |
| Tobacco | |

> **Note:** Raw dataset files are not included in the repository due to size constraints. The dataset can be downloaded directly from the CDC portal at the link above.

---

## Repository Structure

```
US-Chronic-Disease-Analysis/
│
├── R/scripts/                      # R scripts for the analysis
│   ├── create_subset.R             # Subset creation per topic
│   ├── datavalue_notnull_records.R # Null value analysis
│   ├── datavaluetypes_unit_explore.R
│   ├── distribution_datavalue_filtered_by_datavaluetype.R
│   ├── mode_qualitative_data.R
│   ├── question_record_distribution.R
│   ├── stratification_category_explore.R
│   ├── topic_record_distribution.R
│   └── check_bias_stratification.R
│
├── data/
│   ├── raw/                        # Original CDC datasets
│   ├── processed/
│   │   ├── subset/                 # Subset for each topic
│   │   ├── subset_definitivo/      # Final subset (Diabetes & CVD)
│   │   ├── datavaluetypes/         # Data types per topic
│   │   ├── null count/             # Missing value analysis per topic
│   │   └── stratification category/# Stratification analysis
│
├── results/figures/
│   ├── Subset/IMG_Mattia/          # Plots: Alcohol, Arthritis, Asthma,
│   │                               #   Cancer, CVD, Diabetes, Kidney, COPD
│   ├── Subset/IMG_Antonio/         # Plots: Disability, Immunization,
│   │                               #   Mental Health, Nutrition, Older Adults,
│   │                               #   Oral Health, Overarching, Repro., Tobacco
│   └── US states record count/     # Record distribution by state
│
├── US-Chronic-Disease-Analysis.pdf # Full project report
└── README.md
```

---

## Exploratory Data Analysis

Before addressing the research questions, a comprehensive exploratory analysis was conducted on the full dataset, structured in the following steps:

### 1. Dataset Structure and Partitioning
The dataset was split into **17 subsets** (one per topic). For each subset, the number of records and questions was counted, and null values were identified for every `questionID`.

### 2. Temporal Distribution
Analysis of record distribution by acquisition year (2001–2014), visualised via bar charts for each topic.

### 3. DataValueType and DataValueUnit
Extraction and cataloguing of all data types present (`Crude Prevalence`, `Age-Adjusted Prevalence`, `Crude Rate`, `Mean`, etc.) with their corresponding units of measure (%, cases per 100,000, Number, gallons, …).

### 4. Demographic Stratification
Analysis of record distribution by `StratificationCategory` (Overall, Gender, Race/Ethnicity) to verify representativeness and detect potential **bias**. Results show a balanced distribution for Gender and Overall, with some imbalances in the Race category for certain topics.

### 5. Frequency Distributions
For each question and `DataValueType`, frequency distributions were plotted with overlaid measures of central tendency and dispersion (mean, median, mode, variance, standard deviation). This step led to the selection of **Diabetes** and **Cardiovascular Disease** as the focus topics for subsequent analyses.

### 6. Distribution Verification (Chi-Square Test)
Formal verification of the fit between empirical distributions and known theoretical distributions (in particular the normal distribution), using the χ² test.

### 7. Hypothesis Testing
One-tailed hypothesis tests on specific indicators, comparing empirical estimates against official public health targets. The p-value is used to assess the statistical significance of the observed deviations.

### 8. Mode on Qualitative Data
Computation of the mode on qualitative `DataValueType` fields (e.g. alcohol outlet density regulation policies, tobacco excise taxes) to highlight the predominant categorical values.

---

## Research Questions

### RQ1 — Can LLM-generated data preserve the statistical properties of real data?

**Objective:** Impute missing values in the Diabetes dataset using LLM models, evaluating the statistical quality of the generated synthetic data.

**Approaches compared:**
- **GPT-4:** Imputation based on aggregate statistics (mean, median). Generated values preserve global distributions but lack semantic plausibility.
- **GPT-5:** *Group-conditioned hot-deck* technique with a *multi-level backoff* strategy (G0→G3). Imputed values are sampled with replacement from the empirical distribution conditioned on the context `(yearstart, locationabbr, datavaluetype, stratificationcategory1)`, yielding both statistically and semantically coherent results.

**Conclusion:** GPT-5 produces significantly better imputation, preserving within-group variability and respecting conditional distributions.

---

### RQ2 — Is the dataset adequate for developing predictive models?

**Objective:** Verify whether sufficient statistical correlations exist between **Cardiovascular Disease (CVD)** and **Diabetes (DIA)** indicators to support regression tasks.

**Method:** Pearson correlation matrices for each `DataValueType`, across all questions from both topics.

**Results:**
- High correlations emerge only between variables that describe the same phenomenon under different codes (semantic redundancy), not between distinct phenomena.
- No clear correlations even for intuitive associations (e.g. Tobacco → CVD, Alcohol → Diabetes).
- Main cause: high dataset heterogeneity with very few data points per feature combination.

**Conclusion:** The dataset, in its current configuration, is **not sufficient** to develop robust predictive models. Integration with external socio-economic, behavioural, and healthcare variables would be required.

---

### RQ3 — Do meaningful clustering patterns exist among ethnic groups?

**Objective:** Assess whether the phenomena observed in the dataset allow identifying clusters consistent with the 7 ethnic categories present.

**Methods:**

**K-Means (k=7, unsupervised):** Generated clusters show no clear separation among ethnicities — observations from different groups intermix. The analysis was run iteratively over all combinations of `topic`, `questionid`, `datavaluetype`, `datavalueunit`.

**Random Forest (300 trees, supervised):**
- OOB Error: **44.98%**
- Test set accuracy: **55.18%** (random baseline: ~14%)
- Strong per-group heterogeneity: error ~16% for *White, non-Hispanic*, but >90% for *Multiracial* and *Other*

**Cluster quality evaluation (Elbow Method + Calinski-Harabasz):** The optimal number of clusters is k=4, with a good balance between WCSS and BCSS.

**Conclusion:** Partial correlations between variables and ethnic group exist, but are not strong enough for reliable classification. Results are indicative and suggest that richer supplementary data would be needed for more robust analyses.

---

## Key Results

| Research Question | Outcome |
|---|---|
| RQ1 — LLMs and statistical properties | GPT-5 with hot-deck outperforms GPT-4; imputation quality is strongly dependent on model architecture |
| RQ2 — Adequacy for predictive models | Dataset insufficient in current configuration; external variables required |
| RQ3 — Ethnic group patterns | Partial correlations detected but not conclusive; representational bias present in the data |

---

## Technologies

- **Language:** R
- **Main libraries:** `ggplot2`, `dplyr`, `randomForest`, `stats`
- **LLM tools:** GPT-4, GPT-5 (OpenAI) — used for RQ1

---

## Authors

| Name | Role |
|---|---|
| **Mattia Maucioni** | Student — University of Salerno |
| **Antonio Landi** | Student — University of Salerno |

**Course:** Statistics and Data Analysis — A.Y. 2024/2025

**Professors:** Stefano Cirillo, Luigi Di Biasi

**University:** Università degli Studi di Salerno

---

<p align="center">
  <sub>Data provided by the <a href="https://www.cdc.gov/cdi/">CDC — Centers for Disease Control and Prevention</a></sub>
</p>
