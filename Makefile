
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TiktokStreakTweak
TiktokStreakTweak_FILES = Tweak.xm

include $(THEOS)/makefiles/tweak.mk
after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences
	echo '{"Filter":{"Bundles":["com.zhiliaoapp.musically"]}}' > $(THEOS_STAGING_DIR)/filter.plist

