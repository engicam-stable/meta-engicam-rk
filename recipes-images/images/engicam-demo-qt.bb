DESCRIPTION = "Engicam image for qt demo application"

LICENSE = "MIT"

inherit core-image

EXTRA_IMAGEDEPENDS += " idbloader"
IMAGE_INSTALL_append = " qt3d qtdeclarative qtdeclarative-qmlplugins qtquickcontrols qtquickcontrols-qmlplugins qtwayland qt3d-examples planets-qml"
