---
title: "CodeBook.md"
author: "Rodrigo González"
date: "11/8/2020"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

Getting and Cleaning Data - Course Project
==========================================
# Modifications
## R script called `run_analysis.R` does the following
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


1. **Download the dataset**
    + Dataset downloaded and extracted under the folder called `UCI HAR Dataset`
    + Source: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
    
    <br/>
2. **Assign each data to variables**
    + `feature` <- `features.txt` : 561 rows, 2 columns <br/>
        *The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.*
    + `a_label` <- `activity_labels.txt` : 6 rows, 2 columns <br/>
        *List of activities performed when the corresponding measurements were taken and its codes (labels)*
    + `subject_test` <- `test/subject_test.txt` : 2947 rows, 1 column <br/>
        *contains test data of 9/30 volunteer test subjects being observed*
    + `x_test` <- `test/X_test.txt` : 2947 rows, 561 columns <br/>
        *contains recorded features test data*
    + `y_test` <- `test/y_test.txt` : 2947 rows, 1 columns <br/>
        *contains test data of activities'code labels*
    + `subject_train` <- `test/subject_train.txt` : 7352 rows, 1 column <br/>
        *contains train data of 21/30 volunteer subjects being observed*
    + `x_train` <- `test/X_train.txt` : 7352 rows, 561 columns <br/>
        *contains recorded features train data*
    + `y_train` <- `test/y_train.txt` : 7352 rows, 1 columns <br/>
        *contains train data of activities'code labels*
   
    <br/>
3. **Merges the training and the test sets to create one data set**
    + `x_data` (10299 rows, 561 columns) is created by merging `x_train` and `x_test` using **rbind()** function
    + `y_data` (10299 rows, 1 column) is created by merging `y_train` and `y_test` using **rbind()** function
    + `subject_data` (10299 rows, 1 column) is created by merging `subject_train` and `subject_test` using **rbind()** function
    + `merged_data` (10299 rows, 563 column) is created by merging `subject_data`, `y_data` and `x_data` using **cbind()** function
   
    <br/>
4. **Extracts only the measurements on the mean and standard deviation for each measurement**
    + `tidy_data` (10299 rows, 88 columns) is created by subsetting `merged_data`, selecting only columns: `subject`, `code` and the measurements on the `mean` and *standard deviation* (`std`) for each measurement

    <br/>
5. **Uses descriptive activity names to name the activities in the data set**
    + Entire numbers in `code` column of the `tidy_data` replaced with corresponding activity taken from second column of the `activities` variable

    <br/>
6. **Appropriately labels the data set with descriptive variable names**
    + `code` column in `tidy_data` renamed into `activities`
    +  All `Acc` in column's name replaced by `Accelerometer`
    +  All `Gyro` in column's name replaced by `Gyroscope`
    +  All `BodyBody` in column's name replaced by `Body`
    +  All `Mag` in column's name replaced by `Magnitude`
    +  All start with character `f` in column's name replaced by `Frequency`
    +  All start with character `t` in column's name replaced by `Time`

    <br/>
7. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject**
    + `final_data` (180 rows, 88 columns) is created by sumarizing `tidy_data` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
    + Export `final_data` into `FinalData.txt` file.

</div>

<br/>

