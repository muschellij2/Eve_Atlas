rm(list=ls())
library(fslr)
library(drammsr)
eve_dir = path.expand(
    "~/Dropbox/RegLib_C26_MoriAtlas")
setwd(eve_dir)

eve_brain = file.path(eve_dir, 
                   "JHU_MNI_SS_T1_brain.nii.gz")
template_name = "MNI"
mni_file = file.path(fsl_std_dir(), 
          "MNI152_T1_1mm_brain.nii.gz")

label = file.path(eve_dir,
  "JHU_MNI_SS_T1_Tissue_Classes.nii.gz")

# cmd  = paste0("dramms --source")
def = file.path(eve_dir,
   paste0(
    template_name, 
     "_brain", 
        "_to_", 
    "JHU_MNI_SS_T1_brain",
    "_DRAMMS_def.nii.gz")
   )
prefix = "RAVENS_ANTs"

dramms_ravens(
  label = label,
  template = mni_file,
  def = def,
  prefix = "RAVENS_ANTs_nodramms")

out_eve = paste0(nii.stub(eve_brain), 
 "_to_", template_name, 
 "_brain_DRAMMS_RAVENS.nii.gz")

source = eve_brain
target = mni_file
outfile = out_eve
outdef = def

labs = NULL
lab_args = NULL
ravens_prefix = "RAVENS_ANTs"

dramms_with_ravens(
  source = source, # Filename (or nifti) to match to target
  target = target, # Filename (or nifti) to match source to to target
  outfile = outfile, # Output filename
  outdef = outdef, # output deformation field
  retimg = FALSE, # return nifti object versus output image
  opts = NULL,
  label = label, # Filename (or nifti) to apply deformation field
  labs = NULL,  
  ravens_prefix = ravens_prefix,
  verbose = TRUE)


# dramms_ravens(
#   label = label,
#   template = target,
#   def = outdef,
#   prefix = "RAVENTS_ANTs_nodramms")
