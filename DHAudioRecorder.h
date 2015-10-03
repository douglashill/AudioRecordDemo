//
//  DHAudioRecorder.h
//  Douglas Hill, February 2014
//  https://github.com/douglashill/DHAudioRecorder
//

@import Foundation;
@import UIKit;
@import AVFoundation;

NS_ASSUME_NONNULL_BEGIN

@interface DHAudioRecorder : NSObject

/// Initialises and returns an audio recorder for recording to the specified file URL.
/// @param URL The file URL where the recording should be saved. If nil, a temporary file will be created.
/// This is the designated initialiser.
- (instancetype)initWithURL:(nullable NSURL *)URL NS_DESIGNATED_INITIALIZER;

/// Convenience initialiser
- (instancetype)initWithURL:(nullable NSURL *)URL recordButton:(nullable UIButton *)recordControl playButton:(nullable UIButton *)playControl;

@property (nonatomic, readonly) NSURL *URL;

/// The button will be selected during recording. Setting this property automatically adds the receiver’s toggleRecord: action as a target for taps on the button.
@property (nonatomic, nullable) IBOutlet UIButton *recordButton;

/// The button will be selected during playback. Setting this property automatically adds the receiver’s togglePlay: action as a target for taps on the button.
@property (nonatomic, nullable) IBOutlet UIButton *playButton;

- (IBAction)toggleRecord:(nullable id)sender;
- (IBAction)togglePlay:(nullable id)sender;

@end

NS_ASSUME_NONNULL_END
