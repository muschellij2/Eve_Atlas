rm(list = ls())
library(extrantsr)
library(fslr)
eve_dir = path.expand("~/Dropbox/RegLib_C26_MoriAtlas")
mni_dir = path.expand("/usr/local/fsl/data/standard")
eve.t1 = file.path(eve_dir, 
                   "JHU_MNI_SS_T1_brain.nii.gz")
eve_brain = readNIfTI(eve.t1, 
	reorient = FALSE)
mni_brain = readNIfTI(file.path(mni_dir, 
	"MNI152_T1_1mm_brain.nii.gz"), 
	reorient = FALSE)

labels = file.path(eve_dir, 
	paste0("JHU_MNI_SS_WMPM_Type-", c("I", "II", "III"), 
		".nii.gz"))
out_labels = paste0(nii.stub(labels), 
	"_to_MNI_brain.nii.gz")

# out_eve = ants_regwrite( 
# 	filename= eve_brain, 
# 	template.file= mni_brain, 
# 	interpolator="NearestNeighbor", 
# 	outfile = NULL, 
# 	typeofTransform = "SyN",
# 	other.files=labels, 
# 	other.outfiles=out_labels)


rorden_out_labels = paste0(nii.stub(labels), 
                    "_to_Rorden_brain.nii.gz")
rorden_brain = readNIfTI(file.path(eve_dir, 
                                "betsct1_unsmooth.nii.gz"), 
                      reorient = FALSE)

out_eve = paste0(nii.stub(eve.t1), 
                              "_to_Rorden_brain.nii.gz")

rorden_out_eve = ants_regwrite( 
  filename = eve_brain, 
  template.file = rorden_brain, 
  interpolator = "NearestNeighbor", 
  outfile = out_eve, 
  typeofTransform = "SyN",
  other.files = labels, 
  other.outfiles = rorden_out_labels)


# ortho2(mni_brain, mni_labels_list[[1]])
# writeNIfTI
