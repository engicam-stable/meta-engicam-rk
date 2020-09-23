DESCRIPTON = "Startup camera test script"
SECTION = "test"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

PR = "r0"

RDEPENDS_${PN} = " gstreamer1.0 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-rockchip \
                   gstreamer1.0-plugins-good qtbase-examples stress bash "

SRC_URI = "file://camera-test file://gstreamer-wd.sh file://F40.mp4 file://temperature file://dev-test-launcher.bash \
           file://utils.bash file://system-monitor.bash"

FILES_${PN} = "${sysconfdir}/* ${ROOT_HOME}/*"

do_install() {
    install -d ${D}${sysconfdir}/init.d
    install -d ${D}${sysconfdir}/rc0.d
    install -d ${D}${sysconfdir}/rc1.d
    install -d ${D}${sysconfdir}/rc2.d
    install -d ${D}${sysconfdir}/rc3.d
    install -d ${D}${sysconfdir}/rc4.d
    install -d ${D}${sysconfdir}/rc5.d
    install -d ${D}${sysconfdir}/rc6.d
    install -d ${D}${ROOT_HOME}

    install -m 0755 ${WORKDIR}/camera-test            ${D}${sysconfdir}/init.d/
    install -m 0755 ${WORKDIR}/gstreamer-wd.sh        ${D}${ROOT_HOME}
    install -m 0755 ${WORKDIR}/F40.mp4                ${D}${ROOT_HOME}
    install -m 0755 ${WORKDIR}/temperature            ${D}${ROOT_HOME}
    install -m 0755 ${WORKDIR}/dev-test-launcher.bash ${D}${ROOT_HOME}
    install -m 0755 ${WORKDIR}/utils.bash             ${D}${ROOT_HOME}
    install -m 0755 ${WORKDIR}/system-monitor.bash    ${D}${ROOT_HOME}

    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc0.d/K70camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc1.d/K70camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc2.d/K70camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc3.d/K70camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc4.d/K70camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc5.d/S99camera-test
    ln -sf ../init.d/camera-test ${D}${sysconfdir}/rc6.d/K70camera-test
}
