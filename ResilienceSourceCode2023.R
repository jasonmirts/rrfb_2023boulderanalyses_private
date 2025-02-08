####2023 Boulder Bleaching Stress Data

## ---- Setup ----
install.packages("dplyr")
install.packages("ggplot2")
install.packages("knitr")
install.packages("pals")
install.packages("plotly")
install.packages("quarto")
install.packages("RColorBrewer")
install.packages("readxl")
install.packages("rstatix")
install.packages("tidyverse")
install.packages("tidyr")

library("readxl")
library("tidyverse")
library("dplyr")
library("tidyr")
library("ggplot2")
library("RColorBrewer")
library("knitr")
library("quarto")
library("rstatix")
library("plotly")

# Set working directory
setwd("C:/0_data")

# Call the Excel workbook and sheet
bleach_sheet = read_excel("C:/0_data/Tray Nursery Monitoring Database IN PROG..xlsx",
                          sheet = 5)

## ---- Reformat columns ----
colnames(bleach_sheet)[5] = "Tree_ID"
colnames(bleach_sheet)[12] = "Temperature_Bleaching"
colnames(bleach_sheet)[14] = "Running_Total"
colnames(bleach_sheet)[18] = "Bleaching_Stress"

bleach_sheet = bleach_sheet %>%
  mutate(Date = as.Date(Date, format = "%Y-%m-%d"))

bleach_sheet = bleach_sheet %>%
  group_by(Geno, Nursery, Date, Tree_ID)

# Create necessary variables
first_bleaching_date = as.Date("2023-08-31")
start_date = as.Date("2023-08-31")
end_date = as.Date("2024-01-24")

## ---- OL-specific code ----

# Define and join Oil Slick and Something Special data sets
OL = subset(bleach_sheet, grepl("OL|SS", bleach_sheet$Nursery))

# Create column for running fragment total
OL_on = OL %>%
  group_by(Geno) %>%
  mutate(
    start_stock = first(Running_Total),
    fragments_remaining = start_stock + cumsum(if_else(row_number() == 1, 0, Running_Total)),
    percentage_remaining = ((fragments_remaining / start_stock) * 100)
  )

# Group columns by species
OL_on_fw = OL_on %>%
  mutate(
    GenoGroup = case_when(
      grepl("Dcyl", Geno) ~ "Dcyl",
      grepl("Dsto", Geno) ~ "Dsto",
      grepl("Mcav", Geno) ~ "Mcav",
      grepl("Mmea", Geno) ~ "Mmea",
      grepl("Oann", Geno) ~ "Oann",
      grepl("Ofav", Geno) ~ "Ofav",
      grepl("Pstr", Geno) ~ "Pstr",
      TRUE ~ "Other"
    )
  )

# Filter out any genotypes that don't meet criteria
OL_on_fw = OL_on_fw %>%
  filter(Date >= start_date & Date <= end_date) %>%
  group_by(Geno) %>%
  filter(n() > 1) %>%
  ungroup()

# Double check all genotypes present meet criteria (obs > 1) with view()
OL_on_fw %>%
  group_by(Geno) %>%
  summarise(count = n(), .groups = "drop")

# Check to see how well genotypes survived in OL
OL_on_rw = OL_on_fw

OL_check = OL_on_rw %>%
  group_by(Geno) %>%
  summarise(
    start_stock = first(start_stock),
    frags_remaining = fragments_remaining[Date == max(Date, na.rm = TRUE)],
    bleach_inc = sum(if_else(Bleaching_Stress > 0, 1, 0), na.rm = TRUE),
    min_percentage = min(percentage_remaining, na.rm = TRUE),
    max_percentage = max(percentage_remaining, na.rm = TRUE),
    diff_percentage = max_percentage - min_percentage
  )

