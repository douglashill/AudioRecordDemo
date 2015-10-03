//
//  ARDViewController.m
//  Douglas Hill, February 2014
//  https://github.com/douglashill/DHAudioRecorder
//

#import "ARDViewController.h"
#import "DHAudioRecorder.h"

static NSString * const audioFilename = @"recording.caf";

@interface ARDViewController()

@property (nonatomic, strong) DHAudioRecorder *recorder;

@end

@implementation ARDViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	[NSException raise:NSGenericException format:@"Incorrect initialiser %s sent to a %@.", __PRETTY_FUNCTION__, self];
	return nil;
}

- (instancetype)init
{
	self = [super initWithNibName:nil bundle:nil];
	return self;
}

#pragma mark - UIViewController

- (void)loadView
{
	[self setView:[[UIView alloc] init]];
	[[self view] setBackgroundColor:[UIColor whiteColor]];
	
	NSURL *audioURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject] URLByAppendingPathComponent:audioFilename];
	
	UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[recordButton setTitle:@"Record" forState:UIControlStateNormal];
	[recordButton setTitle:@"Stop" forState:UIControlStateSelected];
	
	UIButton *playButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitle:@"Pause" forState:UIControlStateSelected];
	
	for (UIButton *button in @[recordButton, playButton]) {
		[button setTranslatesAutoresizingMaskIntoConstraints:NO];
		[[button titleLabel] setFont:[UIFont systemFontOfSize:40]];
	}
	
	[self setRecorder:[[DHAudioRecorder alloc] initWithURL:audioURL recordButton:recordButton playButton:playButton]];
	
	[[self view] addSubview:recordButton];
	[[self view] addSubview:playButton];
	
	[[self view] addConstraint:[NSLayoutConstraint constraintWithItem:playButton attribute:NSLayoutAttributeCenterX
															relatedBy:NSLayoutRelationEqual
															   toItem:[self view] attribute:NSLayoutAttributeCenterX
														   multiplier:1 constant:0]];
	[[self view] addConstraint:[NSLayoutConstraint constraintWithItem:playButton attribute:NSLayoutAttributeBaseline
															relatedBy:NSLayoutRelationEqual
															   toItem:[self view] attribute:NSLayoutAttributeCenterY
														   multiplier:1 constant:0]];
	[[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[rec]-[play]"
																		options:NSLayoutFormatAlignAllLeading | NSLayoutFormatAlignAllTrailing
																		metrics:nil
																		  views:@{@"rec" : recordButton, @"play" : playButton}]];
}

@end
