inherit native

SUMMARY = "IDBLoader creation"
DEPENDS += "rk-binary-native u-boot-mkimage-native coreutils-native u-boot"

LICENSE = "MIT"


# Generate idbloader.img
do_install () {
  if [ "${MACHINE}" = "px30-core-evb2" -o "${MACHINE}" = "px30-core-ctouch2" ]; then
    echo "start tag=0x12345678
ddr2_freq=0
lp2_freq=0
ddr3_freq=0
lp3_freq=0
ddr4_freq=333
lp4_freq=0

uart id=2
uart iomux=1
uart baudrate=115200

end" > ${datadir}/rk-binary-native/ddrbin_param.txt

    ddrbin_tool ${datadir}/rk-binary-native/ddrbin_param.txt ${datadir}/rk-binary-native/px30_ddr_333MHz_v1.14.bin

    cp ${datadir}/rk-binary-native/px30_miniloader_v1.20.bin .
    cp ${datadir}/rk-binary-native/px30_ddr_333MHz_v1.14.bin .
	  mkimage -n px30 -T rksd -d px30_ddr_333MHz_v1.14.bin idbloader.img
    cat px30_miniloader_v1.20.bin >> idbloader.img

    cp idbloader.img ${DEPLOY_DIR_IMAGE}/
  else
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
  fi
}
