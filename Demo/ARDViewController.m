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
	[recButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[recButton setTitle:@"Record" forState:UIControlStateNormal];
	[recButton setTitle:@"Stop" forState:UIControlStateSelected];
	
	UIButton *playButton = [UIButton buttonWithType:UIButtonTypeSystem];
	[playButton setTranslatesAutoresizingMaskIntoConstraints:NO];
	[playButton setTitle:@"Play" forState:UIControlStateNormal];
	[playButton setTitle:@"Pause" forState:UIControlStateSelected];
	
	[self setRecorder:[[DHAudioRecorder alloc] initWithPath:audioPath recordButton:recButton playButton:playButton]];
	
	[[self view] addSubview:recButton];
	[[self view] addSubview:playButton];
	
	[[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[rec]-[play]" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"rec" : recButton, @"play" : playButton}]];
	[[self view] addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[rec]" options:NSLayoutFormatAlignAllBaseline metrics:nil views:@{@"rec" : recButton, @"play" : playButton}]];
}

@end
