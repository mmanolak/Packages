packages <- c("tidyverse", "wooldridge", "readxl", "haven", "dbplyr", "rvest", 
              "httr", "jsonlite", "lfe", "plm", "estimatr", "sandwich", 
              "lmtest", "vars", "tseries", "fable", "forecast", "urca", 
              "ggthemes", "gitcreds", "usethis", "installr")


missing_packages <- packages[!sapply(packages, requireNamespace, quietly = TRUE)]
missing_packages


#windowsOS checker for dependent directory
if (sys_name == "Windows") {
  if (node_name == "DegreeLaptop" || user_name == "Degree Laptop") { 
    setwd("C:/Users/Degree Laptop/Desktop/Spring 2025/3 - Econ 256 (Data Vis)")
  } else { 
    setwd("C:/Users/Michael/Desktop/Spring 2025/3 - Econ 256")
  }
  #LinuxOS Checker
} else if (Sys.info()['sysname'] == "Linux") {
  setwd("~/Desktop/R Files/Econ256")
  #macOS check
} else if (Sys.info()['sysname'] == "Darwin") {
  setwd("~/Desktop/Spring 2025/3 - Econ 256")}

#Output the result for packages
if (length(missing_packages) > 0) {
  print("The following packages are missing:")
  print(missing_packages)
} else {
  print("There are no missing packages.")
}


osdisplay<-switch(Sys.info()[['sysname']],
                  Windows= {print("I'm a Windows PC.")},
                  Linux  = {print("I'm a penguin.")},
                  Darwin = {print("I'm a Mac.")})


