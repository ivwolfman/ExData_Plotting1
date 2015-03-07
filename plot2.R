source("plotUtilities.R")

plot2 <- function() {
    data <- readData()
    png("plot2.png")
    par(mar = c(3.1, 4.1, 2.1, 2.1))
    drawPlot2(data)
    dev.off()
}
