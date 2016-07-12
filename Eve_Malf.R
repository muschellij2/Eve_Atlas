######################################
# Example of Hippocampus Segmentation
# Using MALF 
######################################
rm(list=ls())
library(fslr)
library(extrantsr)
library(plyr)
hn = system("hostname", 
            intern = TRUE)
rootdir = NULL
if (grepl("compute", hn)){
  rootdir = file.path(
    "/dcl01/smart/data", 
    "structural", 
    "Templates")    
}
if (grepl("taki", hn) |
    grepl("scisub", hn)){
  rootdir = file.path("/project", 
                      "taki2", 
                      "Templates")
}
eve_dir = file.path(rootdir,
    "Eve")
eve_fname = file.path(eve_dir,
  "JHU_MNI_SS_T1_brain.nii.gz")

## Data from 
# https://masi.vuse.vanderbilt.edu/workshop2012/index.php/Workshop_Program
# SS images were skull stripped using
# fslmaths image -mas label image_SS
# need 
# https://masi.vuse.vanderbilt.edu/workshop2012/images/e/e6/MICCAI-Challenge-2012-Label-Information.xlsx
# for mapping of labels
datadir = file.path(rootdir, 
                    paste0("MICCAI-2012-Multi-", 
                           "Atlas-Challenge-Data"))
template_dir = file.path(datadir, 
                         "all-images")
## all images is all files in one folder

#######################################
# Just getting the template data together
#######################################
niis = list.files(
  path = template_dir,
  pattern = ".nii.gz", 
  full.names = TRUE)

bases = nii.stub(niis, bn = TRUE)
templates = niis[grep("_3$", bases)]

df = data.frame(
  template = templates,
  stringsAsFactors = FALSE)
df$ss_template = paste0(
  nii.stub(df$template),
  "_SS.nii.gz")
df$label = paste0(
  nii.stub(df$template),
  "_glm.nii.gz")
stopifnot(all(file.exists(unlist(df))))

#######################################
# Just keeping a few for demonstration
# More templates = more computation, but
# More templates = better segmenation
#######################################
xdf = df

#######################################
# Making a list of labeled files 
#######################################


################################
# Let's try an image to test
################################
outfile = paste0(nii.stub(eve_fname),
  "_MALF.nii.gz")


################################
# Run multi-atlas label fusion (malf)
################################
if (file.exists(outfile)){
  malfer = readnii(outfile)
} else {
  malfer = malf(
    infile = eve_fname,
    template.images = df$ss_template,
    template.structs = df$label,
    outfile = outfile,
    typeofTransform = "SyN",
    interpolator = "MultiLabel",    
    keep_images = FALSE)    
}
