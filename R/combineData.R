#!/usr/bin/env Rscript

# PODNAME: combineData.R
# ABSTRACT: combineData.R

if(!require(getopt)){install.packages("getopt", repos = "http://cran.us.r-project.org")}
library("getopt")
if(!require(lattice)){install.packages("lattice", repos = "http://cran.us.r-project.org")}
library(lattice)
if(!require(gridExtra)){install.packages("gridExtra", repos = "http://cran.us.r-project.org")}
library(gridExtra)
if(!require(ggplot2)){install.packages("ggplot2", repos = "http://cran.us.r-project.org")}
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


if(! is.null(opt$help) || is.null(opt$samples) )
{
  cat(paste("Usage: plotGrowthCurve.R [-h] [-p outputplot.pdf] --samples samples.csv\n\n"));
  writeLines(c(strwrap("Reads in growth values from a sample sheet and plots them."),
               "\n\nRequired Arguments:\n",
               strwrap("--samples : 'samplesheet(s) containing growth values for each well (eg. condition, mutant ect.). Input can be multiple files. They will be additionally labelled by filename in the output plot."),
               "\nOptional Arguments:\n",
               strwrap("-p : output filename for growth curve plots"),
               strwrap("-t : number of time points meassured."),
               strwrap("-m : mapping filename that links actual samplenames to well content names. If not provided, the plots will be labelled by well content names."),"\n"))
  q(status=1);
}

samples = strsplit(opt$samples, split = " ")

if ( is.null(opt$timepoints ) ) {
  writeLines(c(strwrap("No number of timepoints supplied. Using all supplied."),"\n"))
  timepoints = set_timepoints (samples)
} else { timepoints = opt$timepoints }

if (is.null(opt$output) ) {
  output="output.csv"
}



my_data = prep_data(samples, opt$mapping)
write.csv(my_data, output)
