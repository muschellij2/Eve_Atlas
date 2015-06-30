rm(list=ls())
library(fslr)
library(scales)
setwd("~/Dropbox/RegLib_C26_MoriAtlas")

##########################
# Use the MNI 152 T1 brain image for registration
#########################
rorden.file = "betsct1_unsmooth.nii.gz"
rorden_brain = readNIfTI(rorden.file, reorient=FALSE)

eve = readNIfTI(
	"JHU_MNI_SS_T1_brain.nii.gz",
	reorient=FALSE)

png("Rorden_Compared_to_Eve_mask.png", type= "cairo")
	ortho2(rorden_brain, 
		eve > 0, col.y=alpha("red", 0.25))
dev.off()



# bmask = readNIfTI(bmask.file)
# app = ""

