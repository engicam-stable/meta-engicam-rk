DESCRIPTON = "Image flash script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

SRC_URI = "file://image_flash.sh"

FILES_${PN} = "${bindir}/*"

do_install() {
    install -d ${D}${bindir}

    install -m 0755 ${WORKDIR}/image_flash.sh ${D}${bindir}/
}
