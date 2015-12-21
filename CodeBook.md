# GCD Course Project - Code Book

A thorough description of the variables contained in the data files created by this project, as well as a brief outline of the processing steps that created them from the available input files.

## Study Design

All data processing steps are contained in a single R script called run_analysis.R.  This section describes the transformations that are applied to the input data to generate tidy data sets.

The script expects 6 input files (with paths relative to the location of the script):

	1) features.txt
	2) activity_labels.txt
	3) test/x_test.txt
	4) test/y_test.txt
	5) train/x_train.txt
	6) train/y_train.txt



## Code Book

Layout information for the two tidy data sets produced by this project.  Each variable is presented in the same sequence in which it appears in the data set.  The variable name is followed by a brief description, below which is the variable's domain (all possible values if categorical, and the observed range if numeric).

### I) gcd

gcd is the master tidy data set that combines the response and predictor variables from both the test and train data sets.  Descriptive activity labels have been added, and each variable (feature) name has been exploded into its component parts.

segment: Identifies whether the record came from a "test" or "train" file

	test		
	train

subject: Subject ID within the Segment (Segment and Subject fields are both required to identify a unique subject)

	[1, 7352]
		
activity: The actual activity being performed by the subject when measurements were taken (6 options)

	LAYING
	SITTING
	STANDING
	WALKING
	WALKING_DOWNSTAIRS
	WALKING_UPSTAIRS

domain: A feature descriptor, indicating whether the measurement is time- or frequency-related (extracted from values in features.txt).

	frequency
	time
		
component: A feature descriptor, indicating a body or gravity measurement (extracted from values in features.txt).

	body
	gravity
		
instrument: A feature descriptor, indicating whether the measurement was taken by the accelerometer or gyroscope (extracted from values in features.txt).

	accelerometer
	gyroscope
		
jerk.signal: A feature descriptor, indicating whether the measurement is a jerk signal (extracted from values in features.txt).

	no
	yes
		
magnitude: A feature descriptor, identifying a magnitude measurement (extracted from values in features.txt).

	no
	yes
		
axis: A feature descriptor, identifying the axis of movement where applicable (extracted from values in features.txt)

	X
	Y
	Z
	NA (not applicable)

mean: Mean value of the measurement (normalized)

	[-1, 1]
		
std: Standard deviation of the measurement (normalized)

	[-1, 1]

### II) Summary Data (step 5 output)

