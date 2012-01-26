//
//  DHAudioRecorder.h
//
//  Created by Douglas Hill on 26/01/2012.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DHAudioRecorder : NSObject <AVAudioPlayerDelegate>
{
	AVAudioRecorder *recorder;
	AVAudioPlayer *player;
}

@property (nonatomic, retain) IBOutlet UIView *view;
@property (nonatomic, retain) IBOutlet UIButton *recButton;
@property (nonatomic, retain) IBOutlet UIButton *playButton;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

- (void)playingEnded;
- (NSURL *)filePathURL;

@end
