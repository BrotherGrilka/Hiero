//
//  RockyViewController.m
//  Hiero
//
//  Created by Dunc on 1/10/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#include <objc/runtime.h>

#import "HieroViewController.h"
#import "CanvasViewController.h"
#import "TopKeyboardViewController.h"
#import "LeftKeyboardViewController.h"
#import "MannysViewController.h"
#import "AnimatedGlyphButton.h"
#import "GlyphStrut.h"


@interface HieroViewController ()

@property (nonatomic, weak) TopKeyboardViewController *topKeyboard;
@property (nonatomic, weak) LeftKeyboardViewController *leftKeyboard;
@property (nonatomic, weak) CanvasViewController *canvas;

@end

@implementation HieroViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.droppedGlyphs = 0;

	self.topKeyboard = self.childViewControllers[0];
	self.canvas = self.childViewControllers[1];
	self.leftKeyboard = self.childViewControllers[2];
		
	[self addObserver:self.topKeyboard forKeyPath:@"droppedGlyphs" options:0 context:NULL];
	
//	MannysViewController *mannysViewController = [[MannysViewController alloc] initWithNibName:@"MannysViewController" bundle:nil];
//	
//	
//	mannysViewController.view.frame = CGRectMake(0.0, 0.0, mannysViewController.view.frame.size.width, mannysViewController.view.frame.size.height);
//	
////	[self becomeFirstResponder];
//	[self.view addSubview:mannysViewController.view];
//
//
//	[mannysViewController.view setTranslatesAutoresizingMaskIntoConstraints:NO];
//	
//	NSDictionary *constraintsDictionary = @{@"mannysView": mannysViewController.view};
//
//	NSArray *cons = [NSLayoutConstraint constraintsWithVisualFormat:@"|-200-[mannysView]" options:0 metrics:nil views:constraintsDictionary];
//
//	[self.view addConstraint:cons[0]];
}

- (void)copy:(id)sender {
	NSLog(@"Copy Miss Tikky from HieroViewController: %@", sender);
}



- (void)cloneGlyphButton:(GlyphButton *)glyphButton fromKeyboard:(KeyboardViewController *)keyboard {
	AnimatedGlyphButton *clonedGlyphButton = [[AnimatedGlyphButton alloc] initWithFrame:CGRectMake(glyphButton.frame.origin.x + keyboard.view.superview.frame.origin.x, glyphButton.frame.origin.y + keyboard.view.superview.frame.origin.y, 95, 95)
																		   andKey:glyphButton.key
																		withColor:[UIColor strawColor]];


	size_t hieroSize = class_getInstanceSize([self class]);
	size_t hieroViewSize = class_getInstanceSize([self.view class]);
	size_t glyphSize = class_getInstanceSize([clonedGlyphButton class]);
	
	NSLog(@"Appaloosa: %zu %zu %zu", hieroSize, hieroViewSize, glyphSize);
	

	
	[self.view addSubview:clonedGlyphButton];
	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragClone:)];
//    [panRecognizer setMinimumNumberOfTouches:1];
//    [panRecognizer setMaximumNumberOfTouches:3];
    [clonedGlyphButton addGestureRecognizer:panRecognizer];
}

- (void)dragClone:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		if (recognizer.view.frame.origin.x < self.canvas.view.superview.frame.origin.x
			|| recognizer.view.frame.origin.x + recognizer.view.frame.size.width > self.canvas.view.superview.frame.origin.x + self.canvas.view.superview.frame.size.width
			|| recognizer.view.frame.origin.y < self.canvas.view.superview.frame.origin.y
			|| recognizer.view.frame.origin.y + recognizer.view.frame.size.height > self.canvas.view.superview.frame.origin.y + self.canvas.view.superview.frame.size.height)
				[UIView animateWithDuration:0.5
									  delay:0.0
									options:nil
								 animations:^{
									 recognizer.view.alpha = 0.0;
								 }
								 completion:^(BOOL finished) {
									 [recognizer.view removeFromSuperview];
									 self.droppedGlyphs = [NSNumber numberWithInt: [self.droppedGlyphs intValue] + 1];
								 }];
		else {
			AnimatedGlyphButton *animatedGlyphButton = (AnimatedGlyphButton *) recognizer.view;
			
			if (self.canvas.focusedStrut) {
				CGPoint destination = CGPointMake(self.canvas.view.superview.frame.origin.x + self.canvas.focusedStrut.view.center.x, self.canvas.view.superview.frame.origin.y + self.canvas.focusedStrut.view.frame.origin.y + self.canvas.focusedStrut.view.frame.size.height + animatedGlyphButton.frame.size.height / 2);
				
//				[animatedGlyphButton displayLinkToPoint:destination withFinishedBlock:^ {
				[animatedGlyphButton bezierToPoint:destination withFinishedBlock:^ {
//[animatedGlyphButton setValue:[UI] forKey:<#(NSString *)#>]
					
					[animatedGlyphButton removeFromSuperview];
					[self.canvas addGlyph:animatedGlyphButton];
				}];
			} else {
				[self.canvas addGlyph:animatedGlyphButton];
				[animatedGlyphButton removeFromSuperview];
			}
				
		}
		
		for (UIGestureRecognizer *gestureRecognizer in recognizer.view.gestureRecognizers)
			[recognizer.view removeGestureRecognizer:gestureRecognizer];
	} else {
		CGPoint translation = [recognizer translationInView:self.view];
		CGRect recognizerFrame = recognizer.view.frame;
		recognizerFrame.origin.x += translation.x;
		recognizerFrame.origin.y += translation.y;
		
		if (CGRectContainsRect(self.view.bounds, recognizerFrame))
			recognizer.view.frame = recognizerFrame;
		else {
			if (recognizerFrame.origin.y < self.view.bounds.origin.y)
				recognizerFrame.origin.y = 0;
			else if (recognizerFrame.origin.y + recognizerFrame.size.height > self.view.bounds.size.height)
				recognizerFrame.origin.y = self.view.bounds.size.height - recognizerFrame.size.height;
			
			if (recognizerFrame.origin.x < self.view.bounds.origin.x)
				recognizerFrame.origin.x = 0;
			else if (recognizerFrame.origin.x + recognizerFrame.size.width > self.view.bounds.size.width)
				recognizerFrame.origin.x = self.view.bounds.size.width - recognizerFrame.size.width;
		}
		
		[recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
	}
}

- (IBAction)clearGlyphs:(id)sender {
	[self.canvas clearGlyphs];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[self removeObserver:self.topKeyboard.view forKeyPath:@"droppedGlyphs"];
}

@end
