# Set Library plyr

library(plyr)

# Read X_train.txt, Y_train.txt and subject_train.txt

train_x <- read.table("projectassignment3/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("projectassignment3/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("projectassignment3/UCI HAR Dataset/train/subject_train.txt")

# Read X_text.txt, Y_text.txt and subject_test.txt

test_x <- read.table("projectassignment3/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("projectassignment3/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("projectassignment3/UCI HAR Dataset/test/subject_test.txt")

# Bind X_train.txt and X_test.txt
xdata <- rbind(train_x, test_x)

# Bind Y_train.txt and Y_test.txt
ydata <- rbind(train_y, test_y)

# Bind subject_train.txt and subject_test.txt
subjectdata <- rbind(train_subject, test_subject)

# Read features.txt


features <- read.table("projectassignment3/UCI HAR Dataset/features.txt")

# mean() an std() col name filter
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
#mean_and_std <- grep("-(std)\\(\\)", mean_and_std)


xdata <- xdata[, mean_and_std]



# Read activity_labels.txt

activities <- read.table("projectassignment3/UCI HAR Dataset/activity_labels.txt")


ydata[, 1] <- activities[ydata[, 1], 2]



#Column names assignment

names(ydata) <- "activity"
names(xdata) <- features[mean_and_std, 2]
names(subjectdata) <- "subject"

# binding of all data
all_data <- cbind(xdata, ydata, subjectdata)

#Avarage calculation.Total 68 column excluding last 2 activity and subject
avg_data <- ddply(all_data, .(subject, activity), function(x) colMeans(x[,1:66]))

#output Avarage table
write.table(avg_data, "avg_data.txt", row.name=FALSE)