FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://brcmfmac43430-sdio.txt \
    "

do_install_append() {
    cp ${WORKDIR}/brcmfmac43430-sdio.* ${D}/lib/firmware/brcm/
}

FILES_${PN} += " \
    /lib/firmware/brcm/brcmfmac43430-sdio.txt \
    "