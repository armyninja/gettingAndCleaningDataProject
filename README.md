# Kevin Reynolds Getting and Cleaning Data - Course Project

## To use this script please install the "reshape2" package using the install method below:

install.packages ('reshape2')
library(reshape2)


This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Download the dataset if it does not already exist in the working directory
2. Merges the training and the test sets to create one data set.
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names. 
6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The end result is shown in the file `tidy.txt`.