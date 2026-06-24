
export THEOS = /home/runner/theos
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TiktokStreakTweak
TiktokStreakTweak_FILES = $(wildcard *.xm)

include $(THEOS)/makefiles/tweak.mk
