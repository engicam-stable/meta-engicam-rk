DESCRIPTION = "Engicam image for module emmc flash on production"

LICENSE = "MIT"

inherit core-image

EXTRA_IMAGEDEPENDS += " idbloader"
IMAGE_INSTALL_append = "  \
                          gptfdisk \
                          image-flash \
                       "

IMAGE_ROOTFS_EXTRA_SPACE = "3145728"
