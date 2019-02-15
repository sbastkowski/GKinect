# GKinect

A set of tools to analyse and plot the output from a BMG FLUOStar OMEGA plate reader.  


## Contents
  * [Introduction](#introduction)
  * [Installation](#installation)
    * [Required dependencies](#required-dependencies)
  * [Usage](#usage)
    * [Scripts](#scripts)
  * [License](#license)
  * [Feedback/Issues](#feedbackissues)
  * [Citation](#citation)

## Introduction 
The GKinect is an R package to analyse and plot the optical density values from a BMG FLUOStar OMEGA plate reader. 

## Installation

install.packages("GKinect")


## Usage

Command-line usage instructions:

./plotGrowthCurve.R [-h] --samples <sample1.xlsx sample2.xlsx ... sampleN.xlsx> -p <outplot.pdf> [-t timepoints]

Required:
--samples : 'samplesheet(s) containing growth values for each well (eg. condition, mutant ect.). Input can be multiple files. If no mapping is supplied they will be additionally labelled by filename in the output plot.
-p : output filename for growth curve plots.
Optional:
-t : number of time points meassured.
-m : mapping filename that links actual samplenames to well content names.

./combineData.R --samples <sample1.xlsx sample2.xlsx ... sampleN.xlsx> --mapping <mapping.xlsx> 
Required:
--samples : 'samplesheet(s) containing growth values for each well (eg. condition, mutant ect.).
-m : mapping filename that links actual samplenames to well content names.Input can be multiple files. 
Optional:
-t : number of time points meassured.
-o : output filename (csv file extention).


Please see examples of input format in Data folder. It ids important that the headers in the mapping file are identical to supplied example "metadata.xlsx". It is also important that the tabs/sheets of the metadata file are labelled by the names (without extention) of the raw data file (samples). 

### Scripts
Executable scripts to carry out most of the listed functions are available in the `bin`:

* `combineData.R` - Generates a csv file containing all merged sample files and discription provided in mapping file.
* `plotGrowthCurve.R` - Generates a pdf containing growth curve plots for each sample.

A help menu for each script can be accessed by running the script with -h.

## License
GKinect is free software, licensed under [GPLv3](https://github.com/sbastkowski/GKinect/blob/master/software_license).

## Feedback/Issues
Please report any issues to the [issues page](https://github.com/sbastkowski/GKinect/issues) or email sarah.bastkowski@quadram.ac.uk

