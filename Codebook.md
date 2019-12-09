Code Book

This document describes the code inside run_analysis.R.

Data source

This dataset is derived from the "Human Activity Recognition Using Smartphones Data Set" which was originally made available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Assumptions:
Data for this already downloaded as per README.md

Objectives:
Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity    and each subject.

Comments are added in run file but a brief description:

1. Load packages required to run certain functions
2. Set working directory (alter current working directory for R)
3. Read variables measured (i.e. column names)
4. Read activity labels (6 activities)
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING
5. Read raw data :training and test data sets into data frames
6. Merge data with row bind function and create a completed data frame
7. Extract data that where measurement contains mean/std deviation only
8. Rename activities as part of the tidy data exercise 1 = walking etc...
9. Rename column headings as part of the tidy data exercise
10.Create tidy sorted data set and write results to a text file

Note:
Subject label contains the n of 30 subjects where measurements was taken
