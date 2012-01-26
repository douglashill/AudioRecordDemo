//
//  DHAudioRecorder.m
//
//  Created by Douglas Hill on 26/01/2012.
//

#import "DHAudioRecorder.h"

@implementation DHAudioRecorder
@synthesize view, recButton, playButton, filename;

- (void)dealloc
{
	[view release];
	[recButton release];
	[playButton release];
	[recorder release];
	[player release];
	[filename release];
	[super dealloc];
}

- (id)init
{
	if (self = [super init]) {
		[self setFilename:@"recording.caf"];
	}
	return self;
}

- (UIView *)view
{
	if (!view) {
		[[NSBundle mainBundle] loadNibNamed:@"DHAudioRecorderView"
									  owner:self
									options:nil];
		BOOL fileExists = [[NSFileManager defaultManager]
						   fileExistsAtPath:[self filePathString]];
		if (fileExists) {
			[self enterState:DHAudioRecorderStateNotRecordingCanPlay];
		} else {
			[self enterState:DHAudioRecorderStateNotRecordingHaveNothing];
		}
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
		[self enterState:DHAudioRecorderStateNotRecordingCanPlay];
	}
	else {
		BOOL success = [recorder record];
		if (!success) {
			NSLog(@"could not start recording");
			return;
		}
		[self enterState:DHAudioRecorderStateRecording];
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
		[self enterState:DHAudioRecorderStateNotRecordingCanPlay];
	}
	else {
		[player play];
		[self enterState:DHAudioRecorderStatePlaying];
	}
}

#pragma mark -

- (void)enterState:(DHAudioRecorderState)newState
{
	// start from inital state of not recording, can not play
	[recButton setTitle:@"Record" forState:UIControlStateNormal];
	[recButton setEnabled:YES];
	[recButton setAlpha:1.0];
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setEnabled:NO];
	[playButton setAlpha:0.5];
	
	// alter as appropriate for the target state
	switch (newState) {
		case DHAudioRecorderStateRecording:
			[recButton setTitle:@"Stop" forState:UIControlStateNormal];
			break;
		case DHAudioRecorderStateNotRecordingCanPlay:
			[playButton setEnabled:YES];
			[playButton setAlpha:1.0];
			break;
		case DHAudioRecorderStatePlaying:
			[recButton setTitle:@"Record" forState:UIControlStateNormal];
			[recButton setEnabled:NO];
			[recButton setAlpha:0.5];
			[playButton setTitle:@"Pause" forState:UIControlStateNormal];
			[playButton setEnabled:YES];
			[playButton setAlpha:1.0];
			break;	
		default:
			break;
	}
}

- (NSURL *)filePathURL
{
	return [NSURL fileURLWithPath:[self filePathString]];
}

- (NSString *)filePathString
{
	NSArray *documentsDirectories = 
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	
	NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
	NSString *recordingPath =
	[documentsDirectory stringByAppendingPathComponent:[self filename]];
	return recordingPath;
}


#pragma mark - AVAudioPlayerDelegate

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)aPlayer
					   successfully:(BOOL)sucessful
{
	if (!sucessful) {
		NSLog(@"Playing ended, but not sucessfully");
	}
	[self enterState:DHAudioRecorderStateNotRecordingCanPlay];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)aPlayer
								 error:(NSError *)anError
{
	NSLog(@"Player decoding error: %@", [anError localizedDescription]);
}


@end
