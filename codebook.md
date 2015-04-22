# Codebook 

## Experimental design and background
Human Activity Recognition Using Smartphones Dataset  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING UPSTAIRS, WALKING DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

Citation for the original dataset  
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012  
URL: https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Variables for the dataset are described in 'features_info.txt', found in the raw dataset.

## Raw Data
The dataset includes the following files:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
The following files are available for the train and test data. Their descriptions are equivalent.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- Inertial Signals are provided as well, but not used for this project

## Processed data
Dataset tidying
1. Subjects and Activities are merged into their respective datasets
2. Both datasets are given descriptive column names, based on features.txt
3. The training- and test-dataset are joined into a single dataset
4. A subset of columns is selected based on the following rules:
4.1 Only columns that contain 'subject', 'activity','mean' or 'std' are included
4.2 From the previous step, columns containing 'Freq' or 'angle' are excluded. These columns contain the word 'mean' in their name, but do not describe an actual mean of a measurement
5. The activity codes merged in step one are replaced by descriptions through a left join of the contents of activity_labels.txt

Summarising
6. The dataset is grouped by Activity and subject
7. The mean of each measurement per group is taken
8. The summary is written to a file
