# DataCleaningCourseProject
Course Project for John Hopkins Data Cleaning with R course

THis project uses the UCI HAR Dataset provided in the course, originally from Human Activity Recognition Using Smartphones Data Set of the UCI Machine Learning Repository [link](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
Included in this project is the R script, run_analysis.R, which does the following:

1. Reads in all the data files
1. Reads in activities and features lists
1. Merges the test and train datasets
1. Filters out columns other than mean and std values from both X dataset and the features name list
1. Tidies column names (presently in the features table) by removing '-' and '()' and converting to lower case, then assigning the vector to the col names of the X dataset
1. Replacing numeric values in the y dataset by the activity names given in  activity_labels.txt and converting to lower case.
1. Assign column names to the subject and activities tables
1. Merges all the tables
1. Groups merged data set by activity and subject then finds the average for all other variables creating a data set with the average of each variable for each activity and each subject
1. Writes out the data set with the average of each variable for each activity and each subject
