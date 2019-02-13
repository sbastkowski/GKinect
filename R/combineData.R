#!/usr/bin/env Rscript

# PODNAME: combineData.R
# ABSTRACT: combineData.R

if(!require(getopt)){install.packages("getopt", repos = "http://cran.us.r-project.org")}
library("getopt")
if(!require(lattice)){install.packages("lattice", repos = "http://cran.us.r-project.org")}
library(lattice)
if(!require(gridExtra)){install.packages("gridExtra", repos = "http://cran.us.r-project.org")}
library(gridExtra)
if(!require(ggplot2)){install.packages("tidyverse", repos = "http://cran.us.r-project.org")}
library(ggplot2)
if(!require(openxlsx)){install.packages("openxlsx", repos = "http://cran.us.r-project.org")}
library("openxlsx")

source("data.R")

options(width=80)

opt = getopt(matrix( c('help', 'h', 0, "logical",
                       'verbose', 'v', 0, "integer",
                       'samples', 's', 1, "character",
                       'mapping', 'm', 1, "character",
                       'timepoints', 't', 0, "integer",
                       'output', 'o', 0, "character"), ncol=4, byrow=TRUE ) );



if (is.null(opt$output) ) {
  output="output.csv"
}


samples = strsplit(opt$samples, split = " ")
my_data = prep_data(samples, opt$timepoints, opt$mapping)
write.csv(my_data, output)
