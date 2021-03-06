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

The variable names in features.txt are decomposed into six separate variables that uniquely describe a feature: domain, component, instrument, jerk.signal, magnitude, and axis.  The input data contains numerous measurements associated with each feature, but for this exercise we discard all but the mean and standard deviation (labelled "mean()" and "std()" in the feature name).  The test and train segments are appended and subsequently marked by a unique segment identifier.  The predictor variables (x) and response variables (y) are then joined by segment and subject.  The detailed feature identifiers and activity labels are then added to create the master dataset.  In the final step, the master data set is aggregated by activity, segment, and subject, and simple statistics are calculated.

## Code Book

Layout information for the two tidy data sets produced by this project.  Each variable is presented in the same sequence in which it appears in the data set.  The variable name is followed by a brief description, below which is the variable's domain (all possible values if categorical, and the observed range if numeric).

### gcd (step 4 output)

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

### gcd_bysubact (step 5 output)

This data set aggregates the master data set (gcd) by activity, segment, and subject.  A simple average is computed for each of the two value fields (mean and std).

activity: The actual activity being performed by the subject when measurements were taken (6 options)

	LAYING
	SITTING
	STANDING
	WALKING
	WALKING_DOWNSTAIRS
	WALKING_UPSTAIRS

segment: Identifies whether the record came from a "test" or "train" file

	test		
	train

subject: Subject ID within the Segment (Segment and Subject fields are both required to identify a unique subject)

	[1, 7352]
		
average_mean: Straight average of the mean values, taken over all measurements for a given activity, segment, and subject ID

	[-0.6028219, 0.5079439]

average_std:  Straight average of the standard deviation values, taken over all measurements for a given activity, segment, and subject ID

	[0.001339298, 0.6465009]
