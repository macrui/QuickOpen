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

- (id)initWithFrame:(CGRect)frame {
       NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.cykey.quickopensettings.plist"];

       if ([[dict objectForKey:@"Enabled"] boolValue])
       {
        %orig;
	openButton = [[(Class)objc_getClass("SUItemOfferButton") alloc] initWithFrame:CGRectMake(231,8,80,25)];
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

    [dict release];
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
