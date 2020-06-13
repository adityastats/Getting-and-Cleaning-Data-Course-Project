#Importing required library

library(dplyr)

# ----------------------------------------
# STEP-1: Dowloading the required dataset
# ----------------------------------------

### 1.1: Checking if data directory already exists and if not creating the directory

if(!file.exists("data")){
  dir.create("data")
}

### 1.2: Checking if zip file of dataset already exists and if not downloading the dataset zip file

if(!file.exists("./data/Dataset.zip")){
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url = fileurl,destfile = "./data/Dataset.zip")
}
download_date <- date()

### 1.3: Checking if dataset is extracted and if not extracting the dataset

if(!file.exists("./data/UCI HAR Dataset")){
  unzip(zipfile = "./data/Dataset.zip",exdir = "./data")
}

# ------------------------------------------------------------------------------------------------------
# Step-2: Reading all the files in the UCI HAR Dataset as Data Tables and assigning proper column names
# ------------------------------------------------------------------------------------------------------

### 2.1: Reading features and activities data and assigning column names

features <- read.table(file = "./data/UCI HAR Dataset/features.txt",col.names = c("SL.","variables"))
activities <- read.table(file = "./data/UCI HAR Dataset/activity_labels.txt",col.names = c("activity_id","activity"))

### 2.2: Reading training sets data and assigning column names

x_train <- read.table(file = "./data/UCI HAR Dataset/train/X_train.txt",col.names = features$variables)
y_train <- read.table(file = "./data/UCI HAR Dataset/train/y_train.txt",col.names = "activity_id")
subj_train <- read.table(file = "./data/UCI HAR Dataset/train/subject_train.txt",col.names = "subject_id")

### 2.3: Reading testing set data and assigning column names
x_test <- read.table(file = "./data/UCI HAR Dataset/test/X_test.txt",col.names = features$variables)
y_test <- read.table(file = "./data/UCI HAR Dataset/test/y_test.txt",col.names = "activity_id")
subj_test <- read.table(file = "./data/UCI HAR Dataset/test/subject_test.txt",col.names = "subject_id")


# ------------------------------------------------------------------------
# Step-3: Merging the training and test sets to form one complete dataset
# ------------------------------------------------------------------------

x_merged <- rbind(x_train,x_test) 
y_merged <- rbind(y_train,y_test)
subj_merged <- rbind(subj_train,subj_test)
data_merged <- cbind(subj_merged,x_merged,y_merged)

# -------------------------------------------------------------------------------------
# Step-4: Extracting only the measurements on mean and standard deviation for each measurement 
# -------------------------------------------------------------------------------------

data_extracted <- data_merged %>% select(subject_id,contains("mean.."),contains("std.."),activity_id)

# -------------------------------------------------------------------------------
# Step-5: Naming the activities in the extracted datasets with descritive activity names
# -------------------------------------------------------------------------------

data_named <- merge(data_extracted,activities,by="activity_id",all.x = TRUE)

# -------------------------------------------------------------
# Step-6: Labeling the dataset with descriptive variable names
# -------------------------------------------------------------
names(data_named) <- gsub(pattern = "Acc", replacement = "Accelerometer",x = names(data_named))
names(data_named) <- gsub(pattern = "Mag", replacement = "Magnitude",x = names(data_named))
names(data_named) <- gsub(pattern = "Gyro", replacement = "Gyroscope",x = names(data_named))
names(data_named) <- gsub(pattern = "BodyBody", replacement = "Body",x = names(data_named))
names(data_named) <- gsub(pattern = "Acc", replacement = "Accelerometer",x = names(data_named))

# -------------------------------------------------------------------------------------------------------------
# Step-7: Creating a second, independent tidy dataset with average of each variable for each activity and each subject
# -------------------------------------------------------------------------------------------------------------

tidyData <- data_named %>% group_by(activity,subject_id) %>% summarise_all(funs(mean))

###Writing the newly created tidy data as a text file

write.table(tidyData,file = "./data/tidyData.txt",row.names = FALSE)
