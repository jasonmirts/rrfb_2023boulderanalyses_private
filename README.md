**This repository is a modified version of the original, which is protected under Reef Renewal Foundation Bonaire's intellectual property. It has been adapted for public use 
and does not include all proprietary documents. Please contact jason@reefrenewalbonaire.org for inquiries.**

Reef Renewal Foundation Bonaire 2023 Boulder Coral Analyses README
-------------
The main purpose of this document is to report on the 2023 bleaching period and how it influenced boulder coral fragment health within RRFB nurseries around Bonaire. 
The following report analyzes coral fragment survivorship and coral fragment bleaching, in addition to some other coral health-related metrics. 

Table of Contents
-----------------
1. Contents
2. Installation Instructions
3. Usage
4. License
5. Contact Information
6. Acknowledgements

1. Contents
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

2. Installation Instructions
----------------------------
Outside of setting R's project and/or working directory to the location of the Excel file, each script is fully self-sufficient and should be able to function by using

- Download R and R studio
  
All scripts (i.e., .R and .qmd files) should 
- Download the project files by cloning the GitHub repository:
    [https://github.com/username/project-name.git](git clone]

3. Usage
---------


Example:
- After installing the necessary packages, run the following R script to load and analyze the data:
    source("analysis_script.R")
- You can view results by opening the "output.html" file generated after running the analysis.

4. License
----------
Provide the license for your project, indicating how others can use, modify, and distribute it.

Example:
This project is licensed under the MIT License. See LICENSE.txt for details.

5. Contact Information
----------------------
Provide contact information for users to reach out if they have any questions, bugs, or contributions. 

Example:
For questions or issues, contact:
John Doe
email@example.com

6. Acknowledgements
-------------------
Give credit to any contributors, libraries, or resources that helped with your project.

Example:
- Credit to the authors of the ggplot2 and dplyr packages for their outstanding work.
- This project was developed with funding from the Coral Restoration Fund.

Additional Notes (Optional)
----------------------------
Include any other important details, caveats, or special instructions. This section can be optional, depending on the complexity of your project.

Example:
- Please note that the data used in this project is only valid for the years 2020–2023.
- The project is still in development; additional features are coming soon.
