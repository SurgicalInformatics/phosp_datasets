# PHOSP-Covid dataset generation script

Generates a cleaned PHOSP-Covid dataset.  Currently runs on a daily basis. See below for instructions on how to load the datasets.


# Cleaning scripts

This project runs the cleaning scripts in the `phosp_clean` project, here: <a href="https://github.com/SurgicalInformatics/phosp_clean" target="_blank">phosp_clean</a>

The `phosp_clean` project includes:

* `01_data_pull.R` pulls the data from REDCap, applies levels to factors (pulled as 0, 1, 2...), adds labels.
* `02_functions.R` defines some functions.
* `03_prep.R` cleans the `phosp` data.


The code will be well commented, so make sure to have a look through:

<a href="https://github.com/SurgicalInformatics/phosp_clean/blob/main/03_prep.R" target="_blank">03_prep.R (github.com/SurgicalInformatics/phosp_clean/)</a>   




## Saved shared objects:

To save the database API from too many pulls, and our disk space from saves, there's a shared folder at
`/home/common/phosp/`.

```
lnorman@argosafe:/home/common/phosp$ ls -al
total 16
drwxr-xr-x 4 eharrison covid         4096 Feb 16 12:24 .
drwxrwxr-x 5 root      rstudio-users 4096 Feb 16 12:21 ..
drwxr-xr-x 3 eharrison covid         4096 Feb 16 12:28 cleaned
drwxr-xr-x 2 eharrison covid         4096 Feb 17 13:51 raw
```

The `raw` folder includes the output of `01_data_pull.R` - so it's been factored, but otherwise not cleaned at all.  The files are named `phosp_` followed by the timestamp when they were created.

```
lnorman@argosafe:/home/common/phosp/raw$ ls -al
total 24092
drwxr-xr-x 2 eharrison covid    4096 Feb 17 13:51 .
drwxr-xr-x 4 eharrison covid    4096 Feb 16 12:24 ..
-r-xr-x--- 1 root      covid 4542956 Feb 17 04:02 phosp_2021-02-17_0400.rds
```

The `cleaned` folder includes the object after the cleaning scripts have been run.  They're named `phosp_hosp_` followed by the timestamp when they were created:

```
lnorman@argosafe:/home/common/phosp/cleaned/full$ ls -al
total 11888
drwxr-xr-x 2 eharrison covid    4096 Feb 17 04:02 .
drwxr-xr-x 3 eharrison covid    4096 Feb 16 12:28 ..
-r-xr-x--- 1 root      covid  431299 Feb 17 04:02 phsop_hosp_2021-02-17_0400_full.rds
```


# Use

The datasets are currently being generated daily at 4am.
The following code shows an example of how to read the cleaned dataset in.
The last part of the timestamp will always read `0400`. You can then edit the datestamp depending on whether you would like to access the most recent dataset, or from a particular date.  The timestamp for the earliest dataset we have created is the one shown, from the 17th Feb 2021. 


```{r, eval = FALSE}
library(readr) # loaded with tidyverse anyway
datadir = "/home/common/phosp/cleaned/full/"
timestamp = "2021-02-17_0400"

phosp_hosp   = read_rds(paste0(datadir, "phosp_hosp_", timestamp, "_full.rds"))
```





