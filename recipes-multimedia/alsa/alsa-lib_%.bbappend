do_install_prepend() {
	install -d ${WORKDIR}/git/cards
	install -d ${WORKDIR}/git/alsa/cards
	touch ${WORKDIR}/git/cards/dummyfile
	touch ${WORKDIR}/git/alsa/cards/dummyfile
}

do_install_append() {
	install -m 0644 ${WORKDIR}/git/alsa/cards/* -t ${D}/${datadir}/alsa/cards/
}
