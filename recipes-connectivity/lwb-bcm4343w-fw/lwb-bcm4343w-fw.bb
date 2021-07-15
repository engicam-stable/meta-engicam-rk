DESCRIPTION = "Firmware files for use with BCM4343w wifi"
S = "${WORKDIR}"

LICENSE = "CLOSED"

SRC_URI = "file://brcm4343w"

do_install() {
	install -d ${D}/lib/firmware/brcm
	install -m 0755 ${S}/brcm4343w/* ${D}/lib/firmware/brcm/
}

FILES_${PN} =  "/lib/firmware/brcm/*"
