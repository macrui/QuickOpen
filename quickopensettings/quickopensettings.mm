#import <Preferences/PSListController.h>

@interface quickopensettingsListController: PSListController {
}
@end

@implementation quickopensettingsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"quickopensettings" target:self] retain];
	}
	return _specifiers;
}

-(void)performAction:(id)param {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://cykey.hostoast.com/"]];
}

@end

// vim:ft=objc
