DESCRIPTION = "Engicam image for qt demo application"

LICENSE = "MIT"

inherit core-image
inherit distro_features_check ${@bb.utils.contains('BBFILE_COLLECTIONS', 'qt5-layer', 'populate_sdk_qt5', '', d)}

EXTRA_IMAGEDEPENDS += " idbloader"
IMAGE_INSTALL_append = "  \
                          qt3d \
                          qtdeclarative \
                          qtdeclarative-qmlplugins \
                          qtquickcontrols \
                          qtquickcontrols-qmlplugins \
                          qtwayland \
                          qt3d-examples \
                          planets-qml \
                          gptfdisk \
                          lwb-bcm4343w-fw \
                          brcm-patchram-plus \
                          bluetooth-radio-patch \
                          image-flash \
                       "
