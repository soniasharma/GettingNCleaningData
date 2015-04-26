"
# README

##Purpose

   This repository is created for a course project for the course "Getting and Cleaning Data"  to demonstrate the ability to collect, work with, and clean a data set. 

##Goal
   The goal is to prepare tidy data that can be used for later analysis. 

##Information about the data
   The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

   The link to the raw data for the project: 

   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

##Files in the repository

1. run_analysis.R
   R script for the steps taken in the analysis to obtain the tidy data from the raw data

2. TidyData.txt

   This file contains the tidy data (14220 x 4)  obtained from the raw data by running run_analysis.R when the raw data is the working directory. 

3. CodeBook.txt

  * This file contains a description of all the variables in the tidy data set. The variables are arranged in the order they appear in the tidy data set.   

  * The descriptive variable names for the features are obtained from the original features.txt file in the raw data by removing special characters like "-", "()" and multiple substitutions replacing "Acc","Body","Freq", "Gravity","Gyro", "Jerk", "Mag", "mean" with shorter yet descriptive strings "acc", "bdy", "freq","gr","gy","jk","mag", "mu", respectively.


  
