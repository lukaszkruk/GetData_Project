# Function to read the different files in the UCI HAR Dataset and merge them
# together into a single tidy dataset
getTidyDataset <- function(directory = ""){
        
        ## 1. Check if dplyr is installed and then load
        if(!"dplyr" %in% rownames(installed.packages()))
                install.packages(package)        
        library(dplyr)        
        
        ## 2. Check all files
        ### 2.1 Set path names for all required files
        pathHeaders <- paste(directory, "features.txt", sep = "")
        pathActivityNames <- paste(directory, "activity_labels.txt", sep = "")
        
        pathTest <- paste(directory, "test/X_test.txt", sep = "")
        pathTestActivity <- paste(directory, "test/y_test.txt", sep = "")
        pathTestSubjects <- paste(directory, "test/subject_test.txt", sep = "")
        
        pathTrain <- paste(directory, "train/X_train.txt", sep = "")
        pathTrainActivity <- paste(directory, "train/y_train.txt", sep = "")
        pathTrainSubjects <- paste(directory, "train/subject_train.txt", sep = "")
        
        ### 2.2 Check if all required files can be found, error if not
        if(!file.exists(pathHeaders) | 
                   !file.exists(pathActivityNames)|
                   !file.exists(pathTest) | 
                   !file.exists(pathTestActivity) | 
                   !file.exists(pathTestSubjects) |
                   !file.exists(pathTrain) | 
                   !file.exists(pathTrainActivity) |
                   !file.exists(pathTrainSubjects))
                stop(paste ("One or more files could not be found in", 
                            directory, "Please, check directory"))
        
        
        ## 3. Read the required data
        ### 3.1 Headers for descriptive variable names
        headers <- read.table(pathHeaders, na.strings = "", 
                              header = FALSE, stringsAsFactors = FALSE)
        
        ### 3.2 ActivityNames to convert activity codes into names
        activityNames <- read.table(pathActivityNames, na.strings = "", 
                                    header = FALSE, stringsAsFactors = FALSE)
        ### 3.3 Test dataset
        testset <- read.table(pathTest, na.strings = "", 
                              header = FALSE, stringsAsFactors = FALSE)
        ### 3.4 Activities for each row of the test dataset
        testsetActivity <- read.table(pathTestActivity, na.strings = "", 
                                      header = FALSE, stringsAsFactors = FALSE)
        ### 3.5 Subjects for each row of the test dataset
        testsetSubjects <- read.table(pathTestSubjects, na.strings = "", 
                                      header = FALSE, stringsAsFactors = FALSE)
        
        ### 3.6 Train dataset
        trainset <- read.table(pathTrain, na.strings = "", 
                               header = FALSE, stringsAsFactors = FALSE)        
        ### 3.7 Activities for each row of the train dataset
        trainsetActivity <- read.table(pathTrainActivity, na.strings = "", 
                                       header = FALSE, stringsAsFactors = FALSE)
        ### 3.8 Subjects for each row of the train dataset
        trainsetSubjects <- read.table(pathTrainSubjects, na.strings = "", 
                                       header = FALSE, stringsAsFactors = FALSE)
        
        ## 4. Convert datasets into tbl_df for manipulation with dplyr
        testset <- tbl_df(testset)
        testsetActivity <- tbl_df(testsetActivity)
        testsetSubjects <- tbl_df(testsetSubjects)
        trainset <- tbl_df(trainset)
        trainsetActivity <- tbl_df(trainsetActivity)
        trainsetSubjects <- tbl_df(trainsetSubjects)
                
        
        ## 5. Prepare headers and activityNames 
        headers.unique <- c("Subject","activitycode", make.unique(headers[,2]))
        colnames(activityNames) <- c("activitycode", "Activity")
        
        ## 6. Add subjects and activity to each row of the two datasets
        testset <- bind_cols(testsetSubjects, testsetActivity, testset)
        trainset <- bind_cols(trainsetSubjects, trainsetActivity, trainset)
        
        ## 7. Give the datasets descriptive headers
        colnames(testset) <- headers.unique
        colnames(trainset) <- headers.unique
        
        ## 8. Format the dataset
        dataset <- 
                ### 8.1 Merge the datasets
                bind_rows(testset,trainset) %>%
                
                ### 8.2 Select appropriate columns
                select(contains("Subject"),
                       contains("activitycode"), 
                       contains("mean"), 
                       contains("std")) %>%
                
                ### 8.3 Give activities descriptive names
                left_join(activityNames, by = "activitycode") %>%
                
                ### 8.4 Remove the old activity codes
                select(-activitycode)
        
        ## 9. Kind message to the user
        message("Dataset successfully tidied")
        
        ## 10. Return Dataset
        dataset
}

# Function to create the summary of the UCI HAR Dataset with the mean of each
# measurement per subject per activity
createSummary <- function(dataset, filename = "summary.txt"){
        
        ## 1. Group the dataset by subject and activity
        group_by(dataset, Subject, Activity) %>%
                
                ## 2. Generate mean for each column per Subject/Activity group
                summarise_each(funs(mean)) %>%
                
                ## 3. write this summary to a file in the working directory
                write.table(filename, row.name = FALSE)
        
        ## 4. Kind message to the user
        message(paste("Summary saved in", filename))
}

# Little helper function to read the summary data back into R
readSummary <- function(filename){
        ## 1. Read the summary file from specified filename
        read.table(filename, header = TRUE)
}

# Function to run the entire project with (my) default settings and file
# locations
runProject <- function(datafolder = "../UCI HAR Dataset/", 
                       summaryfile = "summary.txt"){
        dataset <- getTidyDataset(normalizePath(datafolder)) %>%
        createSummary
}

# Single call to run the Getting and Cleaning Data Project
runProject()
