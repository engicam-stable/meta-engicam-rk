do_install_append() {
	mkdir -p ${D}/${sysconfdir}/xdg/weston
	cat << EOF > ${D}/${sysconfdir}/xdg/weston/weston.ini
[shell]
panel-position=none

[core]
idle-time=0
EOF
}
