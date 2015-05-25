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
#colums 562 and 563 corespond to "activity" and "subject"
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

#Step 4 Appropriately labels the data set with descriptive variable names. 
source_label=c("Acc","Gyro","BodyBody","Mag","^t","^f","tBody","-mean()","-std()","-freq()","angle","gravity")
replacement_labels=c("Accelerometer","Gyroscope","Body","Magnitude","Time","Frequency","TimeBody","Mean","StandardDeviation","Frequency","Angle","Gravity")

for (i in 1:12){
names(extracted_measurements)<-gsub(source_label[i], replacement_labels[i], names(extracted_measurements))
}

Step 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#create data table
extracted_measurements <- data.table(extracted_measurements)

#create tidy dataset that contain the average of each variable for each activity and each subject

tidy <- aggregate(. ~subject + activity, extracted_measurements , mean)

#write table to file
write.table(tidy, file = "Tidy_Data_Set.txt", row.names = FALSE)
