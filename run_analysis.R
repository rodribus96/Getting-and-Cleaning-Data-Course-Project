# Prepare libraries
library(dplyr)

# Download dataset from Web

filename <- "RawData.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Merge the training and the test sets to create one data set
# Reference: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# Load feature & activity info
feature <- read.table(paste(sep = "", "./UCI HAR Dataset/features.txt"), col.names = c("n","functions"))
a_label <- read.table(paste(sep = "", "./UCI HAR Dataset/activity_labels.txt"), col.names = c("code", "activity"))
a_label[,2] <- as.character(a_label[,2])

# Train data
x_train <- read.table(paste(sep = "", "./UCI HAR Dataset/train/X_train.txt"), col.names = feature$functions)
y_train <- read.table(paste(sep = "", "./UCI HAR Dataset/train/Y_train.txt"), col.names = "code")
subject_train <- read.table(paste(sep = "", "./UCI HAR Dataset/train/subject_train.txt"), col.names = "subject")

# Test data
x_test <- read.table(paste(sep = "", "./UCI HAR Dataset/test/X_test.txt"), col.names = feature$functions)
y_test <- read.table(paste(sep = "", "./UCI HAR Dataset/test/Y_test.txt"), col.names = "code")
subject_test <- read.table(paste(sep = "", "./UCI HAR Dataset/test/subject_test.txt"), col.names = "subject")

# Merge
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_data, y_data, x_data)

# Extract mean and standard deviation for each measurement.
tidy_data <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# Name the activities
tidy_data$code <- a_label[tidy_data$code, 2]
  
# Labels the data
names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("angle", "Angle", names(tidy_data))
names(tidy_data)<-gsub("gravity", "Gravity", names(tidy_data))

# Final Data
final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(final_data, "FinalData.txt", row.names = FALSE)           
