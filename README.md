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
The Bio::TraDIS pipeline provides software utilities for the processing, mapping, and analysis of transposon insertion sequencing data. The pipeline was designed with the data from the TraDIS sequencing protocol in mind, but should work with a variety of transposon insertion sequencing protocols as long as they produce data in the expected format.


## Installation

install.packages("GKinect")


## Usage

Command-line usage instructions:

./plotGrowthCurve.R --samples <sample1.xlsx sample2.xlsx ... sampleN.xlsx> --outputplot <outplot.pdf>

./combineData.R --samples <sample1.xlsx sample2.xlsx ... sampleN.xlsx> --mapping <mapping.xlsx> 

### Scripts
Executable scripts to carry out most of the listed functions are available in the `bin`:

* `combineData.R` - Generates a csv file containing all merged sample files and discription provided in mapping file.
* `plotGrowthCurve.R` - Generates a pdf containing growth curve plots for each sample.

A help menu for each script can be accessed by running the script with -h.

## License
GKinect is free software, licensed under [GPLv3](https://github.com/sbastkowski/GKinect/blob/master/software_license).

## Feedback/Issues
Please report any issues to the [issues page](https://github.com/sbastkowski/GKinect/issues) or email sarah.bastkowski@quadram.ac.uk

