# GCD_CourseProject
Course Project, Coursera Getting and Cleaning Data

The following instructions were provided for this project:

	The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
	
	One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
	
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
	
	Here are the data for the project: 
	
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	
	 You should create one R script called run_analysis.R that does the following. 
	
		1.	Merges the training and the test sets to create one data set.
		2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
		3.	Uses descriptive activity names to name the activities in the data set
		4.	Appropriately labels the data set with descriptive variable names. 
		5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
	
	Good luck!

### Contents
The repository contains three files:

- README.md
- CodeBook.md: Describes the variables in the tidy datasets and all major transformations
- run_analysis.R:  Single R script executing all project steps

### Analysis Plan
Data files are presumed to be in specific subdirectories under the working directory where the code runs.  In particular, predictors and response variables for the training segment should be in two files under ./train, and the corresponding files for the test segment should be located in ./test.

The single, run_analysis.R script proceeds according to the steps outlined in the instructions, consolidating the four data files into a "master" tidy data set, summarizing the data set according to the instructions, and exporting the resulting summary view to a tab-delimited text file.

Note that the aggregation required by the instructions may be nonsensical for the underlying data structure.  However, I am assuming that the point of the exercise is less to create meaningful output than to demonstrate the ease with which tidy tools can be applied to a tidy dataset.
