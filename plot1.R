source("plotUtilities.R")

plot1 <- function() {
    data <- readData()
    png("plot1.png")
    drawPlot1(data)
    dev.off()
}
