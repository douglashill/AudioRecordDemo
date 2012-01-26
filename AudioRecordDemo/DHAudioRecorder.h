//
//  DHAudioRecorder.h
//
//  Created by Douglas Hill on 26/01/2012.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

typedef enum {
	DHAudioRecorderStateNotRecordingHaveNothing = 0,
	DHAudioRecorderStateNotRecordingCanPlay,
	DHAudioRecorderStateRecording,
	DHAudioRecorderStatePlaying,
} DHAudioRecorderState;

@interface DHAudioRecorder : NSObject <AVAudioPlayerDelegate>
{
	AVAudioRecorder *recorder;
	AVAudioPlayer *player;
}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet UIButton *recButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) NSString *filename;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

- (void)enterState:(DHAudioRecorderState)newState;
//- (void)playingEnded;
- (NSURL *)filePathURL;
- (NSString *)filePathString;

@end
