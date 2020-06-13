# Getting-and-Cleaning-Data-Course-Project
The repository contains the project work related to the peer review project in Getting and Cleaning Data course on Coursera.
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.

### Files in the repository :
1. run_analysis.R : This is the R Script that achieves the objective of preparing the final tidy dataset, as mentioned in the
   course's project instructions.
   * The first step of the script checks for existence and downloads the Human Activity Recoginition Dataset zipfile from
      https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and unzips the dataset.
   * The second step reads all the data files as data tables and assigns them with proper column names.
   * The next 5 steps perform the following tasks as listed -
      * Merges the training and the test sets to create one data set.
      * Extracts only the measurements on the mean and standard deviation for each measurement.
      * Uses descriptive activity names to name the activities in the data set
      * Appropriately labels the data set with descriptive variable names.
      * From the data set in above step creates a second, independent tidy data set with the average of each variable for each activity and each subject.
