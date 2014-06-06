plot3 <- function (export_to_png = TRUE) {
  
  ## Date: 2014-06-06
  
  ## The txt file household_power_consumption.txt has to be present in the working directory
  ## This file is not available in this git repository, you can download it from:
  ## 
  ## https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
  
  
  ## We load the data if the sub.power data set is empty (this is just for dev purposes)
  
  if (is.null(sub.power)) {
    power <- read.table("household_power_consumption.txt", na.strings = "?", sep=";", header=TRUE)
    
    ## we subset the dates for 2007-02-01 and 2007-02-02 into sub.power frame
    
    get.rows <- power$Date == "2007-02-01" | power$Date == "2007-02-02"
    sub.power <- power[get.rows,]
  }
  
  ## Restart the graph layout in case has been changed
  par(mfrow = c(1,1))  
  
  ## plot the line graphs
  ## we have to convert the concatenation of date and time into timestamps using strptime function
  ## the format is %Y-%m-%d %H:%M:%S
  
  ## first we plot one line and then the others, finally the legend
  
  plot(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_1, type="l", lwd=1, ylab = "Energy Sub Metering", xlab="")
  lines(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_2, lwd=1, col="red")
  lines(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_3,  lwd=1, col="blue")
  
  ## add the legend
  legend("topright", 
         lty=c(1,1),
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col=c("black", "red", "blue"),
         text.width=65000
         )
  
  ## copy to plot3.png file. The file is generated in 480x480 by default.
  if (export_to_png == TRUE) {
    dev.copy(png, file = "plot3.png") 
    dev.off() 
  }
}