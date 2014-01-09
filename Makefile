ARCHS=armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = FlatNotes
FlatNotes_FILES = FlatNotes.xm UIImage+Color.m
FlatNotes_FRAMEWORKS = UIKit Foundation

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileNotes"

purge: clean
	rm *.deb