colnames(OL_check)[1] = "Genotype"
colnames(OL_check)[2] = "Starting Fragment Count"
colnames(OL_check)[3] = "Fragments Remaining"
colnames(OL_check)[4] = "Bleaching Incidences"
colnames(OL_check)[5] = "Final Survival %"
colnames(OL_check)[6] = "Initial Survival %"
colnames(OL_check)[7] = "Survival Difference"

OL_check = OL_check %>%
  arrange(`Survival Difference`) %>%
  ungroup()

## ---- BD-specific code ----

# Define BD data set
BD = subset(bleach_sheet, grepl("BD", bleach_sheet$Nursery))

# Create column for running fragment total
BD_on = BD %>%
  group_by(Geno) %>%
  mutate(
    start_stock = first(Running_Total),
    fragments_remaining = start_stock + cumsum(if_else(row_number() == 1, 0, Running_Total)),
    percentage_remaining = ((fragments_remaining / start_stock) * 100)
  )

# Group columns by species
BD_on_fw = BD_on %>%
  mutate(
    GenoGroup = case_when(
      grepl("Dcyl", Geno) ~ "Dcyl",
      grepl("Dsto", Geno) ~ "Dsto",
      grepl("Mcav", Geno) ~ "Mcav",
      grepl("Mmea", Geno) ~ "Mmea",
      grepl("Oann", Geno) ~ "Oann",
      grepl("Ofav", Geno) ~ "Ofav",
      grepl("Pstr", Geno) ~ "Pstr",
      TRUE ~ "Other"
    )
  )

# Filter out any genotypes that don't meet criteria
BD_on_fw = BD_on_fw %>%
  filter(Date >= start_date & Date <= end_date) %>%
  group_by(Geno) %>%
  filter(n() > 1) %>%
  ungroup()

# Double check all genotypes present meet criteria (obs > 1) with view()
BD_on_fw %>%
  group_by(Geno) %>%
  summarise(count = n(), .groups = "drop")

# Check to see how well genotypes survived in BD
BD_on_rw = BD_on_fw

BD_check = BD_on_rw %>%
  group_by(Geno) %>%
  summarise(
    start_stock = first(start_stock),
    frags_remaining = fragments_remaining[Date == max(Date, na.rm = TRUE)],
    bleach_inc = sum(if_else(Bleaching_Stress > 0, 1, 0), na.rm = TRUE),
    min_percentage = min(percentage_remaining, na.rm = TRUE),
    max_percentage = max(percentage_remaining, na.rm = TRUE),
    diff_percentage = max_percentage - min_percentage
  )

colnames(BD_check)[1] = "Genotype"
colnames(BD_check)[2] = "Starting Fragment Count"
colnames(BD_check)[3] = "Fragments Remaining"
colnames(BD_check)[4] = "Bleaching Incidences"
colnames(BD_check)[5] = "Final Survival %"
colnames(BD_check)[6] = "Initial Survival %"
colnames(BD_check)[7] = "Survival Difference"

BD_check = BD_check %>%
  arrange(`Survival Difference`) %>%
  ungroup()

## ---- gt Tables ----

## Individual Data Sets

# Create OL plot
OL_check %>%
  gt() %>%
  tab_header(title = "Genotype Survivorship Distribution", subtitle = "Oil Slick, 2023") %>%
  tab_style(style = list(cell_text(weight = "bold")), locations = cells_column_labels()) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(rows = `Bleaching Incidences` < 2)
  ) %>%
  tab_footnote(footnote = "Corals that bleached fewer than two times during the bleaching period are bolded to indicate potential resilience.", locations = cells_column_labels(columns = vars(Genotype))) %>%
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_title(groups = "title"))

# Create BD plot
BD_check %>%
  gt() %>%
  tab_header(title = "Genotype Survivorship Distribution", subtitle = "Buddy Dive, 2023") %>%
  tab_style(style = list(cell_text(weight = "bold")), locations = cells_column_labels()) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(rows = `Bleaching Incidences` < 5)
  ) %>%
  tab_footnote(footnote = "Corals that bleached fewer than five times during the bleaching period are bolded to indicate potential resilience.", locations = cells_column_labels(columns = vars(Genotype))) %>%
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_title(groups = "title"))

