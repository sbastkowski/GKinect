plot_growth <- function(sampleGrowth, timepoints) {

  
  if(!require(lattice)){install.packages("lattice", repos = "http://cran.us.r-project.org")}
  library(lattice)
  if(!require(gridExtra)){install.packages("gridExtra", repos = "http://cran.us.r-project.org")}
  library(gridExtra)
  if(!require(ggplot2)){install.packages("ggplot2", repos = "http://cran.us.r-project.org")}
  library(ggplot2)

  
  growthplots=list()
  for (i in 1:length(sampleGrowth[,1])){
    df=NULL
    df <- data.frame(x=1:timepoints, y=as.vector(t(sampleGrowth[i,4:(timepoints+3)])), name=rep(sampleGrowth$Gene[i], each=timepoints), color = rep('red', each=timepoints))
    growthplots=append(growthplots,list(ggplot(df,aes(x=x,y=y,group=name,colour=color)) + geom_line() + labs(title=paste0(sampleGrowth$Gene[i]," on plate ",sampleGrowth$Plate[i], " in concentration ", sampleGrowth$Concentration), x ="Time in h", y = "Growth rate")))

  }
  # Arrange them on A4 and write them to pdf
  multiPageGrobs <- marrangeGrob(grobs = growthplots, nrow=2, ncol=2)
  return(multiPageGrobs)

}
