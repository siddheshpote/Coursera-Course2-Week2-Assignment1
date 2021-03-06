# Part 1: 
# Write a function named 'pollutantmean' that calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
# The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
        
# Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 
# 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.


# My Solution: although the structure of my code differs slightly from the assignment's prototype function example, it runs perfectly fine.

## Create a function that can combine all .csv files in "specdata" folder together into one data frame (using rbind):
## Since all columns in each csv file are the same, use rbind to combine the files by rows.

multmerge <- function(path){
        filenames <- list.files(path="C:/.../", full.names = TRUE)              ## insert "path" to your specdata file.
        datalist <- lapply(filenames, function(x){read.csv(file=x,header=TRUE)})
        Reduce(function(x,y) {rbind(x,y)}, datalist)
}


## Store combined data into "combined_data":

combined_data <- multmerge("C:/.../")           ## insert "path" to your specdata file here


## Drop all missing or "NA" values in combined data, and store in "airdata":

airdata <- na.omit(combined_data)


## Create function pollutantmean:

pollutantmean <- function(directory, pollutant, id1, id2) {
        directory <- airdata    
   ## since I have already rbind all csv files into one data frame, I set my directory to that data frame.
   ## having 'id1' and 'id2' in the function allows R to calculate the mean of a specified range of id monitors.
        
        ## First, Subset the data by ID, and then complete function with the if function:
        
        id_data <- subset(airdata, airdata$ID >= id1 & airdata$ID <= id2)
        
        if(pollutant == "sulfate") {
                result <- mean(id_data$sulfate)
        } else {
                result <- mean(id_data$nitrate)
        }
        result
}


## Testing our function to see if it works:

> pollutantmean(airdata, "sulfate", 1, 10)
[1] 4.064128

> pollutantmean(airdata, "nitrate", 70, 72)
[1] 1.732979

> pollutantmean(airdata, "nitrate", 23, 23)
[1] 1.280833
