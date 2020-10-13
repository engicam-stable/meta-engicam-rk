inherit native

SUMMARY = "IDBLoader creation"
DEPENDS += "rk-binary-native u-boot-mkimage-native coreutils-native u-boot"

LICENSE = "MIT"


# Generate idbloader.img
do_install () {
  echo "start tag=0x12345678
ddr2_freq=
lp2_freq=
ddr3_freq=800
lp3_freq=
ddr4_freq=
lp4_freq=

uart id=0
uart iomux=2
uart baudrate=115200

ddr_2t=

end" > ${datadir}/rk-binary-native/ddrbin_param.txt

  ddrbin_tool ${datadir}/rk-binary-native/ddrbin_param.txt ${datadir}/rk-binary-native/rk3399_ddr_800MHz_v1.24.bin

  cp ${datadir}/rk-binary-native/rk3399_miniloader_v1.26.bin .
	cp ${datadir}/rk-binary-native/rk3399_ddr_800MHz_v1.24.bin .
	mkimage -n rk3399 -T rksd -d rk3399_ddr_800MHz_v1.24.bin idbloader.img
  cat rk3399_miniloader_v1.26.bin >> idbloader.img

  cp idbloader.img ${DEPLOY_DIR_IMAGE}/
}
