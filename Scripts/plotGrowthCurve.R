#!/usr/bin/env Rscript

# PODNAME: plotGrowthCurve.R
# ABSTRACT: plotGrowthCurve.R

if(!require(getopt)){install.packages("getopt", repos = "http://cran.us.r-project.org")}
library("getopt")
if(!require(openxlsx)){install.packages("openxlsx", repos = "http://cran.us.r-project.org")}
library("openxlsx")
if(!require(devtools)){install.packages("devtools", repos = "http://cran.us.r-project.org")}
library("devtools")
install_github("sbastkowski/GKinect")

options(width=80)

opt = getopt(matrix( c('help', 'h', 0, "logical",
                       'samples', 's', 1, "character",
                       'outputplot', 'p', 1, "character",
                       'timepoints', 't', 1, "integer",
                       'mapping', 'm', 1, "character"), ncol=4, byrow=TRUE ) );

if(! is.null(opt$help) || is.null(opt$samples ) )
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

# set default outputplot filename
if ( is.null(opt$outputplot ) ) { opt$outputplot = paste(opt$sample, ".outputplot.pdf",sep = "")} else {outputplot=opt$outputplot}

if ( is.null(opt$timepoints ) ) {
  writeLines(c(strwrap("No number of timepoints supplied. Using all supplied."),"\n"))
  timepoints = set_timepoints (samples)
} else { timepoints = opt$timepoints }

if ( is.null(opt$mapping ) ) { opt$mapping = NULL }

my_data = prep_data(samples, timepoints, opt$mapping)

plots=plot_growth(my_data, timepoints)
cur_dev <- dev.cur()
ggsave(file = opt$outputplot, plots, width = 8.27, height = 11.69, unit = "in")
dev.set(cur_dev)

#For testing
opt$samples="Data/KeioEven22-42_TricGrowthCurves.xlsx"
opt$mapping = "Data/metadata.xlsx"
