do_install_append () {
  install -d ${D}/${datadir}/${PN}

	cd ${S}/tools

  install -m 0644 ddrbin_param.txt ${D}/${datadir}/${PN}
  install -m 0755 ddrbin_tool ${D}/${bindir}

  cd ${S}/bin/rk33

  install -m 0644 px30_miniloader_v1.20.bin ${D}/${datadir}/${PN}
  install -m 0644 px30_ddr_333MHz_v1.14.bin ${D}/${datadir}/${PN}
}
