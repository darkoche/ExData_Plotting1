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

#create a plot  
  plot(consumption$datetime, consumption$Global_active_power, type="n", 
       xlab="", ylab="Global active power (kilowatts)")
  lines(consumption$datetime, consumption$Global_active_power)

#copy plot to png
  dev.copy(png, file="plot2.png")
  dev.off()