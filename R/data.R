prep_data <- function(samples, timepoints, mapping) {

  if(!require(openxlsx)){install.packages("openxlsx", repos = "http://cran.us.r-project.org")}
  library("openxlsx")
  #Check if mapping is given
  if ( is.null(mapping) ) {
    my_preped_data = merge_multiple_plates(samples, timepoints)
    writeLines(c(strwrap("No samplenames or metadat supplied supplied. Continue with Well content and plate."),"\n"))
  } else {
    my_preped_data = merge_multiple_plates_and_mapping(samples, mapping)
  }
  return(my_preped_data)
}


set_timepoints <- function(samples) {
  #Check or set timepoints
  temp_plate_data = read.xlsx(samples[[1]][1], sheet = 1)
  timepoints = length(temp_plate_data[1,]) - 4
    
  return(timepoints)
}

merge_multiple_plates <- function(samples, timepoints){
  
  for (i in 1:length(samples[[1]])) {
    temp_plate_data = read.xlsx(samples[[1]][i], sheet = 1)
    temp_plate_data = temp_plate_data[-1,]
   
    if ((length(temp_plate_data[1,]) - 4) != timepoints) {
      writeLines(c(strwrap("Different number of timepoints supplied in sample files."),"\n", paste0("Number of timepoints in samplefile ", samples[i], " is ",(length(temp_plate_data[1,]) - 3) ), strwrap("Skipping to next input file."), "\n"))
    } else {
      Sample =  rep(" ", mode = "character", length = length(temp_plate_data$Content))
      for(j in 1:length(temp_plate_data$Content)) {
      Sample[i] = paste0(samples[[1]][i],"_", my_data$Content[i])
      }
      #add new names to table
      my_data = cbind(my_data, Sample)
      # add to all plates dataset
      my_data = rbind(my_data, temp_merged_data)
    }
   
  }
  return(my_data)
}

merge_multiple_plates_and_mapping <- function (samples, mapping) {

  sheets = getSheetNames(mapping)

  #Check if number of sheets is same as number of plates
  #Check if the names match
  if ( length(sheets) != length(samples[[1]]) ) {
    writeLines(c(strwrap("Number of sheets in mapping does not match number of sample files (plates)."),"\n"))
    q(status=1);
  }else {
    for (i in 1:length(sheets)) {
      temp_sample = strsplit(samples[[1]][i], "/")
      temp_sample_name = temp_sample[[1]][length(temp_sample[[1]])]
      temp_sample_name_without_xlsx = strsplit(temp_sample_name[[1]], ".xlsx")[[1]][1]
      if (is.null(sheets[temp_sample_name_without_xlsx])) {
        writeLines(c(paste0("No sample file found for plate (plates).", sheets[i]) ,"\n"))
        q(status=1);
      }
    }
  }

    my_data = NULL
    for (i in 1:length(sheets)) {
       
      temp_sheet_data = read.xlsx(mapping, sheet = sheets[i], colNames = TRUE)
      temp_plate_data = read.xlsx(samples[[1]][i], sheet = 1)
      temp_plate_data = temp_plate_data[-1,]
      if ((length(temp_plate_data[1,]) - 4) != timepoints) {
        writeLines(c(strwrap("Different number of timepoints supplied in sample files."),"\n", paste0("Number of timepoints in samplefile ", samples[i], " is ",(length(temp_plate_data[1,]) - 3) ), strwrap("Skipping to next input file."), "\n"))
      } else {
        # merge data (this assumes that both files are in same order)
        temp_merged_data = cbind(temp_plate_data,temp_sheet_data)
        # add to all plates dataset
        my_data = rbind(my_data, temp_merged_data)
       }
     }
   
  
  return(my_data)

}
