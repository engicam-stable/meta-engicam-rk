inherit native

SUMMARY = "IDBLoader creation"
DEPENDS += "rk-binary-native u-boot-mkimage-native coreutils-native u-boot"

LICENSE = "MIT"


# Generate idbloader.img
do_install () {
  echo "start tag=0x12345678
ddr2_freq=0
lp2_freq=0
ddr3_freq=0
lp3_freq=0
ddr4_freq=333
lp4_freq=0

uart id=2
uart iomux=1
uart baudrate=1500000

end" > ${datadir}/rk-binary-native/ddrbin_param.txt

  ddrbin_tool ${datadir}/rk-binary-native/ddrbin_param.txt ${datadir}/rk-binary-native/px30_ddr_333MHz_v1.14.bin

  cp ${datadir}/rk-binary-native/px30_miniloader_v1.20.bin .
	cp ${datadir}/rk-binary-native/px30_ddr_333MHz_v1.14.bin .
	mkimage -n px30 -T rksd -d px30_ddr_333MHz_v1.14.bin idbloader.img
  cat px30_miniloader_v1.20.bin >> idbloader.img

  cp idbloader.img ${DEPLOY_DIR_IMAGE}/
}
