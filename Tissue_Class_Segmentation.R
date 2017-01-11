rm(list=ls())
library(fslr)
library(extrantsr)
library(spm12r)
brain_fname = "JHU_MNI_SS_T1_brain.nii.gz"

outfile = "JHU_MNI_SS_T1_Tissue_Classes.nii.gz"
if (!file.exists(outfile)) {
  # ANTsR Segmentation
  o = otropos(brain_fname, v = 1)
  
  writenii(o$segmentation, 
           filename = outfile)
}

outfile = "JHU_MNI_SS_T1_FSL_Tissue_Classes.nii.gz"
if (!file.exists(outfile)) {
  
  fast(brain_fname, outfile = outfile, opts = "-v",
       retimg = FALSE)
}

outfile = "JHU_MNI_SS_T1_FSL_NOBC_Tissue_Classes.nii.gz"
if (!file.exists(outfile)) {
  
  fast(brain_fname, outfile, opts = "--nobias -v", 
       retimg = FALSE)
}
outfile = "JHU_MNI_SS_T1_SPM_Tissue_Classes.nii.gz"
if (!file.exists(outfile)) {
  
  # SPM12 Segmentation
  fname = "JHU_MNI_SS_T1.nii.gz"
  spm_seg = spm12_segment(fname)
  seg2 = spm_probs_to_seg(spm_seg)
  # only 1-3
  masker = niftiarr(seg2, seg2 %in% 1:3)
  #mask out others
  seg3 = mask_img(seg2, masker)
  # set order of CSF, GM, WM like atropos
  final_spm = seg3
  final_spm[ final_spm == -1] = 2
  final_spm[ final_spm == -2] = 3
  final_spm[ final_spm == -3] = 1
  writenii(final_spm, 
           filename=outfile)
}
