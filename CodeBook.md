# Introduction

This is the codebook for my Coursera Getting and Cleaning Data programming project. It describes all the steps taken to analyse the dataset. 

I assumed the approach of using functions to analyse data. Since there are two types of data (training and test) I wanted to process them with exactly the same code.

# Downloading the data

The 3-5 download the data and unzip it to a default folder. It will be asumed in what follows that the location of the data is the default location after using the `unzip` command.

# Cleaning the data

In each folder (train and test) I have 3 files of interest

1. `subject_test.txt`, where the test subject number is given
2. `y_test.txt` - the activity performed by the subject
3. `X_test.txt` - the features (variables) which are anaysed in this project

I am going to produce 2 data.frames, 1 for the training group, 2 for the test group, clean themd merge them together. Since the training and test files have the same structure, I am going to use FUNCTIONS so that both types are processed with the same code

## Functions for loading and cleaning the data

* `prepareData`
Accepts the datatype (train or test),  reads from numerous sources and returns a complete dataframe for either the training dataset or the test dataset. One of the steps includes assigning DESCRIPTIVE NAMES FOR ACTIVITIES. This function uses helper  functions defined below.
* `readDataFrame`
Accepts datatype (train or test) and filtype (features, subjects, activities). The function reads the data from the respective source (train or test) and returns a dataframe corresponding to prepareData, where all filetypes are c-bound into a resulting dataFrame. This function also provides DESCRIPTIVE NAMES FOR COLUMNS
* `readFeatureNames`
Reads out the names of the features and returns them as a vector for use in `readDataFrame`
* `limitData`
Accepts a dataframe, searches for `std` and `mean` within the colnames and returns a limited (to stds and means) data frame. It is NOT a helper function and it is used in the subsequent top-level code 

## Using the functions to clean and limit

* The data are loaded (with `prepareData`) and, since both data frames are of identical format,  they are just bound (as there is no need for the more complicated `merge`). 
* Then the data are limited to columns containing `std`s and `mean`s. (step 2 in the project description) 
* Finally, the data are pushed through a pipe that groups it by the subject and activity and calculates the means. 
* The result is saved to the `cleanDataMeans.csv` file.

# Variable names

* subjects - the number of the subject
* activities - descriptive names of the activiites
* subsequent names - correspond exactly to the `features.txt` files in train\test folders. They are obviously limited to those which contain `std`s and `mean`s