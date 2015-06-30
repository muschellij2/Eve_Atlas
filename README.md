## Eve Atlas 
This repository contains the "Eve Atlas" from the Johns Hopkins University School of Medicine, Department of Radiology, Center for Brain Imaging Science.  It is based on a single-subject data as described in Oishi et al, 2009. There are co-registered T1 (MPRAGE), T2, with associated atlases and look up tables (LUT files).  The original format is `nrrd`, which was converted to `NIfTI` using [`Slicer`](http://slicer.org/).  All original images have 181x217x181 / 1x1x1 mm dimensions.

## Original Data
Eve atlas downloaded from Slicer [here](http://w.slicer.org/publications/item/view/1883).  

The direct download of the zip file is located at [http://w.slicer.org/publications/bitstream/download/4779](http://w.slicer.org/publications/bitstream/download/4779).  

## Clinical Toolbox
The 2 files `sct1_unsmooth.nii.gz` and `betsct1_unsmooth.nii.gz` correspond to the T1 and skull-stripped (with BET) T1 image from the [Clinical toolbox for SPM](http://www.nitrc.org/projects/clinicaltbx/) from Christopher Rorden as described in [doi: 10.1016/j.neuroimage.2012.03.020](http://dx.doi.org/10.1016/j.neuroimage.2012.03.020).  This is referred to as the Rorden template.

## Transformed Data

The Eve T1-weighted image was skull-stripped using [BET](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET).  This image was transformed into the space of Rorden template and MNI 152 [(6th generation)](http://www.bic.mni.mcgill.ca/ServicesAtlases/ICBM152NLin6) Template included with [FSL](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Atlases).  

Two methods were used for transforming the data: Symmetric Normalization (SyN) [doi: 10.1016/j.media.2007.06.004](http://dx.doi.org/10.1016/j.media.2007.06.004) using the Advanced Normalization Tools (ANTs) and the associated R package [ANTsR](http://stnava.github.io/ANTsR/) and Deformable Registration via Attribute Matching and Mutual-Saliency Weighting (DRAMMS) [doi: 10.1016/j.media.2010.07.002](http://dx.doi.org/10.1016/j.media.2010.07.002).  

The estimated transformation was used to warp the atlases to the associated space and a nearest-neighbor interpolation was used to create labels.

