//
//  ARDViewController.m
//  AudioRecordDemo
//
//  Created by Douglas Hill on 26/01/2012.
//

#import "ARDViewController.h"
#import "DHAudioRecorder.h"

@implementation ARDViewController
@synthesize recorder;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[self setRecorder:[[[DHAudioRecorder alloc] init] autorelease]];
	[[self view] addSubview:[recorder view]];
	[[recorder view] setFrame:CGRectMake(10, 10, 300, 440)];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	[[self recorder] release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
