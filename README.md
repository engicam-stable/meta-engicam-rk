# Engicam meta layer for Yocto build on Rockchip machines

Follow instructions described at [Engicam Rockchip manifests](https://github.com/engicam-stable/rockchip_manifests_engicam) to download Engicam Linux SDK for Rockchip machines

Once installed, enter Yocto folder and launch the script for setting enviroment variables
```sh
source oe-init-build-env
```

Then compile the desired image with bitbake using the command (in this example we compile the recipe engicam-demo-qt.bb):
```sh
bitbake engicam-demo-qt -r conf/include/rksdk.conf
```
