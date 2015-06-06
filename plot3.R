#Load sqldf library to read a portion of a large file
  library(sqldf)

#colClasses vector will be used to set classes to the data frame columns; the first two are character
  colClasses = c(rep("character", 2), rep("numeric", 7))

#read only the two dates in February, define a separator, header exists, set column classes
  consumption <- read.csv.sql("household_power_consumption.txt", 
                              sql = "select * from file where Date in ('1/2/2007', '2/2/2007')",
                              sep = ";", header = TRUE, colClasses = colClasses)

#add another column 'datetime' which is a combination of Date and Time strings
  consumption$datetime = paste(consumption$Date, consumption$Time)

#convert 'datetime' into a Date/Time format
  consumption$datetime = strptime(consumption$datetime, "%d/%m/%Y %H:%M:%S")

#a plot is composed of three line charts; X axis is shared by all three
  X = consumption$datetime
  Y1 = consumption$Sub_metering_1
  Y2 = consumption$Sub_metering_2
  Y3 = consumption$Sub_metering_3
  
#create an empty plot with x and y labels
  with(consumption, plot(X, Y1, type="n", 
                         xlab="", ylab="Energy sub metering"))
  
#create three line charts
  with(consumption, lines(X, Y1, col = "black"))
  with(consumption, lines(X, Y2, col = "red"))
  with(consumption, lines(X, Y3, col = "blue"))
  
#add a legend  
  legend("topright", 
         lty = 1, 
         col = c("black", "red", "blue"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#copy plot to png
  dev.copy(png, file="plot3.png")
  dev.off()