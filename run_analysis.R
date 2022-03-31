library(dplyr)

# Read in all the data files
trainDataX <- read.table(file.path('data','train','X_train.txt'))
trainDatay <- read.table(file.path('data','train','y_train.txt'))
trainDatsubject <- read.table(file.path('data','train','subject_train.txt'))

testDataX <- read.table(file.path('data','test','X_test.txt'))
testDatay <- read.table(file.path('data','test','y_test.txt'))
testDatasubject <- read.table(file.path('data','test','subject_test.txt'))

# Read in activities and features lists

features <- read.table(file.path('data','features.txt'))
activities <- read.table(file.path('data','activity_labels.txt'))

# Merge the test and train datasets
X <- rbind(trainDataX,testDataX)
y <- rbind(trainDatay, testDatay)
subject <- rbind(trainDatsubject, testDatasubject)


# Filter out columns other than mean and std values from both X dataset 
# and the features name list

X <- X[,grepl('mean\\(\\)|std\\(\\)',features$V2)]
features <- grep('mean\\(\\)|std\\(\\)',features$V2, value = TRUE)

# Tidy column names (presently in the features table) by removing '-' and '()' 
# and converting to lower case, then assigning the vector to the col names of 
# the X dataset

features <- gsub('-','',features)
features <- gsub('\\(\\)','',features)
features <- tolower(features)

colnames(X) <- features

# Replacing numeric values in the y dataset by the activity names given in 
# activity_labels.txt and converting to lower case.

for (i in seq(along.with=t(activities[,1]))){
       y[y == as.character(i)] <- tolower(activities[i,2])
}

# Assign column names to the subject and activities tables

colnames(subject) <- 'subject'
colnames(y) <- 'activities'

# Merge all the tables

data <- cbind(cbind(subject,y),X)

# Group merged data set by activity and subject then finds the average 
# for all other variables creating a data set with the average of each variable 
# for each activity and each subject
data_grouped <- data %>% group_by(activities, subject)
avg_table <- data_grouped %>% summarise_all(mean, na.rm = TRUE)

# Write out the data set with the average of each variable for each activity 
# and each subject

write.table(avg_table, 'tidydata.txt',  row.name=FALSE)

