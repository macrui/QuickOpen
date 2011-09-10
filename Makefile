include theos/makefiles/common.mk


TWEAK_NAME = QuickOpen
QuickOpen_FILES = Tweak.xm
QuickOpen_FRAMEWORKS = UIKit 
SUBPROJECTS = quickopensettings


include $(THEOS_MAKE_PATH)/tweak.mk

include theos/makefiles/aggregate.mk