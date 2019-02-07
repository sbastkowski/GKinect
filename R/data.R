prep_data <- function(samples, timepoints, mapping) {

  #Check if mapping is given
  if ( is.null(mapping) ) {
    my_preped_data = merge_multple_plates(samples)
    writeLines(c(strwrap("No samplenames or metadat supplied supplied. Continue with Well content and plate."),"\n"))
  } else {
    my_preped_data = merge_multiple_plates_and_mapping(samples, mapping)
  }
  return(my_preped_data)
}


set_timepoints (samples) {
  #Check or set timepoints
  temp_plate_data = read_xlsx(samples[1], sheet = 1)
  timepoints = length(temp_plate_data[1,] - 3)
    
  return(timepoints)
}

merge_multiple_plates(samples, timepoints){
  
  for (i in 1:length(samples)) {
    temp_plate_data = read_xlsx(samples[i], sheet = 1)
    temp_plate_data = temp_plate_data[-1,]
    if ((length(temp_plate_data[1,]) - 3) != timepoints) {
      writeLines(c(strwrap("Different number of timepoints supplied in sample files."),"\n", paste0("Number of timepoints in samplefile ", samples[i], " is ",(length(temp_plate_data[1,]) - 3) ), strwrap("Skipping to next input file."), "\n"))
    } else {
      Sample =  rep(" ", mode = "character", length = length(temp_plate_data$Content))
      for(j in 1:length(temp_plate_data$Content)) {
      Sample[i] = paste0(samples[i],"_", my_data$Content[i])
      }
      #add new names to table
      my_data = cbind(my_data, Sample)
      # add to all plates dataset
      my_data = rbind(my_data, temp_merged_data)
    }
   
  }
  return(my_data)
}

merge_multiple_plates_and_mapping(samples, mapping) {

  sheets = excel_sheets(mapping)
  check_ok = TRUE
  
  #Check if number of sheets is same as number of plates
  #Check if the names match
  if ( length(sheets) != length(samples) ) {
    writeLines(c(strwrap("Number of sheets in mapping does not match number of sample files (plates)."),"\n"))
    check_ok = FALSE
  }else {
    for (i in 1:length(sheets)) {
      if (is.null(samples[paste0(sheets[i], "xlsx")])) {
        writeLines(c(paste0("No sample file found for plate (plates).", sheets[i]) ,"\n"))
        check_ok = FALSE
      }
    }
  }
  if(check_ok) {
    for (i in 1:length(sheets)) {
       
      sheets = excel_sheets(mapping)
      temp_sheet_data = read_xlsx(mapping, sheet = sheets[i])
      temp_plate_data = read_xlsx(samples[paste0(sheets[i], "xlsx")], sheet = 1)
      temp_plate_data = temp_plate_data[-1,]
      if ((length(temp_plate_data[1,]) - 3) != timepoints) {
        writeLines(c(strwrap("Different number of timepoints supplied in sample files."),"\n", paste0("Number of timepoints in samplefile ", samples[i], " is ",(length(temp_plate_data[1,]) - 3) ), strwrap("Skipping to next input file."), "\n"))
      } else {
        # merge data (this assumes that both files are in same order)
        temp_merged_data = cbind(temp_plate_data,temp_sheet_data)
        # add to all plates dataset
        my_data = rbind(my_data, temp_merged_data)
       }
     }
   }
  
  return(my_data)

}
