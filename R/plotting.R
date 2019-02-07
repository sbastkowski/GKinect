prep_data <- function(samples) {

  growth = read.csv(samples, header = TRUE)

  #remove any duplicates
  uniqueSamples = unique(growth$samplename)
  for(i in 1:length(uniqueSamples)){
    growth=growth[!(as.character(growth$samplename)==uniqueSamples[i]),]
  }
  if ( is.null(opt$timepoints ) ) {
    opt$timepoints = length(growth[1,])
    writeLines(c(strwrap("No number of timepoints supplied. Assuming number of columns will be number of timepoints"),"\n"))
  }

}


plot_growth <- function(sample, timepoints, outputplot) {

  growth <- prep_data(sample)

  for (i in 1:length(growth$samplename)){

    sampleGrowth=growth
    row.names(sampleGrowt)=sampleGrowt$samplename
    sampleGrowth=sampleGrowth[,-1]
    if(length(sampleGrowth[,1])!=0){
      df=NULL
      for(i in 1:length(sub[1,])){
        temp_df <- data.frame(x=1:24, y=sub[,i], name=rep(colnames(sub)[i], each=24), color = rep(ifelse(grepl("BW",colnames(sub)[i], fixed=TRUE), 'red', 'blue'), each=24))
        df <- rbind(df,temp_df)
      }
      growthplate=append(growthplate,list(ggplot(df,aes(x=x,y=y,group=name,colour=color)) + theme(legend.position="none") + geom_point(data = subset(df, !grepl(glob2rx("*BW*"), df$name))) + geom_line() + labs(title=paste0(allGenes[j]," on plate ",platetype[k], " at concentration ", concentration[t]), x ="Time in h", y = "Growth rate")))
      #ggsave(file=paste0(allGenes[j],platetype[k],concentration[t],".pdf"), ggplot(df,aes(x=x,y=y,group=name,colour=factor(name))) + geom_point(data = subset(df, !grepl(glob2rx("*BW*"), df$name))) + geom_line() + labs(title=paste0(allGenes[j]," on plate ",platetype[k], " at concentration "), x ="Time in h", y = "Growth rate"))
    }else{
      sub1=cbind(t(subset(subO,subO$BioReplicate=="Odd")[2:25]), t(BW[,2:25]))
      df1=NULL
      for(i in 1:length(sub1[1,])){
        temp_df1 <- data.frame(x=1:24, y=sub1[,i], name=rep(colnames(sub1)[i], each=24), color = rep(ifelse(grepl("BW",colnames(sub1)[i], fixed=TRUE), 'red', 'blue'), each=24))
        df1 <- rbind(df1,temp_df1)
      }

      sub2=cbind(t(subset(subO,subO$BioReplicate=="Even")[,2:25]), t(BW[,2:25]))
      df2=NULL
      for(i in 1:length(sub2[1,])){
        temp_df2 <- data.frame(x=1:24, y=sub2[,i], name=rep(colnames(sub2)[i], each=24), color = rep(ifelse(grepl("BW",colnames(sub2)[i], fixed=TRUE), 'red', 'blue'), each=24))
        df2 <- rbind(df2,temp_df2)

      }

      growthplots=append(growthplots,list(ggplot(df1,aes(x=x,y=y,group=name,colour=color)) + theme(legend.position="none") + geom_point(data = subset(df1, !grepl(glob2rx("*BW*"), df1$name))) + geom_line() + labs(title=paste0(allGenes[j]," on plate ",platetype[k], "Odd" , " at concentration ", concentration[t]), x ="Time in h", y = "Growth rate")))

    }

  }
  # Arrange them on A4 and write them to pdf
  multiPageGrobs <- marrangeGrob(grobs = growthplots, nrow=2, ncol=2)
  ggsave(file = paste0(outputplot, ".pdf"), multiPageGrobs, width = 8.27, height = 11.69, unit = "in")

}
