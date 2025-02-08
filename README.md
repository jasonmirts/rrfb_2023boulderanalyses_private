**This repository is a modified version of the original, which is protected under Reef Renewal Foundation Bonaire's intellectual property. It has been adapted for public use 
and does not include all proprietary documents. Please contact jason@reefrenewalbonaire.org for inquiries.**

## Reef Renewal Foundation Bonaire 2023 Boulder Coral Analyses README
-------------
The main purpose of this document is to report on the 2023 bleaching period and how it influenced boulder coral fragment health within RRFB nurseries around Bonaire. 
The following report analyzes coral fragment survivorship and coral fragment bleaching, in addition to some other coral health-related metrics. 

### Table of Contents
-----------------
1. Contents
2. Installation Instructions
3. Usage
4. License
5. Contact Information
6. Acknowledgements


### 1. Contents
------------
main:
  
- **RRFB_2023_Boulder_Coral_Report.qmd** - the entire Quarto report file, including all pertinent background information, scripts, pictures, and other information.

- **RRFB_2023_Boulder_Coral_Report.html** - the final export of the RRFB report.
  
assets:
  
- all plots (.png for ggplot, .html for gt)
  
- featured image files
  
docs:
  
- **Tray Nursery Monitoring Database IN PROG..xlsx** - raw Excel data (cleaned + organized)

R:
  
- **SurvivorshipSourceCode2023.R** - script for Survivorship data and analyses
  
- **BleachingSourceCode2023.R** - script for Bleaching data and analyses
  
- **ResilienceSourceCode2023.R** - script for Resilience data and analyses

### 2. Installation Instructions
----------------------------
- Download latest version of [R](https://www.r-project.org/) and [R Studio](https://posit.co/download/rstudio-desktop/)
- Download [Quarto](https://quarto.org/)
- Download the project files by cloning the [rrfb_2023boulderanalyses_public repository](https://github.com/jasonmirts/rrfb_2023boulderanalyses_public.git)

### 3. Usage
---------
- Open R Studio
- Set the directory to the Excel workbook "Tray Nursery Monitoring Database IN PROG..xlsx"
- After installing the necessary packages, run each of the following R scripts to load and analyze each metric:
  
    source("BleachingSourceCode2023.R")
  
    source("ResilienceSourceCode2023.R")
  
    source("SurvivorshipSourceCode2023.R")

- View results in R/Quarto as necessary.

### 4. License
----------
*Copyright © 2025 Jason Mirtspoulos and Reef Renewal Foundation Bonaire (RRFB). All Rights Reserved.
This script and its contents are the intellectual property of the author.
Unauthorized distribution, reproduction, or use of this material without prior written permission from the author is strictly prohibited.*

### 5. Contact Information
----------------------
For inquiries, please contact jason@reefrenewalbonaire.org

### 6. Acknowledgements
-------------------
Credit to Jason Mirtsopoulos and Reef Renewal Foundation Bonaire.

Thanks to Sanne Tuijiten and the Reef Renewal Foundation Bonaire team for their dedication to making the planet a better place.
