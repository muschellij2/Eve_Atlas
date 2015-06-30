rm(list = ls())
library(extrantsr)
library(fslr)
eve_dir = path.expand("~/Dropbox/RegLib_C26_MoriAtlas")
mni_dir = path.expand("/usr/local/fsl/data/standard")
eve.t1 = file.path(eve_dir, 
                   "JHU_MNI_SS_T1_brain.nii.gz")
eve_brain = readNIfTI(eve.t1, 
	reorient = FALSE)
mni_file = file.path(mni_dir, 
                     "MNI152_T1_1mm_brain.nii.gz")
mni_brain = readNIfTI(mni_file, 
                      reorient = FALSE)

# template_name = "Rorden"
template_name = "MNI"

labels = file.path(eve_dir, 
                   paste0("JHU_MNI_SS_WMPM_Type-", c("I", "II", "III"), 
                          ".nii.gz"))


out_labels = paste0(nii.stub(labels), 
                    "_to_", template_name, "_brain.nii.gz")

rorden_file = file.path(eve_dir, 
                        "betsct1_unsmooth.nii.gz")

rorden_brain = readNIfTI(rorden_file, 
                         reorient = FALSE)

out_eve = paste0(nii.stub(eve.t1), 
                 "_to_", template_name, "_brain.nii.gz")

template.file = switch(template_name,
                       "Rorden" = rorden_file,
                       "MNI" = mni_file)


out_eve = ants_regwrite( 
	filename = eve_brain, 
	template.file = template.file, 
	interpolator = "NearestNeighbor", 
	outfile = out_eve, 
	typeofTransform = "SyN",
	other.files = labels, 
	other.outfiles = out_labels)

