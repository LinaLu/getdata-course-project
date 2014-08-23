Getting & Cleaning Data Course Project (https://class.coursera.org/getdata-006)
================================================================================

Introduction
------------

This repository contains the course project of the "Getting & Cleaning Data" MOOC developed by John Hopkins University, hosted by Coursera.org

The purpose of the course project is to collect, transform and clean up the date collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the following site as where the data was originally obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Requirements
------------

The run_analysis.R are developed and tested with the following language version:

 - R version 3.1.1


Installation
------------

Download the dataset from the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Extract the dataset to the same directory as the run_analysis.R script is located.
Execute the run_analysis.R script by: source('run_analysis.R')
A file, containing the cleaned and transformed dataset, named "tidy.txt" is procured to the directory

run_analysis.R is a script that does the following:

1. Read 3 files: X_train.txt, y_train.txt, subject_train.txt. 
2. Read 3 files: X_tesr.txt, y_test.txt, subject_test.txt. 
3. Merge data frames training and test, to create one data frame named dataset.
4. Label the column names in the created data frame using the file ""
5. Subset by keeping only columns/variables measuring either mean or standard deviation.
6. Uses activity_label (activity_labels.txt) to describue the activities in the data set: 
7. Renames the data set with more human friendly variable names.  
8. Creates a second, independent tidy data set with the average of each variable 
   for each activity and each subject. 
9. Exports the created dataset as tidy.txt
