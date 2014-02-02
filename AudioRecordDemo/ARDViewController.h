//
//  ARDViewController.h
//  AudioRecordDemo
//
//  Created by Douglas Hill on 26/01/2012.
//

@import UIKit;
@class DHAudioRecorder;

@interface ARDViewController : UIViewController

- (instancetype)init; /// Designated initialiser

@property (nonatomic, strong) DHAudioRecorder *recorder;

@end
