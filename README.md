getdataCourseProject
====================

coursera getting and cleaning data course project

run_analysis.R is a script that does the following:


1. set the working directory to: "~/r/getdata-005/course project"

2. Read 3 files: X_train.txt, y_train.txt, subject_train.txt. 
   and store them temporarily in data frame named training 
   
3. Read 3 files: X_tesr.txt, y_test.txt, subject_test.txt. 
   and store them temporarily in data frame named test. 
   
4. Merge data frames training and test, to create one data frame named dataset.
   Label the column names in the created data frame.
   
5. Remove the temporarily data frames (training and test)

6. Subset the dataset and store the result in data frame: dataset_mean_std
   Subset by keeping only columns/variables measuring either mean or standard deviation.

7. Read the file activity_labels.txt
   Store the result in: activity_label 
   Uses activity_label to name the activities in the data set: 
   dataset_mean_std (column named: activity)

8. Use function replacePatterns(), 
   to rename the data set with more human friendly variable names. 
  
9. Creates another subset from data frame (dataset)
   with the average of each variable for each activity and each subject.
   Store the new subset in dataset_average.
   
