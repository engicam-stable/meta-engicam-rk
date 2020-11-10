do_install_append () {
  install -d ${D}/${datadir}/${PN}

	cd ${S}/tools

  install -m 0644 ddrbin_param.txt ${D}/${datadir}/${PN}
  install -m 0755 ddrbin_tool ${D}/${bindir}

  cd ${S}/bin/rk33

  if [ "${MACHINE}" = "px30-core-evb2" -o "${MACHINE}" = "px30-core-ctouch2" ]; then
    install -m 0644 px30_miniloader_v1.20.bin ${D}/${datadir}/${PN}
    install -m 0644 px30_ddr_333MHz_v1.14.bin ${D}/${datadir}/${PN}
  else
    install -m 0644 rk3399_miniloader_v1.26.bin ${D}/${datadir}/${PN}
    install -m 0644 rk3399_ddr_800MHz_v1.24.bin ${D}/${datadir}/${PN}
  fi
}
