#!/usr/bin/env Rscript

# PODNAME: tradis_comparison.R
# ABSTRACT: tradis_comparison.R

if(!require(getopt)){install.packages("getopt", repos = "http://cran.us.r-project.org")}
library("getopt")
if(!require(lattice)){install.packages("lattice", repos = "http://cran.us.r-project.org")}
library(lattice)
if(!require(gridExtra)){install.packages("gridExtra", repos = "http://cran.us.r-project.org")}
library(gridExtra)
if(!require(ggplot2)){install.packages("ggplot2", repos = "http://cran.us.r-project.org")}
library(ggplot2)
if(!require(readxl)){install.packages("readxl", repos = "http://cran.us.r-project.org")}
library("readxl")

options(width=80)

opt = getopt(matrix( c('help', 'h', 0, "logical",
                       'verbose', 'v', 0, "integer",
                       'samples', 's', 1, "character",
                       'outputplot', 'p', 0, "character",
                       'timepoints', 't', 0, "integer",
                       'mapping', 'm', 0, "character"), ncol=4, byrow=TRUE ) );

if(! is.null(opt$help) || is.null(opt$samplesheet ) )
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

# set default outputplot filename
if ( is.null(opt$outputplot ) ) { opt$outputplot = paste(opt$sample, ".outputplot.pdf",sep = "")}

samples = strsplit(opt$samples, split = " ")

#Creates a pdf document with all individual growth curves
plot_growth(samples, opt$timepoints, outputplot, opt$mapping)
