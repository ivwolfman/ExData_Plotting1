source("plotUtilities.R")

plot3 <- function() {
    data <- readData()
    png("plot3.png")
    par(mar = c(3.1, 4.1, 2.1, 2.1))
    drawPlot3(data)
    dev.off()
}
