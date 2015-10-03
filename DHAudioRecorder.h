//
//  DHAudioRecorder.h
//  Douglas Hill, February 2014
//  https://github.com/douglashill/DHAudioRecorder
//

@import Foundation;
@import UIKit;
@import AVFoundation;

@interface DHAudioRecorder : NSObject

/// Designated initialiser
- (instancetype)initWithPath:(NSString *)path recordButton:(UIButton *)recordControl playButton:(UIButton *)playControl;

/// The button will be selected during recording. Setting this property automatically adds the receiver’s toggleRecord: action as a target for taps on the button.
@property (nonatomic, strong) IBOutlet UIButton *recordButton;

/// The button will be selected duing playback. Setting this property automatically adds the receiver’s togglePlay: action as a target for taps on the button.
@property (nonatomic, strong) IBOutlet UIButton *playButton;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

@end
