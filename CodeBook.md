This codebook describes the data and any transformations that was done on the original data set to prepare the required final tidy dataset.
## About Original Data set :
The original dataset was downloaded as a zipfile named Dataset.zip from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The dataset contained the data collected from the accelerometer from the Samsung galaxy S smartphone. This data set named as __"Human Activity Recognition Using Smartphones Data Set"__ , had a total of 10,299 instances and 561 attributes based on data from 30 subjects.

## Transformations performed :
1. Extracted the data set from the zipfile to a folder named "UCI HAR Dataset".

2. Read all data as data tables into variables as - 
  * __features__ variable contains the data from "features.txt", stored in 531 rows and 2 columns. The names of the 2 columns was also assigned as "Sl." and "variables".
  * __activities__ variable has the information from "activity_labels.txt" regarding the acticity_id and names of the 6 activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING), stored in 6 rows and 2 columns. The names of the columns were assigned as "activity_id" and "acitivity".
  * __x_train__ variable stores the recorded data regarding the different features in "X_train.txt" from training set, in 7,352 rows and 561 columns. The names of the columns were assigned to be the values from the variables column in features table.
  * __y_train__ variable stores the data regarding the acitivity_id in "y_train.txt" from training set, in 7,352 rows and 1 column. The names of the only column in this was assigned to be "activity_id".
  * __subj_train__ variable stores the data regarding the subject_id in "subject_train.txt" from training set, in 7,352 rows and 1 column. The names of the only column in this was assigned to be "subject_id".
  * __x_test__ variable stores the recorded data regarding the different features in "X_test.txt" from test set, in 2,947 rows and 561 columns. The names of the columns were assigned to be the values from the variables column in features table.
  * __y_test__ variable stores the data regarding the acitivity_id in "y_test.txt" from test set, in 2,947 rows and 1 column. The names of the only column in this was assigned to be "activity_id".
  * __subj_test__ variable stores the data regarding the subject_id in "subject_test.txt" from test set, in 2,947 rows and 1 column. The names of the only column in this was assigned to be "subject_id".
  
3. Merging the training and testing sets into one complete data set
  * __x_merged__ variable is used to store the data after merging the x_train and x_test data variables using rbind().
  * __y_merged__ variable is used to store the data after merging the y_train and y_test data variables using rbind().
  * __subj_merged__ variable is used to store the data after merging the subj_train and subj_test data variables using rbind().
  * __data_merged__ variable is used to store the complete data formed after merging the x_merged, y_merged, and subj_merged data variables using cbind() in 10,299 rows and 563 columns.
  
4. Extracting the measurements on the mean and standard deviation for each measurement
  * __data_extracted__ variable was created using the "select" and "contains" function of dplyr library on the data_merged variable, to select the required columns of subject_id,acticity_id, and all the other columns having the measurements on the mean and standard deviation.
  
5. Naming the activities in the extracted datasets with descritive activity names
  * __data_named__ variable was created by merging the activities and data_extracted data tables with respect to the acitivity_id column using the "merge" function. Thus, naming the activities with descriptive activity names in the extracted data set.
  
6. Labeling the dataset with descriptive variable names
  * All "Acc" in column names was changed to "Accelerometer".
  * All "Mag" in column names was changed to "Magnitude".
  * All "Gyro" in column names was changed to "Gyroscope".
  * All "BodyBody" in column names was changed to "Body".

7. Creating a second, independent tidy dataset with average of each variable for each activity and each subject
  * __tidyData__ was created to store the final tidy data set containing the average of each variable for each activity and each subject which was done using the "group_by" and "summarise_all" functions of dplyr and the "mean" function.
  * Using the "write.table" function the final "tidyData" was exported and saved as a .txt file.
