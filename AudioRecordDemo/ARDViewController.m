//
//  ARDViewController.m
//  AudioRecordDemo
//
//  Created by Douglas Hill on 26/01/2012.
//

#import "ARDViewController.h"
#import "DHAudioRecorder.h"

@implementation ARDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	[NSException raise:NSGenericException format:@"Incorrect initialiser %s sent to a %@.", __PRETTY_FUNCTION__, self];
	return nil;
}

- (instancetype)init
{
	self = [super initWithNibName:nil bundle:nil];
	return self;
}

#pragma mark - UIViewController

- (void)loadView
{
	[self setView:[[UIView alloc] init]];
	[[self view] setBackgroundColor:[UIColor grayColor]];
	
	[self setRecorder:[[DHAudioRecorder alloc] init]];
	[[self view] addSubview:[[self recorder] view]];
	[[[self recorder] view] setFrame:CGRectMake(10, 10, 300, 440)];
}

@end
