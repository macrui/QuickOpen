include theos/makefiles/common.mk

BUNDLE_NAME = quickopensettings
quickopensettings_FILES = quickopensettings.mm
quickopensettings_INSTALL_PATH = /Library/PreferenceBundles
quickopensettings_FRAMEWORKS = UIKit Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/quickopensettings.plist$(ECHO_END)
