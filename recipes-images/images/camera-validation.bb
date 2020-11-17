DESCRIPTION = "Engicam image for module validation on camera"

LICENSE = "MIT"

inherit core-image

EXTRA_IMAGEDEPENDS += " idbloader"
IMAGE_INSTALL_append = "  \
                          gptfdisk \
                          stress \
                          camera-test \
                          image-flash \
                          i2c-tools \
                       "
