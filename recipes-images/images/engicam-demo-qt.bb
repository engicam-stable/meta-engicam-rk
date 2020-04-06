DESCRIPTION = "Engicam image for qt demo application"

LICENSE = "MIT"

inherit core-image

IMAGE_INSTALL_append = " qt3d qtdeclarative qtdeclarative-qmlplugins qtquickcontrols qtquickcontrols-qmlplugins qtwayland qt3d-examples"
