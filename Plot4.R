plot4 <- function (export_to_png = TRUE) {
  
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
  
  ## we change the plot layout to a 2x2 matrix
  par(mfrow = c(2,2))
  
  
  ##first graph (top left cell, Global ACtive Power by datetime)
  plot(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Global_active_power, type="l", lwd=1, ylab = "Global Active Power", xlab="")
  
  ##second graph (top right cell, Voltage by datetime)
  plot(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Voltage, type="l", lwd=1, ylab = "Voltage", xlab="datetime")
  
  ##third graph (bottom left cell, Submetering levels by datetime)
  plot(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_1, type="l", lwd=1, ylab = "Energy Sub Metering", xlab="")
  lines(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_2, lwd=1, col="red")
  lines(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Sub_metering_3,  lwd=1, col="blue")
  
    ## add the legend
    legend("topright", 
           lty=c(1,1),
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           bty = "n",
           cex = 0.8,
           text.width=100000
           
    )
  
  ## forth graph (bottom right cell, global reactive power by datetime)
  plot(strptime(paste(sub.power$Date, sub.power$Time), "%Y-%m-%d %H:%M:%S"), sub.power$Global_reactive_power, type="l", lwd=1, ylab = "global_reactive_power", xlab="datetime")
  
  
  ## copy to plot4.png file. The file is generated in 480x480 by default.
  if (export_to_png == TRUE) {
    dev.copy(png, file = "plot4.png") 
    dev.off() 
  }
}