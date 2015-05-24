#load libraries used in this project

library(data.table)
library(dplyr)





# Step1. Merges the training and the test sets to create one data set.

#read train data
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activity_train <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
features_train <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

#read test data
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activity_test <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
features_test <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

#merge data
subject <- rbind(subject_train, subject_test)
activity <- rbind(activity_train, activity_test)
features <- rbind(features_train, features_test)

#load data columns names
features_names <- read.table("UCI HAR Dataset/features.txt")


#change the column names
colnames(features) <- t(features_names[2])
names(subject)<-c("subject")
names(activity)<- c("activity")

#create final merged data set
final_data <- cbind(features,activity,subject)

#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement. 

#get all the columns names that contains "mean" or "std"
columns_contains_mean_or_std <- grep("mean\\(\\)|std\\(\\)", names(final_data), ignore.case=TRUE)
columns_to_extract<-c(columns_contains_mean_or_std, 562, 563)
#extract data from the "final_data" dataset 
extracted_measurements<- final_data[,columns_to_extract]

#Step 3 Uses descriptive activity names to name the activities in the data set

#load labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

extracted_measurements$activity <- as.character(extracted_measurements$activity)

for (i in 1:6){
extracted_measurements$activity[extracted_measurements$activity == i] <- as.character(activity_labels[i,2])
}


extracted_measurements$subject <- as.factor(extracted_measurements$subject)

names(extracted_measurements)<-gsub("Acc", "Accelerometer", names(extracted_measurements))
names(extracted_measurements)<-gsub("Gyro", "Gyroscope", names(extracted_measurements))
names(extracted_measurements)<-gsub("BodyBody", "Body", names(extracted_measurements))
names(extracted_measurements)<-gsub("Mag", "Magnitude", names(extracted_measurements))
names(extracted_measurements)<-gsub("^t", "Time", names(extracted_measurements))
names(extracted_measurements)<-gsub("^f", "Frequency", names(extracted_measurements))
names(extracted_measurements)<-gsub("tBody", "TimeBody", names(extracted_measurements))
names(extracted_measurements)<-gsub("-mean()", "Mean", names(extracted_measurements), ignore.case = TRUE)
names(extracted_measurements)<-gsub("-std()", "STD", names(extracted_measurements), ignore.case = TRUE)
names(extracted_measurements)<-gsub("-freq()", "Frequency", names(extracted_measurements), ignore.case = TRUE)
names(extracted_measurements)<-gsub("angle", "Angle", names(extracted_measurements))
names(extracted_measurements)<-gsub("gravity", "Gravity", names(extracted_measurements))

#create data table
extracted_measurements <- data.table(extracted_measurements)

#create tidy 

tidy <- aggregate(. ~subject + activity, extracted_measurements , mean)

#order tidy
tidy <- tidy[order(tidy$subject,tidy$activity),]

#write table to file
write.table(tidy, file = "Tidy_Data_Set.txt", row.names = FALSE)
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)