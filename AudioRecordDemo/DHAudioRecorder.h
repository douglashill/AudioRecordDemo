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

@property (nonatomic, strong) IBOutlet UIView *view;
@property (nonatomic, strong) IBOutlet UIButton *recButton;
@property (nonatomic, strong) IBOutlet UIButton *playButton;
@property (nonatomic, strong) NSString *filename;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

- (void)enterState:(DHAudioRecorderState)newState;
- (NSURL *)filePathURL;
- (NSString *)filePathString;

@end
