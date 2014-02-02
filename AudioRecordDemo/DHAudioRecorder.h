//
//  DHAudioRecorder.h
//
//  Created by Douglas Hill on 26/01/2012.
//

@import Foundation;
@import UIKit;
@import AVFoundation;

typedef enum {
	DHAudioRecorderStateNotRecordingHaveNothing,
	DHAudioRecorderStateNotRecordingCanPlay,
	DHAudioRecorderStateRecording,
	DHAudioRecorderStatePlaying,
} DHAudioRecorderState;

@interface DHAudioRecorder : NSObject
{
	AVAudioRecorder *recorder;
	AVAudioPlayer *player;
}

@property (nonatomic, strong, readonly) UIView *view;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

- (void)enterState:(DHAudioRecorderState)newState;
- (NSURL *)filePathURL;
- (NSString *)filePathString;

@end
