source("plotUtilities.R")

plot4 <- function() {
    data <- readData()
    png("plot4.png")
    drawPlot4(data)
    dev.off()
}
