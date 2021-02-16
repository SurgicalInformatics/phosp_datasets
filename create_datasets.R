# PHOSP-Covid REDCap database cleaning and saving of objects
# This will source the cleaning scripts from the phosp_clean
# and put the objects in our shared data directory (secure server, encrypted)
# Centre for Medical Informatics, Usher Institute, University of Edinburgh 2020

# Log
cat(paste("Start:", Sys.time()))

# Environment variables
readRenviron("/home/eharrison/.Renviron")

# Pull raw data
timestamp = format(Sys.time(), "%Y-%m-%d_%H%M")
source("/home/eharrison/phosp_clean/01_data_pull.R")
saveRDS(phosp, file = paste0("/home/common/phosp/raw/phosp_", timestamp, ".rds"))

# Clean
source("/home/eharrison/phosp_clean/02_functions.R")
system.time(source("/home/eharrison/phosp_clean/03_prep.R"))
mydir = "/home/common/phosp/cleaned/full/"

# Write out
saveRDS(phosp, paste0(mydir, "phosp_", timestamp, "_full.rds"))
saveRDS(phosp_hosp, paste0(mydir, "phsop_hosp_", timestamp, "_full.rds"))

lastrun = lubridate::ymd_hm(timestamp)
save(lastrun,
     file = paste0(mydir, "helpers_", timestamp, "_full.rda"))

system("chmod 550 /home/common/phosp/raw/*")
system("chmod 550 /home/common/phosp/cleaned/full/*")
system("chown -R :covid /home/common/phosp/raw")
system("chown -R :covid /home/common/phosp/cleaned")
