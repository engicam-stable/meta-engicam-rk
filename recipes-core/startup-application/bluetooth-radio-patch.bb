DESCRIPTON = "Bluetooth radio patch utility startup"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${WORKDIR}/copyright;md5=3dd6192d306f582dee7687da3d8748ab"


SRC_URI = "file://bluetooth-radio-patch \
           file://copyright"

FILES_${PN} = "${sysconfdir}/*"

do_install () {
	install -d ${D}${sysconfdir}
	install -d ${D}${sysconfdir}/init.d
	install -d ${D}${sysconfdir}/rcS.d

	install -m 0755 ${WORKDIR}/bluetooth-radio-patch ${D}${sysconfdir}/init.d/

	ln -sf ../init.d/bluetooth-radio-patch ${D}${sysconfdir}/rcS.d/S99bluetooth-radio-patch
}
