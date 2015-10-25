#Kevin Reynolds Getting and Cleaning Data - run_analysis.R

# run_analysis.R does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#In order for this script to run a user needs to instal the reshape2 package by: install.packages('reshape2')
#user then needs to load the reshape2 library by typeing in library(reshape2)
#reshape2 is needed for the melt function

#-----
# Start run_analysis.R
#------


#create the filename
file_name <- "getdata_dataset.zip" 

#check for getdata_dataset.zip and if it is not there, download it
if (!file.exists(file_name)){
  file_URL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(file_URL, file_name, method="auto")
  }

#check for getdata_dataset.zip unzipped folder structure and if not there unzip it
if (!file.exists("UCI HAR Dataset")) { 
    unzip(file_name) 
 }

# Load activity_Labels, features
activity_Labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_Labels[,2] <- as.character(activity_Labels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# get mean and std into filtered results
features_filtered <- grep(".*mean.*|.*std.*", features[,2])
features_filtered.names <- features[features_filtered,2]
features_filtered.names = gsub('-mean', 'Mean', features_filtered.names)
features_filtered.names = gsub('-std', 'Std', features_filtered.names)
features_filtered.names <- gsub('[-()]', '', features_filtered.names)

# Load data
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_filtered]
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(subject_train, y_train, x_train)

x_test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_filtered]
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(subject_test, y_test, x_test)

# merge
final_Data <- rbind(train, test)
colnames(final_Data) <- c("subject", "activity", features_filtered.names)

# factor
final_Data$activity <- factor(final_Data$activity, levels = activity_Labels[,1], labels = activity_Labels[,2])
final_Data$subject <- as.factor(final_Data$subject)

final_Data.melted <- melt(final_Data, id = c("subject", "activity"))
final_Data.mean <- dcast(final_Data.melted, subject + activity ~ variable, mean)

# create tidy.txt
write.table(final_Data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)