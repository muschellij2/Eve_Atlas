library(neurobase)
library(extrantsr)
img = readnii("scct_unsmooth_SS_0.01.nii.gz")
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
stopifnot(all(dim(xx) %% 8 == 0))
writenii(xx,
         "scct_unsmooth_SS_0.01_multi8.nii.gz")

img = readnii("scct_unsmooth.nii.gz")
img = img + 1024
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
xx = xx - 1024
stopifnot(all(dim(xx) %% 8 == 0))
writenii(xx,
         "scct_unsmooth_multi8.nii.gz")

img = readnii("betsct1_unsmooth.nii.gz")
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
stopifnot(all(dim(xx) %% 8 == 0))
writenii(xx,
         "betsct1_unsmooth_multi8.nii.gz")

img = readnii("sct1_unsmooth.nii.gz")
xx = zero_pad(img, kdim = c(1.5, 3.5, 1.5))
stopifnot(all(dim(xx) %% 8 == 0))
writenii(xx,
         "sct1_unsmooth_multi8.nii.gz")



########################################
# 216^3
########################################
img = readnii("scct_unsmooth_SS_0.01.nii.gz")
img = copyNIfTIHeader(img = img, arr = img[, 1:216, ], )
kdim = (216 - dim(img))/2
xx = zero_pad(img, kdim = kdim)
stopifnot(all(dim(xx) == 216))
writenii(xx,
         "scct_unsmooth_SS_0.01_216x216x216.nii.gz")

img = readnii("scct_unsmooth.nii.gz")
img = img + 1024
img = copyNIfTIHeader(img = img, arr = img[, 1:216, ], )
xx = zero_pad(img, kdim = kdim)
xx = xx - 1024
stopifnot(all(dim(xx) == 216))
writenii(xx,
         "scct_unsmooth_216x216x216.nii.gz")

img = readnii("betsct1_unsmooth.nii.gz")
img = copyNIfTIHeader(img = img, arr = img[, 1:216, ], )
xx = zero_pad(img, kdim = kdim)
stopifnot(all(dim(xx) == 216))
writenii(xx,
         "betsct1_unsmooth_216x216x216.nii.gz")

img = readnii("sct1_unsmooth.nii.gz")
img = copyNIfTIHeader(img = img, arr = img[, 1:216, ], )
xx = zero_pad(img, kdim = kdim)
stopifnot(all(dim(xx) == 216))
writenii(xx,
         "sct1_unsmooth_216x216x216.nii.gz")



#######################################
# 96^3
#######################################
writer = function(fname) {
  img = resample_image(fname,
                       parameters = rep(96, 3),
                       parameter_type = "voxels", interpolator = "linear")
  stopifnot(all(dim(img) == 96))
  writenii(img, paste0(nii.stub(fname), "_96x96x96.nii.gz"))
}
writer("scct_unsmooth_SS_0.01.nii.gz")
writer("scct_unsmooth.nii.gz")
writer("betsct1_unsmooth.nii.gz")
writer("sct1_unsmooth.nii.gz")

fname = "scct_unsmooth_SS_0.01.nii.gz"

writer = function(fname) {
  img = resample_image(fname,
                       parameters = rep(1.5, 3),
                       parameter_type = "mm", interpolator = "linear")
  img = dropEmptyImageDimensions(img)
  target_dim = rep(128, 3)
  kdim = (target_dim - dim(img))/2
  img = zero_pad(img, kdim = kdim)
  stopifnot(all(dim(img) == 128))
  writenii(img, paste0(nii.stub(fname), "_128x128x128.nii.gz"))
}
writer("scct_unsmooth_SS_0.01.nii.gz")

# writer = function(fname) {
#   img = resample_image(fname,
#                        parameters = rep(1.5, 3),
#                        parameter_type = "mm", interpolator = "linear")
#   img = dropEmptyImageDimensions(img > 500, other.imgs = img)
#   img = img$other.imgs
#
#   target_dim = rep(128, 3)
#   kdim = (target_dim - dim(img))/2
#   img = zero_pad(img, kdim = kdim)
#   stopifnot(all(dim(img) == 128))
#   writenii(img, paste0(nii.stub(fname), "_128x128x128.nii.gz"))
# }
#
# writer(fname = "scct_unsmooth.nii.gz")
# writer("betsct1_unsmooth.nii.gz")
# writer("sct1_unsmooth.nii.gz")
