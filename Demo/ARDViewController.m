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
	
	NSString *audioPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:audioFilename];
	
	UIButton *recButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[recButton setTitle:@"Record" forState:UIControlStateNormal];
	[recButton setTitle:@"Stop" forState:UIControlStateSelected];
	
	UIButton *playButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitle:@"Pause" forState:UIControlStateSelected];
	
	for (UIButton *button in @[recButton, playButton]) {
		[button setTranslatesAutoresizingMaskIntoConstraints:NO];
		[[button titleLabel] setFont:[UIFont systemFontOfSize:40]];
	}
	
	[self setRecorder:[[DHAudioRecorder alloc] initWithPath:audioPath recordButton:recButton playButton:playButton]];
	
	[[self view] addSubview:recButton];
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
																		  views:@{@"rec" : recButton, @"play" : playButton}]];
}

@end
