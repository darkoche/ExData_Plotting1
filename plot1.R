#Load sqldf library to read a portion of a large file
  library(sqldf)

#colClasses vector will be used to set classes to the data frame columns; the first two are character
  colClasses = c(rep("character", 2), rep("numeric", 7))

#read only the two dates in February, define a separator, header exists, set column classes
  consumption <- read.csv.sql("household_power_consumption.txt", 
                              sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                              sep = ";", header = TRUE, colClasses = colClasses)  
  
#create a histogram
  hist(consumption$Global_active_power, 
       col = "red", 
       main="Global Active Power", 
       xlab = "Global Active Power (kilowatts)")

#copy plot to png
  dev.copy(png, file="plot1.png")
  dev.off()