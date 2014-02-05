//
//  DHAudioRecorder.h
//
//  Created by Douglas Hill on 26/01/2012.
//

@import Foundation;
@import UIKit;
@import AVFoundation;

@interface DHAudioRecorder : NSObject

/// Designated initialiser
- (instancetype)initWithPath:(NSString *)path recordButton:(UIButton *)recordControl playButton:(UIButton *)playControl;

/// The button will be selected duing recording. Setting this property automatically adds the receiver’s toggleRecord: action as a target for taps on the button.
@property (nonatomic, strong) IBOutlet UIButton *recButton;

/// The button will be selected duing playback. Setting this property automatically adds the receiver’s togglePlay: action as a target for taps on the button.
@property (nonatomic, strong) IBOutlet UIButton *playButton;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

@end
