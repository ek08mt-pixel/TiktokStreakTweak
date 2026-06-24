
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = TiktokStreakTweak

TiktokStreakTweak_FILES = Tweak.xm
TiktokStreakTweak_CFLAGS = -fobjc-arc
TiktokStreakTweak_LIBRARIES = substrate
TiktokStreakTweak_FRAMEWORKS = Foundation UIKit

include $(THEOS)/makefiles/tweak.mk

