// QuickOpen
// By Cykey
#import <UIKit/UIKit.h>
static long long int app;
@interface SUItem__HAX : NSObject {
	long long itemIdentifier;
}
@property(assign, nonatomic) unsigned long long itemIdentifier;

@end

static id openButton = nil;

%hook ASApplicationPageView
//(231,8,80,25)
- (id)initWithFrame:(CGRect)frame {
       
	BOOL enabled;
	if(![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/Preferences/com.cykey.quickopensettings.plist"]){
		enabled = (BOOL)YES;
	}
	else{
		NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.cykey.quickopensettings.plist"];
		enabled = [[dict objectForKey:@"Enabled"] boolValue];
		[dict release];
	}
	
       if (enabled)
       {
        %orig;
	openButton = [[(Class)objc_getClass("SUItemOfferButton") alloc] initWithFrame:CGRectMake(231,70,80,25)];
	[openButton setTitle:@"Installous" forState:UIControlStateNormal];
	[openButton addTarget:self action:@selector(open) forControlEvents:UIControlEventTouchUpInside];
	[openButton setTag:1337];
	[self addSubview: openButton];
	[openButton release];        
	return self;
        }
        else {
return %orig;
}

}

- (void)addSubview:(UIView *)sub {
        %orig;
        [self bringSubviewToFront:[self viewWithTag:1337]];
}

- (void)setItem:(id)item {
	%orig;
	id suitem = MSHookIvar<id>(self, "_item");
	if(!suitem) return;
	long long int appid = [(SUItem__HAX *)suitem itemIdentifier];
	app = appid;
}

%new(v@:@:)
- (void)open {
	NSString *string = [NSString stringWithFormat:@"inst://applicationID=%lld", app];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}
%end

%hook SUItemOfferButton

- (void)setOfferTitle:(id)title {

	if ([title isEqualToString:@"FREE"] || [title isEqualToString:@"INSTALLED"]) { 
		[openButton setHidden:YES];
	}
	%orig;
} 
%end

