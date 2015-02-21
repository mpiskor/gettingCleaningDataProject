library(dplyr)## this will be used only in the last step

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, dest = file.path(getwd(),"wearables.zip")) # I am on Windows, so no method supplied (which would be "curl" I guess)
unzip("wearables.zip")

## in each folder (train and test) I have 3 files of interest
## 1 - subject test, where the test subject number is given
## 2 - (x)(y)_test - the activity performed by the subject
## 3 - X_test - the features (variables) which are anaysed in this project
## I am going to produce 2 data.frames, 1 for the training group, 2 for the test group, clean them
## and merge them together. Since the training and test files have the same structure, I am
## going to use FUNCTIONS so that both types are processed with the same code

## this function reads from numerous sources and returns a complete dataframe for either the training
## dataset or the test dataset
prepareData <- function(dataType){
  ## subjects will be left as they are (as numbers), activities will have descriptive level names
  activities  <- getDataFrame(dataType, "activities")
  activities$activities <- factor(activities$activities, labels = c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))
  subjects <- getDataFrame(dataType, "subjects")
  features  <- getDataFrame(dataType, "features")
  resultingDataFrame <- cbind(subjects, activities, features)
}

## this function is for reading data from the disk - dataType is train/test, filetype is subject, 
## activity or feature
getDataFrame <- function(dataType, filetype){
  path <- file.path(".","UCI HAR Dataset", 
                    ifelse(dataType == "test", "test", "train"), ## the part below is a little tricky - triple condition - I learned it from Matloff's book
                    ifelse(filetype == "subjects", paste("subject_",dataType,".txt",sep=""), 
                           ifelse(filetype == "activities", paste("y_", dataType, ".txt", sep = "")
                                  , paste("X_", dataType, ".txt", sep = ""))))
  dataRead <- read.table(path, stringsAsFactors = filetype == "activities", header = FALSE)
  ## here the DESCRIPTIVE NAMES will be assigned to the read data
  if (filetype == "features")
    names(dataRead) <- readFeatureNames()
  if (filetype == "activities")
    names(dataRead) <- "activities"
  if (filetype == "subjects")
    names(dataRead) <- "subjects"
  return(dataRead)
}

## read the feature names and return them as a vector
readFeatureNames <- function(){
  path <- file.path(".","UCI HAR Dataset", "features.txt" )
  dane <- read.table(path, stringsAsFactors = F, header = F)
  return(dane[[2]])
}

## function to select only the columns containing means and standard deviations
limitData <- function(dataFrame){
  columnNames <- names(dataFrame)
  columnsWithMean <- grep("[Mm]ean", columnNames)
  columnsWithStd <- grep("std", columnNames)
  columnsToLeave <- c(1,2,columnsWithMean, columnsWithStd) ## 1 and 1 identify subjects and activities
  return(dataFrame[, columnsToLeave])
}

#reading in the train data
trainingData <- prepareData("train")
#reading in the test data
testData <- prepareData("test")

mergedData <- rbind(trainingData, testData) ## since the two dataframes have the same structure there is
## no need for "merge"

## this function will select the variables containing means and standard deviations
limitedData <- limitData(mergedData) 

## and now for the creation of the summarized data frame using dplyr
summarisedData <- limitedData %>%
  group_by(subjects, activities) %>%
  summarise_each(funs(mean)) ### this function was not covered in the course, but I found it on stackoverflow

## and finally saving the result
write.csv(summarisedData, file = "cleanDataMeans.csv")