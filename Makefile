
# Tên tweak và bundle ID
TWEAK_NAME = MyAwesomeTweak
MyAwesomeTweak_FILES = Tweak.xm
MyAwesomeTweak_CFLAGS = -fobjc-arc
MyAwesomeTweak_LIBRARIES = substrate
MyAwesomeTweak_FRAMEWORKS = Foundation UIKit

# Kiến trúc và mục tiêu build
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

# Include Theos makefile rules
include $(THEOS)/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk

# Clean up
after-install::
	install.exec "killall -9 SpringBoard"
