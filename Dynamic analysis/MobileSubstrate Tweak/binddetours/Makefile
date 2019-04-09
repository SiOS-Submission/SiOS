include $(THEOS)/makefiles/common.mk

//THEOS_DEVICE_IP = 192.168.30.154
//THEOS_DEVICE_IP = 192.168.30.103
THEOS_DEVICE_IP = 192.168.30.177
//THEOS_DEVICE_IP = 192.168.1.12

ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:10.3:7.0

TWEAK_NAME = binddetours
binddetours_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
