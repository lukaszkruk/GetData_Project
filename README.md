# Getting and Cleaning Data Project

This repo contains a single R-file *run_analysis.R*, which contains 4 functions that make up the project.  
The aim of this project is to take the [UCI HAR Dataset](https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and tidy the dataset. 
The project has 5 objectives:

1. Merge all data into a single dataset and this dataset contains 1 variable per column and 1 observation per row
2. Extract only the means and standard deviations of measurements
3. Give activities descriptive names
4. Give variables (columns) descriptive names

In addition:  
5. Create a summary from this tidy dataset, with the means per subject per 
activity

## Quick Start
load run_analysis.R and call the runProject()-function
This uses the default settings. Optionally a directory for the dataset and a filename for the summary can be specified.

## The Dataset
The used files in the dataset are:  
activity_labels.txt - matches activity codes with descriptive names  
features.txt - variable names for test and train datasets  
test/subject_test.txt - subjects test dataset  
test/X_test.txt - main test dataset  
test/y_test.txt - activities test dataset  
train/subject_train.txt - subjects train dataset  
train/X_train.txt - main train dataset  
train/y_train.txt - activities train dataset  

## Functions
Here the functions in run_analysis.R are described that make up the project

### Function 1: getTidyData
This is the main workhorse for this project. The function accepts a directory
where the dataset is stored creates a tidy dataset. In overview (with numbers
matching the steps marked in the R code):   
1. - 2. A check is performed to verify all above listed files are present and if so, they are all 
read into memory.  
3. The activity codes and subjects - which are stored in separate files, are merged into their respective datasets.  
4. - 5. the columns are given descriptive names based on features.txt.   
6.1 The test and train dataset are merged. This completes **objective 1 and 4**.  
6.2 From this dataset, only the columns that have 'mean' or 'std' in their name are selected, finising **objective 2**.   
6.3 - 6.4 The activity codes are translated into descriptive activity names.   
7. This finalizes **objective 3** and results in a tidy dataset which is returned.  

### Function 2: createSummary
This function takes the dataset from getTidyData as input, together with a filename and creates a summary.
This summary is the average per subject per activity for all the columns, meeting **objective 5**.
This summary is then written to a file in the working directory.

### Function 3: readSummary
This function is not necessary for the project, but is a little helper-function to read to generated summary back into R.

### Function 4: runProject
This function is the only one the end-user needs to call, which in turn calls getTidyData and createSummary to fulfill the entire project with a single call.