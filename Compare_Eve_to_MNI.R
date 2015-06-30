rm(list=ls())
library(fslr)
setwd("~/Dropbox/RegLib_C26_MoriAtlas")

fsltemp = path.expand(file.path(fsldir(), 
    "data", "standard"))

#####################################
# This function drops the last dimension in every direction
#####################################
cutdown = function(img, outdim= c(181, 217, 181)){
	x = img@.Data 
	x = x[1:outdim[1], 1:outdim[2], 1:outdim[3]]
	img@.Data = x
	# dim(img) = outdim
	img@dim_ = c(3, outdim, 1, 1, 1, 1)
	return(img)
}

##########################
# Use the MNI 152 T1 brain image for registration
#########################
mni_brain.file = file.path(fsltemp, 
	"MNI152_T1_1mm_brain.nii.gz")
mni_brain = readNIfTI(mni_brain.file, reorient=FALSE)

mni_brain_small = cutdown(mni_brain)


eve = readNIfTI(
	"JHU_MNI_SS_T1_brain.nii.gz",
	reorient=FALSE)
double_ortho(mni_brain_small, eve)


eve_mni = readNIfTI(
	"JHU_MNI_SS_WMPM_Type-I_to_MNI_brain.nii.gz",
	reorient=FALSE)
double_ortho(mni_brain, eve_mni)


# bmask = readNIfTI(bmask.file)
# app = ""
reg.bmask = bmask > 0
bmask = cutdown(bmask)
bmask = bmask > 0
