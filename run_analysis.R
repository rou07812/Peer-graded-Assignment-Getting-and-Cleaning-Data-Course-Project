#load libraries
library(data.table)
library(dplyr)
setwd(".\\R\\data\\UCI HAR Dataset")

##Read supporting
featureNames <- read.table(".\\features.txt")
activityLabels <- read.table(".\\activity_labels.txt", header = FALSE)
#read Training and Test sets
subjTrain <- read.table(".\\train\\subject_train.txt", header = FALSE)
actvTrain <- read.table(".\\train\\y_train.txt", header = FALSE)
featTrain <- read.table(".\\train\\X_train.txt", header = FALSE)

subjTest <- read.table(".\\test\\subject_test.txt", header = FALSE)
actvTest <- read.table(".\\test\\y_test.txt", header = FALSE)
featTest <- read.table(".\\test\\X_test.txt", header = FALSE)

#Merge Training and Test data sets
subjMerge <- rbind(subjTrain,subjTest)
actvMerge <- rbind(actvTrain,actvTest)
featMerge <- rbind(featTrain,featTest)

#Name columns
colnames(subjMerge) <- "Subject"
colnames(actvMerge) <- "Activity"
colnames(featMerge) <- t(featureNames[2])

#create completed Data Frame
completedData <- cbind(featMerge,actvMerge,subjMerge)

#extract mean and std dev
columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completedData), ignore.case=TRUE)
requiredColumns <- c(columnsWithMeanSTD,562,563)
extractedData <- completedData[,requiredColumns]

#name activities in dataset #1 = WALKING etc...
extractedData$Activity <- as.character(extractedData$Activity)
for (x in 1:6){
        extractedData$Activity[extractedData$Activity == x] <- as.character(activityLabels[x,2])
}
extractedData$Activity <- as.factor(extractedData$Activity)

#rename variable names
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))

#create tidy data set
extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "TidyData.txt", row.names = FALSE)