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

/// The control will be selected duing recording.
@property (nonatomic, strong) IBOutlet UIButton *recButton;

/// The control will be selected duing playback.
@property (nonatomic, strong) IBOutlet UIButton *playButton;

- (IBAction)toggleRecord:(id)sender;
- (IBAction)togglePlay:(id)sender;

@end
