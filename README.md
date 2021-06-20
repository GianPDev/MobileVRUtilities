# MobileVRUtilities
Scripts and whatnot for Mobile VR Development (Oculus Quest in this case)

The two current scripts are mainly for setting up multiple headsets.

REQUIRES adb to be installed

## AndroidSetAllDevicesToWifi.bat
Gets all devices, sets them all to port 5555 (I did this because scrcpy uses this port for mirroring) and connects them via wifi

## AndroidInstallAPKtoALL.bat
Installs an apk (full path and filename required) into all connected adb devices
