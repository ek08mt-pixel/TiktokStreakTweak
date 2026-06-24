export THEOS = /home/runner/theos
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TiktokStreakTweak
TiktokStreakTweak_FILES = Tweak.xm
TiktokStreakTweak_FRAMEWORKS = Foundation UIKit
TiktokStreakTweak_PLIST_PATH = TiktokStreakTweak.plist

include $(THEOS)/makefiles/tweak.mk

