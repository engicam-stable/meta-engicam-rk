DESCRIPTON = "Startup demo script"
SECTION = "demos"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

RDEPENDS_${PN} = " qt3d-examples"

SRC_URI = "file://planets-qml"

PACKAGE_ARCH = "${MACHINE_ARCH}"
CONFFILES_${PN} = "${sysconfdir}/init.d/planets-qml"
FILES_${PN} = "${sysconfdir}/*"
PACKAGES = "${PN}"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${sysconfdir}/rc1.d
    install -d ${D}${sysconfdir}/rc2.d
    install -d ${D}${sysconfdir}/rc3.d
    install -d ${D}${sysconfdir}/rc4.d
    install -d ${D}${sysconfdir}/rc5.d

    install -m 0755 ${WORKDIR}/planets-qml ${D}${sysconfdir}/init.d/

    ln -sf ../init.d/planets-qml ${D}${sysconfdir}/rc1.d/K90planets-qml
    ln -sf ../init.d/planets-qml ${D}${sysconfdir}/rc2.d/K90planets-qml
    ln -sf ../init.d/planets-qml ${D}${sysconfdir}/rc3.d/K90planets-qml
    ln -sf ../init.d/planets-qml ${D}${sysconfdir}/rc4.d/K90planets-qml
    ln -sf ../init.d/planets-qml ${D}${sysconfdir}/rc5.d/S90planets-qml
}
