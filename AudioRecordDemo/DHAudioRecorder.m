//
//  DHAudioRecorder.m
//
//  Created by Douglas Hill on 26/01/2012.
//

#import "DHAudioRecorder.h"

typedef enum {
	DHAudioRecorderStateNotRecordingHaveNothing,
	DHAudioRecorderStateNotRecordingCanPlay,
	DHAudioRecorderStateRecording,
	DHAudioRecorderStatePlaying,
} DHAudioRecorderState;

static NSString * const defaultFilename = @"recording.caf";
static UIControlEvents const triggerEvents = UIControlEventTouchUpInside;

@interface DHAudioRecorder () <AVAudioPlayerDelegate>

@property (nonatomic, copy) NSString *filePath;

@end

@implementation DHAudioRecorder
{
	AVAudioRecorder *recorder;
	AVAudioPlayer *player;
}

- (id)init
{
	return [self initWithPath:nil recordControl:nil playControl:nil];
}

- (instancetype)initWithPath:(NSString *)path recordControl:(UIControl *)recordControl playControl:(UIControl *)playControl
{
	self = [super init];
	if (self == nil) return nil;
	
	[self setFilePath:path ? path : [NSTemporaryDirectory() stringByAppendingPathComponent:defaultFilename]];
	[self setRecButton:recordControl];
	[self setPlayButton:playControl];
	
	if ([[NSFileManager defaultManager] fileExistsAtPath:[self filePath]]) {
		[self enterState:DHAudioRecorderStateNotRecordingCanPlay];
	}
	else {
		[self enterState:DHAudioRecorderStateNotRecordingHaveNothing];
	}
	
	return self;
}

- (void)setRecButton:(UIControl *)recButton
{
	if (recButton == _recButton) {
		return;
	}
	
	SEL const action = @selector(toggleRecord:);
	[_recButton removeTarget:self action:action forControlEvents:triggerEvents];
	[recButton addTarget:self action:action forControlEvents:triggerEvents];
	
	_recButton = recButton;
}

- (void)setPlayButton:(UIControl *)playButton
{
	if (playButton == _playButton) {
		return;
	}
	
	SEL const action = @selector(togglePlay:);
	[_playButton removeTarget:self action:action forControlEvents:triggerEvents];
	[playButton addTarget:self action:action forControlEvents:triggerEvents];
	
	_playButton = playButton;
}

#pragma mark - Actions

- (IBAction)toggleRecord:(id)sender
{
	if (!recorder) {
		NSError *error = nil;
		recorder = [[AVAudioRecorder alloc] initWithURL:[self fileURL]
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
		player = [[AVAudioPlayer alloc] initWithContentsOfURL:[self fileURL]
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
	[[self recButton] setEnabled:YES];
	[[self recButton] setSelected:NO];
	[[self playButton] setEnabled:NO];
	[[self playButton] setSelected:NO];
	
	// alter as appropriate for the target state
	switch (newState) {
		case DHAudioRecorderStateRecording:
			[[self recButton] setSelected:YES];
			break;
		case DHAudioRecorderStateNotRecordingCanPlay:
			[[self playButton] setEnabled:YES];
			break;
		case DHAudioRecorderStatePlaying:
			[[self recButton] setEnabled:NO];
			[[self playButton] setEnabled:YES];
			[[self playButton] setSelected:YES];
			break;	
		default:
			break;
	}
}

- (NSURL *)fileURL
{
	return [NSURL fileURLWithPath:[self filePath]];
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
