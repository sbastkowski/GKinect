prep_data <- function(samples, mapping, timepoints) {



  #Check if mapping is given
  if ( is.null(mapping) ) {
    for(i in 1:length(samples)) {
      for(j in 1:length(my_data$Content)) {
        samplenames[i] = paste0(samples[i],"_", my_data$Content[i])
      }
    }
    writeLines(c(strwrap("No samplenames or metadat supplied supplied. Continue with Well content and plate."),"\n"))
  } else {



  }



  #Check or set timepoints
  if ( is.null(timepoints) ) {
    timepoints = length(my_data[1,] - 3)
    writeLines(c(strwrap("No number of timepoints supplied. Using all supplied."),"\n"))
  } else {
    timepoints = opt$timepoints
  }

  my_preped_data = cbind(samplenames, my_data[,4:(3 + timepoints)])

  return(my_preped_data)
}

merge_multiple_plates(samples, mapping){

  for (i in 1:length(sheets)) {
    sheets = excel_sheets(mapping)
    temp_sheet_data = read_xlsx(mapping, sheet = sheets[i])
    temp_plate_data = read_xlsx(samples[paste0(sheets[i], "xlsx")], sheet = 1)
    temp_plate_data = temp_plate_data[-1,]
    # merge data (this assumes that both files are in same order)
    temp_merged_data = cbind(temp_plate_data,temp_sheet_data)
    # add to all plates dataset
    my_data = rbind(my_data, temp_merged_data)
  }

}
