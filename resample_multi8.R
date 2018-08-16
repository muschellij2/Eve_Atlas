library(neurobase)
img = readnii("scct_unsmooth_SS_0.01.nii.gz")
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
writenii(xx, "scct_unsmooth_SS_0.01_multi8.nii.gz")

img = readnii("scct_unsmooth.nii.gz")
img = img + 1024
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
xx = xx - 1024
writenii(xx, 
	"scct_unsmooth_multi8.nii.gz")
