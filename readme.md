
meta-engicam-rz
================

Based on Renesas BSP 1.0.4 distro

Yocto Project Reference Distro 2.4.3 rocko


SOMs supported
--------------

- icorerzg2e


Images available
----------------

- core-image-qt


First build
-----------

```
source poky/oe-init-build-env
bitbake-layers add-layer ../sources/meta-engicam-rg2
cp ../meta-engicam-rzg2/docs/sample/conf/icorerzg2e/poky-gcc/* conf/
bitbake core-image-qt
```

