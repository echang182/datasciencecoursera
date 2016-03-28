# Leo los archivos de prueba
test1<- read.table("y_test.txt")
test2<- read.table("X_test.txt")
test3<- read.table("subject_test.txt")
# Genero un unico data frame y elimino el resto
test<- data.frame(test3,test1, test2)
rm(test1)
rm(test2)
rm(test3)

# Leo los archivos de entrenamiento
train1<- read.table("y_train.txt")
train2<- read.table("X_train.txt")
train3<- read.table("subject_train.txt")
# Genero un unico data frame y elimino el resto
train<- data.frame(train3,train1, train2)
rm(train1)
rm(train2)
rm(train3)

#-- Merges the training and the test sets to create one data set.
datos<- rbind(test,train)

#--Extracts only the measurements on the mean and standard deviation for each measurement.
v<- numeric(length = 68)
v[1:2]<- c(1,2)
k<-3
for (i in 1:33){
    v[k]<- 3 + (i-1)*17
    k<- k+1
    v[k]<- 4 + (i-1)*17
    k<- k+1
}
datos<- datos[,v]
rm(v)

#-- Uses descriptive activity names to name the activities in the data set
datos$Activity<- as.character(datos$Activity)
datos$Activity<- sub("1","Walking", datos$Activity)
datos$Activity<- sub("2","WalkingUpstairts", datos$Activity)
datos$Activity<- sub("3","WalkingDownstairs", datos$Activity)
datos$Activity<- sub("4","Sitting", datos$Activity)
datos$Activity<- sub("5","Standing", datos$Activity)
datos$Activity<- sub("6","Laying", datos$Activity)

#-- Appropriately labels the data set with descriptive variable names.
names(datos)<- c("Subject", "Activity","Mean_tBodyacc_x","Std_tbodyacc_x",
                 "Mean_tbodyacc_y","Std_tbodyacc_y","Mean_tbodyacc_z",
                 "Std_tbodyacc_z","Mean_tGravityAcc_x","Std_tGravityAcc_x",
                 "Mean_tGravityAcc_y","Std_tGravityAcc_y","Mean_tGravityAcc_z",
                 "Std_tGravityAcc_z","Mean_tBodyAccJerk_x","Std_tBodyAccJerk_x",
                 "Mean_tBodyAccJerk_y","Std_tBodyAccJerk_y","Mean_tBodyAccJerk_z",
                 "Std_tBodyAccJerk_z","Mean_tBodyGyro_x","Std_tBodyGyro_x",
                 "Mean_tBodyGyro_y","Std_tBodyGyro_y","Mean_tBodyGyro_z",
                 "Std_tBodyGyro_z","Mean_tBodyGyroJerk_x","Std_tBodyGyroJerk_x",
                 "Mean_tBodyGyroJerk_y","Std_tBodyGyroJerk_y","Mean__tBodyGyroJerk_z",
                 "Std_tBodyGyroJerk_z","Mean_tBodyAccMag", "Std_tBodyAccMag",
                 "Mean_tGravityAccMag","Std_tGravityAccMag","Mean_tBodyAccJerkMag",
                 "Std_tBodyAccJerkMag","MeantBodyGyroMag","Std_tBodyGyroMag",
                 "Mean_tBodyGyroJerkMag","Std_tBodyGyroJerkMag","Mean_fBodyAcc_x",
                 "Std_fBodyAcc_x","Mean_fBodyAcc_y","Std_fBodyAcc_y",
                 "Mean_fBodyAcc_z","Std_fBodyAcc_z","mean_fBodyAccJerk_x",
                 "Std_fBodyAccJerk_x","Mean_fBodyAccJerk_y","Std_fBodyAccJerk_y",
                 "Mean_fBodyAccJerk_z","Std_fBodyAccJerk_z","Mean_fBodyGyro_x",
                 "Std_fBodyGyro_x","Mean_fBodyGyro_y","Std_fBodyGyro_y",
                 "Mean_fBodyGyro_z","Std_fBodyGyro_z","Mean_fBodyAccMag",
                 "Std_fBodyAccMag","Mean_fBodyAccJerkMag","Std_fBodyAccJerkMag",
                 "Mean_fBodyGyroMag","Std_fBodyGyroMag","Mean_fBodyGyroJerkMag",
                 "Std_fBodyGyroJerkMag")

