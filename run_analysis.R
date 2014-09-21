
## Set your working directory below

setwd("G:\\Data Science\\Extractingdata\\data\\UCI HAR Dataset");

## Merge Trainng and Test data sets below

train_x <- read.table("train/X_train.txt",header=F);
train_y <- read.table("train/Y_train.txt",header=F);
test_x <- read.table("test/X_test.txt",header=F);
test_y <- read.table("test/Y_test.txt",header=F);
sub_test <- read.table("test/subject_test.txt",header=F);
sub_train <- read.table("train/subject_train.txt",header=F);
activity_names <-read.table("activity_labels.txt");

combine_x <- rbind(train_x,test_x);
combine_y <- rbind(train_y,test_y);
sub_total <- rbind(sub_train,sub_test);



## Filter columns in X
column_filter <- c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227,228,253,254,266:271,294:296,345:350,373:375,424:429,452:454,503,504,516,517
                   ,529,530,539,542,543,552);
column_names <- c('TBODY_ACC_MEAN_X','TBODY_ACC_MEAN_Y','TBODY_ACC_MEAN_Z','TBODY_ACC_STD_X','TBODY_ACC_STD_Y','TBODY_ACC_STD_Z'
                 ,'TGRAVITY_ACC_MEAN_X','TGRAVITY_ACC_MEAN_Y','TGRAVITY_ACC_MEAN_Z','TGRAVITY_ACC_STD_X','TGRAVITY_ACC_STD_Y','TGRAVITY_ACC_STD_Z'
                 ,'TBODY_ACC_JERK_MEAN_X','TBODY_ACC_JERK_MEAN_Y','TBODY_ACC_JERK_MEAN_Z','TBODY_ACC_JERK_STD_X','TBODY_ACC_JERK_STD_Y','TBODY_ACC_JERK_STD_Z'
                 ,'TBODY_GYRO_MEAN_X','TBODY_GYRO_MEAN_Y','TBODY_GYRO_MEAN_Z','TBODY_GYRO_STD_X','TBODY_GYRO_STD_Y','TBODY_GYRO_STD_Z'
                 ,'TBODY_GYRO_JERK_MEAN_X','TBODY_GYRO_JERK_MEAN_Y','TBODY_GYRO_JERK_MEAN_Z','TBODY_GYRO_JERK_STD_X','TBODY_GYRO_JERK_STD_Y'
                 ,'TBODY_GYRO_JERK_STD_Z','TBODY_ACC_MAG_MEAN','TBODY_ACC_MAG_STD','TGRAVITY_ACC_MAG_MEAN','TGRAVITY_ACC_MAG_STD','TBODY_ACC_JERK_MEAN','TBODY_ACC_JERK_STD'
                 ,'TBODY_GYRO_JERK_MAG_MEAN','TBODY_GYRO_JERK_MAG_STD','FBODY_ACC_MEAN_X','FBODY_ACC_MEAN_Y','FBODY_ACC_MEAN_Z'
                 ,'FBODY_ACC_STD_X','FBODY_ACC_STD_Y','FBODY_ACC_STD_Z','FBODY_ACC_FREQ_MEAN_X','FBODY_ACC_FREQ_MEAN_Y','FBODY_ACC_FREQ_MEAN_Z'
                 ,'FBODY_ACC_JERK_MEAN_X','FBODY_ACC_JERK_MEAN_Y','FBODY_ACC_JERK_MEAN_Z','FBODY_ACC_JERK_STD_X','FBODY_ACC_JERK_STD_Y','FBODY_ACC_JERK_STD_Z'
                 ,'FBODY_ACC_JERK_FREQ_MEAN_X','FBODY_ACC_JERK_FREQ_MEAN_Y','FBODY_ACC_JERK_FREQ_MEAN_Z'                 
                 ,'FBODY_GYRO_MEAN_X','FBODY_GYRO_MEAN_Y','FBODY_GYRO_MEAN_Z','FBODY_GYRO_STD_X','FBODY_GYRO_STD_Y','FBODY_GYRO_STD_Z'
                 ,'FBODY_GYRO_FREQ_MEAN_X','FBODY_GYRO_FREQ_MEAN_Y','FBODY_GYRO_FREQ_MEAN_Z','FBODY_ACC_MAG_MEAN','FBODY_ACC_MAG_STD'
                 ,'FBODY_ACC_JERK_MAG_MEAN','FBODY_ACC_JERK_MAG_STD','FBODY_GYRO_MAG_MEAN','FBODY_GYRO_MAG_STD','FBODY_GYRO_MAG_FREQ_MEAN'
                 ,'FBODY_GYRO_JERK_MAG_MEAN','FBODY_GYRO_JERK_MAG_STD','FBODY_GYRO_JERK_MAG_FREQ_MEAN');

filtered_x <- combine_x[,column_filter];

## Create activity data with activity name as column value
activity_data <- data.frame(cut(combine_y[,1],breaks=6,labels=activity_names[,2]));

## Changing column names
names(filtered_x) <- c(column_names);
names(sub_total) <- c("Subject");
names(activity_data) <- c("Activity");

##Prepare Tidy Data

tidy_data <- cbind(sub_total,activity_data,filtered_x);






## Prepare second data set based on Tidy Data

dim_tidy <- dim(tidy_data);


for(i in 3:dim_tidy[2]-2) {
 
    print(i)
  tmpData <- aggregate(tidy_data[i+2],by=tidy_data[c("Subject","Activity")],FUN=mean);  
  if(i==1) {
    res_data <- tmpData[,1:2];
    
  }
  
  res_data <- cbind(res_data,tmpData[,3]);
  
}
colnames(res_data) <- colnames(tidy_data);


## Prepare Final Output below

write.table(res_data,file="tidayData.txt",row.names=FALSE);











