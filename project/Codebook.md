# CodeBook

This is a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data.

## The data source

* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of the dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

## The data

The dataset includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration.

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


##Variables
 - subject_train - read dataset from subject_train.txt
 - activity_train - read dataset from activity_train.txt
 - features_train - read dataset from features_train.txt
 - subject_test - read dataset from subject_test.txt
 - activity_test - read dataset from activity_test.txt
 - features_test - read dataset from features_test.txt
 - subject - merged dataset between subject_train and subject_test
 - activity - merged dataset between activity_train and activity_test
 - features - merged dataset between features_train and features_test
 - final_data - merged data from activity,subject and features
 - columns_contains_mean_or_std - vector of all the columns that contains mean() or std()
 - columns_to_extract - combined vector with all the values from columns_contains_mean_or_std and the column values coresponding to "activity" and "subject"
 - extracted_measurements - subset from final_data that contains just the columns included in columns_to_extract
 - activity_labels - read the activity labels from activity_labels.txt
 - tidy - final dataset with the average of each variable for each activity and each subject

##Steps 
- read train data
- read test data
- merge data from train and test
- load data columns names from files
- change the column names
- create master data set
- get all the columns names that contains "mean" or "std" plus the "activity" and "subject" columns
- create a new dataset that is a subset from the master data set and contains just the columns from the previous step
- load the activity labels from file
- apply the activity labels to the dataset
- factorize the "subject" column
- change the dataset column names to appropriately labels the data set with descriptive variable names 
- create a new datatable in order to be able to use write.table function
- create tidy dataset that contain the average of each variable for each activity and each subject
- write data to output file

