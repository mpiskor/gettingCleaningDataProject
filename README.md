#Introduction

This is the repository with my attempt at completing the course project for Coursera's *Getting and Cleaning Data* course. It contains the following elements:

* the `run_analysis.R` script containing the R-script for processing the data
* the `cleanDataMeans.csv` file containing the resulting, limited and averaged dataset
* the `CookBook.md` file containing the description of all that happens in the analysis
* the `Readme.md` file, which you are reading now

# Position of project requirements as defined in the 5-point project description, point by point

1. Merges the training and the test sets to create one data set. - *with the `prepareData` function and as top-level `merge` command.*
2. Extracts only the measurements on the mean and standard deviation for each measurement. -- *with the `limitData` function*
3. Uses descriptive activity names to name the activities in the data set -- *with the `prepareData` and helper functions (see the CodeBook.md)*
4. Appropriately labels the data set with descriptive variable names. - *with the `prepareData` and helper functions (see the CodeBook.md)*
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. -- *as a to-level dplyr pipe and write.csv() at the end of the run_analysis.R script*
=======
# gettingCleaningDataProject
my attempt at the Coursera Getting and Cleaning Data project
>>>>>>> 5ca0da58ca2df9cd96a21920db2fb03664af6abc
