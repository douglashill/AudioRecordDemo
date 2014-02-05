//
//  ARDAppDelegate.m
//  Douglas Hill, February 2014
//  https://github.com/douglashill/DHAudioRecorder
//

#import "ARDAppDelegate.h"
#import "ARDViewController.h"

@implementation ARDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	[self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
	
	ARDViewController *vc = [[ARDViewController alloc] init];
	[[self window] setRootViewController:vc];
    [[self window] makeKeyAndVisible];
	
    return YES;
}

@end
