//
//  ARDAppDelegate.m
//  AudioRecordDemo
//
//  Created by Douglas Hill on 26/01/2012.
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
