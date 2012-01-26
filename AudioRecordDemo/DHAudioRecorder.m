//
//  DHAudioRecorder.m
//
//  Created by Douglas Hill on 26/01/2012.
//

#import "DHAudioRecorder.h"

@implementation DHAudioRecorder
@synthesize view, recButton, playButton;

- (void)dealloc
{
	[view release];
	[recButton release];
	[playButton release];
	[recorder release];
	[player release];
	[super dealloc];
}

- (id)init
{
	if (self = [super init]) {
		
	}
	return self;
}

- (UIView *)view
{
	if (!view) {
		[[NSBundle mainBundle] loadNibNamed:@"DHAudioRecorderView"
									  owner:self
									options:nil];
	}
	return view;
}

#pragma mark - Actions

- (IBAction)toggleRecord:(id)sender
{
	if (!recorder) {
		NSError *error = nil;
		recorder = [[AVAudioRecorder alloc] initWithURL:[self filePathURL]
											   settings:nil
												  error:&error];
		if (error) {
			NSLog(@"Error initialising recorder: %@", [error localizedDescription]);
			return;
		}
	}
	
	if ([recorder isRecording]) {
		[recorder stop];
		[recButton setTitle:@"Record" forState:UIControlStateNormal];
		[playButton setEnabled:YES];
		[playButton setAlpha:1.0];
	}
	else {
		BOOL success = [recorder record];
		if (!success) {
			NSLog(@"could not start recording");
			return;
		}
		[recButton setTitle:@"Stop" forState:UIControlStateNormal];
		[playButton setEnabled:NO];
		[playButton setAlpha:0.5];
	}
}

- (IBAction)togglePlay:(id)sender
{
	if (!player) {
		player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self filePathURL]
														error:nil];
		[player setDelegate:self];
	}
	
	if ([player isPlaying]) {
		[player stop];
		[self playingEnded];
	}
	else {
		[player play];
		[playButton setTitle:@"Stop" forState:UIControlStateNormal];
		[recButton setEnabled:NO];
		[recButton setAlpha:0.5];
	}
}

#pragma mark -

- (void)playingEnded
{
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[recButton setEnabled:YES];
	[recButton setAlpha:1.0];
}

- (NSURL *)filePathURL
{
	NSArray *documentsDirectories = 
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
	NSString *recordingPath =
	[documentsDirectory stringByAppendingPathComponent:@"recording.caf"];
	return [NSURL fileURLWithPath:recordingPath];
}


#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)aPlayer
					   successfully:(BOOL)sucessful
{
	[self playingEnded];
	if (!sucessful) {
		NSLog(@"Played ended not sucessful");
	}
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)aPlayer
								 error:(NSError *)anError
{
	NSLog(@"Player decoding error: %@", [anError localizedDescription]);
}


@end