## Combined Data Sets

# Merge data frames using strings
merged_data = OL_check %>%
  inner_join(BD_check, by = "Genotype", suffix = c(" OL", " BD"))

# Calculate average survival of genotypes per survey and the weighted average of survivorship for both data sets
weigh = merged_data %>%
  mutate(
    avg_sur_freq = (`Fragments Remaining OL` + `Fragments Remaining BD`) / 2,
    weighted_diff = ((`Final Survival % OL` - `Initial Survival % OL`) * `Fragments Remaining OL` +
                       (`Final Survival % BD` - `Initial Survival % BD`) * `Fragments Remaining BD`
    ) /
      (`Fragments Remaining OL` + `Fragments Remaining BD`)
  )

# Order columns in final gt table
weigh = weigh %>%
  arrange(desc(weighted_diff)) %>%
  select(
    Genotype,
    'avg_sur_freq',
    'weighted_diff',
    'Starting Fragment Count OL',
    'Starting Fragment Count BD',
    'Fragments Remaining OL',
    'Fragments Remaining BD',
    'Bleaching Incidences OL',
    'Bleaching Incidences BD',
    'Final Survival % OL',
    'Final Survival % BD',
    'Initial Survival % OL',
    'Initial Survival % BD',
    'Survival Difference OL',
    'Survival Difference BD'
  )

# Create combined data plot
weigh %>%
  gt() %>%
  tab_header(title = "Genotype Survival Difference") %>%
  tab_style(style = list(cell_text(weight = "bold")), locations = cells_column_labels()) %>%
  tab_spanner(
    label = "Oil Slick",
    columns = c(
      'Starting Fragment Count OL',
      'Fragments Remaining OL',
      'Initial Survival % OL',
      'Final Survival % OL',
      'Survival Difference OL',
      'Bleaching Incidences OL'
    )
  ) %>%
  tab_spanner(
    label = "Buddy Dive",
    columns = c(
      'Starting Fragment Count BD',
      'Fragments Remaining BD',
      'Initial Survival % BD',
      'Final Survival % BD',
      'Survival Difference BD',
      'Bleaching Incidences BD'
    )
  ) %>%
  cols_label(
    `avg_sur_freq` = "Average Survey Frequency",
    `weighted_diff` = "Weighted Average of Survivorship Change",
    `Fragments Remaining OL` = "Fragments Remaining",
    `Fragments Remaining BD` = "Fragments Remaining",
    `Initial Survival % OL` = "Initial Survival %",
    `Initial Survival % BD` = "Initial Survival %",
    `Final Survival % OL` = "Final Survival %",
    `Final Survival % BD` = "Final Survival %",
    `Survival Difference OL` = "Survival Difference",
    `Survival Difference BD` = "Survival Difference",
    `Bleaching Incidences OL` = "Bleaching Incidences",
    `Bleaching Incidences BD` = "Bleaching Incidences"
  ) %>%
  tab_style(style = cell_text(weight = "bold"), locations = cells_column_spanners()) %>%
  tab_style(
    style = cell_text(weight = "bold"),
    locations = cells_body(rows = `Bleaching Incidences OL` < 4 |
                             `Bleaching Incidences BD` < 4)
  ) %>%
  tab_footnote(footnote = "Corals that bleached fewer than four times during the bleaching period are bolded to indicate potential resilience.", locations = cells_column_labels(columns = vars(Genotype))) %>%
  tab_style(style = cell_text(weight = "bold"),
            locations = cells_title(groups = "title"))

# Copyright © 2025 Jason Mirtspoulos and Reef Renewal Foundation Bonaire (RRFB). All Rights Reserved.
# This script and its contents are the intellectual property of the author.
# Unauthorized distribution, reproduction, or use of this material without prior written permission
# from the author is strictly prohibited.

# For inquiries, please contact jason@reefrenewalbonaire.org