#-- From the data set in step 4, creates a second, independent tidy data set 
#   with the average of each variable for each activity and each subject.

temp1<- matrix(nrow = 6,ncol = 66)
temp2<- matrix(nrow = 30,ncol = 66)
for (i in 3:68){
    temp1[,i-2]<- tapply(datos[,i],datos$Activity,mean)
    temp2[,i-2]<- tapply(datos[,i],datos$Subject,mean)
}
temp<- rbind(temp1,temp2)
rm(temp1)
rm(temp2)
V<- character(length = 36)
V[1:6]<- unique(datos$Activity)
V[7:36]<- as.character(unique(datos$Subject))
datos2<- data.frame(V,temp)
names(datos2)<- c("Activity/subject","Mean_tBodyacc_x","Std_tbodyacc_x",
                  "Mean_tbodyacc_y","Std_tbodyacc_y","Mean_tbodyacc_z",
                  "Std_tbodyacc_z","Mean_tGravityAcc_x","Std_tGravityAcc_x",
                  "Mean_tGravityAcc_y","Std_tGravityAcc_y","Mean_tGravityAcc_z",
                  "Std_tGravityAcc_z","Mean_tBodyAccJerk_x","Std_tBodyAccJerk_x",
                  "Mean_tBodyAccJerk_y","Std_tBodyAccJerk_y","Mean_tBodyAccJerk_z",
                  "Std_tBodyAccJerk_z","Mean_tBodyGyro_x","Std_tBodyGyro_x",
                  "Mean_tBodyGyro_y","Std_tBodyGyro_y","Mean_tBodyGyro_z",
                  "Std_tBodyGyro_z","Mean_tBodyGyroJerk_x","Std_tBodyGyroJerk_x",
                  "Mean_tBodyGyroJerk_y","Std_tBodyGyroJerk_y","Mean__tBodyGyroJerk_z",
                  "Std_tBodyGyroJerk_z","Mean_tBodyAccMag", "Std_tBodyAccMag",
                  "Mean_tGravityAccMag","Std_tGravityAccMag","Mean_tBodyAccJerkMag",
                  "Std_tBodyAccJerkMag","MeantBodyGyroMag","Std_tBodyGyroMag",
                  "Mean_tBodyGyroJerkMag","Std_tBodyGyroJerkMag","Mean_fBodyAcc_x",
                  "Std_fBodyAcc_x","Mean_fBodyAcc_y","Std_fBodyAcc_y",
                  "Mean_fBodyAcc_z","Std_fBodyAcc_z","mean_fBodyAccJerk_x",
                  "Std_fBodyAccJerk_x","Mean_fBodyAccJerk_y","Std_fBodyAccJerk_y",
                  "Mean_fBodyAccJerk_z","Std_fBodyAccJerk_z","Mean_fBodyGyro_x",
                  "Std_fBodyGyro_x","Mean_fBodyGyro_y","Std_fBodyGyro_y",
                  "Mean_fBodyGyro_z","Std_fBodyGyro_z","Mean_fBodyAccMag",
                  "Std_fBodyAccMag","Mean_fBodyAccJerkMag","Std_fBodyAccJerkMag",
                  "Mean_fBodyGyroMag","Std_fBodyGyroMag","Mean_fBodyGyroJerkMag",
                  "Std_fBodyGyroJerkMag")
                  
# Escribo datos2 en un archivo de salida
write.table(datos2, file = "GandCdata.txt",row.names = FALSE)
