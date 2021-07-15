FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " file://defconfig "

SRC_URI += "\
		    file://0001-add-edt-ft5x26-touchscreen-driver.patch \
			file://0002-add-initial-suppor-for-icorergz2.patch \
			file://0003-enable-sgtl5000-clock-from-SOC.patch \
			file://0004-fix-sdhi1-node.patch \
			file://0005-fix-bt_regon-pin.patch \
		"

