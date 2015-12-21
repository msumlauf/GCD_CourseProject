## run_analysis.R
##
## Course Project
## Getting and Cleaning Data
##

library(dplyr)
library(tidyr)

## STEP 0: Prepare labels

# features
flab <- read.table("features.txt", stringsAsFactors=FALSE)[,2]
flab <- gsub("[-,]","_",flab)
flab <- gsub("(___)|(__)","_",flab)
flab <- gsub("_$","",flab)
flab <- gsub("BodyBody","Body",flab)
flab <- make.unique(flab)

# activities
alab <- read.table("activity_labels.txt")[,2]

## STEP 1: Merge the training and the test sets to create one data set
xtst <- read.table("test/x_test.txt", stringsAsFactors=FALSE)
xtrn <- read.table("train/x_train.txt", stringsAsFactors=FALSE)
ytst <- read.table("test/y_test.txt", stringsAsFactors=FALSE)
ytrn <- read.table("train/y_train.txt", stringsAsFactors=FALSE)

seg <- rep("test", nrow(xtst))
rid <- seq(1:nrow(xtst))
tst <- cbind(seg, rid, ytst, xtst)
seg <- rep("train", nrow(xtrn))
rid <- seq(1:nrow(xtrn))
trn <- cbind(seg, rid, ytrn, xtrn)

gcd <- rbind(tst, trn)
names(gcd) <- append(c("segment", "subject", "activity"), flab)

rm(xtst, xtrn, ytst, ytrn, seg, rid, tst, trn)

## STEP 2: Extract only the measurements on the mean and standard deviation
##         for each measurement
gcd <- select(gcd, 1:3, grep("([Mm]ean\\(\\))|([Ss]td\\(\\))", flab)+3)

## STEP 3: Use descriptive activity names to name the activities in the
##         data set
gcd <- mutate(gcd, activity=alab[activity])

## STEP 4: Appropriately label the data set with descriptive variable names
prsd <- as.data.frame(
          t(
            as.data.frame(
              lapply(strsplit(colnames(gcd[,4:ncol(gcd)]),"_"), function(x) x[1:3]),
              row.names=c("signal", "metric", "axis")
            )
          )
        )
prsd <- prsd %>% 
          mutate(
              metric = as.factor(gsub("\\(\\)","",metric)),
              domain = substr(signal,1,1),
              signal = as.factor(substr(signal,2,length(signal)))
          )
prsd$domain <- gsub("t", "time", prsd$domain)
prsd$domain <- gsub("f", "frequency", prsd$domain)
prsd$domain <- as.factor(prsd$domain)
prsd$component <- ifelse(grepl("^Body", prsd$signal),"body", ifelse(grepl("^Gravity", prsd$signal), "gravity",""))
prsd$instrument <- ifelse(grepl("Acc", prsd$signal), "accelerometer", ifelse(grepl("Gyro", prsd$signal), "gyroscope", ""))
prsd$jerk.signal <- ifelse(grepl("Jerk", prsd$signal), "yes", "no")
prsd$magnitude <- ifelse(grepl("Mag", prsd$signal), "yes", "no")
prsd$varname <- colnames(gcd[,4:ncol(gcd)])
gcd <- gcd %>%
         gather(varname, value, 4:ncol(gcd)) %>%
         mutate(varname = as.character(varname)) %>%
         inner_join(prsd, gcd, by=c("varname")) %>%
         select(segment:activity, domain, component, instrument, jerk.signal, magnitude, axis, metric, value) %>%
         spread(metric, value)

## STEP 5: From the data set in step 4, create a second, independent tidy data set
##         with the average of each variable for each activity and each subject
gcd_bysubact <- gcd %>% group_by(activity, segment, subject) %>% summarize(average_mean = mean(mean), average_std = sd(std))

## Create output file
write.table(gcd_bysubact, file="gcd_bysubact.txt", quote=FALSE, sep="\t", row.name=FALSE)
