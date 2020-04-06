FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-Build-error-fix-explicit-cast-to-EGLNativeWindowType.patch "
