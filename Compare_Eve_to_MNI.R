rm(list=ls())
library(fslr)
library(scales)
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

add_dim = function(img, outdim = c(182, 218, 182)){
	x = img@.Data 
	newarr = array(0, dim = outdim)
	newarr[1:dim(x)[1], 1:dim(x)[2], 1:dim(x)[3]] = x
	img = copyNIfTIHeader(img, newarr)
	# dim(img) = outdim
	img@dim_ = c(3, outdim, 1, 1, 1, 1)
	return(img)
}

##########################
# Load the MNI 152 T1 brain image
#########################
mni_brain.file = file.path(fsltemp, 
	"MNI152_T1_1mm_brain.nii.gz")
mni_brain = readNIfTI(mni_brain.file, reorient=FALSE)

##########################
# Drop the Last Dimension
#########################
mni_brain_small = cutdown(mni_brain)
writeNIfTI(mni_brain_small, 
	file = "MNI152_T1_1mm_brain_181x217x181")

##########################
# Load the Eve T1 
#########################
eve = readNIfTI(
	"JHU_MNI_SS_T1_brain.nii.gz",
	reorient=FALSE)

eve_large = add_dim(eve)
writeNIfTI(eve_large, 
	file = "JHU_MNI_SS_T1_brain_182x218x182")




double_ortho(mni_brain_small, eve)
png("MNI_Compared_to_Eve.png", type= "cairo")
	ortho2(mni_brain_small, 
		eve, col.y=alpha(hotmetal(), 0.25), 
		text = "MNI T1 overlaid with Eve T1")
dev.off()

png("MNI_Compared_to_Eve.png", type= "cairo")
	ortho2(mni_brain_small, 
		eve, col.y=alpha(hotmetal(), 0.25), 
		xyz = c(70, 95, 50), 
		text = "MNI T1 overlaid with Eve T1")
dev.off()

png("MNI_Compared_to_Eve_mask.png", type= "cairo")
	ortho2(mni_brain_small, 
		eve > 0, col.y=alpha("red", 0.25), 
		text = "MNI T1 overlaid with Eve Brain Mask")
dev.off()

eve_mni = readNIfTI(
	"JHU_MNI_SS_WMPM_Type-I_to_MNI_brain.nii.gz",
	reorient=FALSE)
double_ortho(mni_brain, eve_mni)


# bmask = readNIfTI(bmask.file)
# app = ""

