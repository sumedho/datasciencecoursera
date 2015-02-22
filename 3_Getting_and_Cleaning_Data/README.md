cleaning_data
=============

###Contents
This folder on github contains the following:

1. run_analysis.R - the function to perform the analysis and write a table to disk.
2. README.md - this file detals how to run the code and the files in the directory.
3. tidy_data.txt - the resulting tidy dataset.
4. CodeBook.md - the codebook related to the analysis.

###Data 
* The data used is a set of human activity measurements using a smart phone. 
* The data used in this analysis is available from [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
* The measurements of mean and std for *combined* measurements were used. *Individual* axis mean and std were discarded during processing.

###Instructions
* This function expects the UCI HAR Dataset is unzipped in the working directory with the folder structure intact. 
* The run_analysis.R script is expected to be in the working folder. 
* After running, a text file called tidy_data.txt will be written to the working directory.
* The function will return a data frame of the complete tidy data. 
* The function requires the plyr library. This can be installed by entering the following in the console:
```
install.packages("plyr")
```
* The script can be run by typing the following into the R console.
```
source('run_analysis.R')
tidy_data<-run_analysis()
```
* The final tidy data frame will be returned into a variable called tidy_data in this example. It will be also written to disk as tidy_data.txt

* The data can be loaded into R using the following:
```
data<-read.table("tidy_data.txt", header=TRUE)
```
* The data will be read into a data frame called tidy_data in this example.








