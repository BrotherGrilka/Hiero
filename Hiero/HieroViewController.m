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
#import "GlyphButton.h"
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

	self.canvas = self.childViewControllers[0];
	self.topKeyboard = self.childViewControllers[1];
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

- (void)setzenGlyphPanning:(UIView *)glyphView {
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragGlyph:)];
    [glyphView addGestureRecognizer:panRecognizer];
}

- (void)dragGlyph:(UIPanGestureRecognizer *)recognizer {
	CGRect recognizerPseudoFrame = CGRectMake(recognizer.view.frame.origin.x + recognizer.view.superview.superview.frame.origin.x, recognizer.view.frame.origin.y + recognizer.view.superview.superview.frame.origin.y, recognizer.view.frame.size.width, recognizer.view.frame.size.height);

	if (recognizer.state == UIGestureRecognizerStateEnded) {
		if (!CGRectContainsRect(self.canvas.view.superview.frame, recognizerPseudoFrame))
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
			GlyphButton *droppedGlyphButton = (GlyphButton *) recognizer.view;

			if (self.canvas.focusedStrut) {
				CGPoint destination = CGPointMake(self.canvas.view.superview.frame.origin.x + self.canvas.focusedStrut.view.center.x - recognizer.view.superview.superview.frame.origin.x, self.canvas.view.superview.frame.origin.y + self.canvas.focusedStrut.view.frame.origin.y + self.canvas.focusedStrut.view.frame.size.height + droppedGlyphButton.frame.size.height / 2 - recognizer.view.superview.superview.frame.origin.y);

				[droppedGlyphButton bezierToPoint:destination withFinishedBlock:^ {
					[self hinzufugenGlyphToCanvas:droppedGlyphButton];
				}];
			} else {
				[droppedGlyphButton setFrame:recognizerPseudoFrame];
				[self hinzufugenGlyphToCanvas:droppedGlyphButton];
			}
		}
		
		for (UIGestureRecognizer *gestureRecognizer in recognizer.view.gestureRecognizers)
			[recognizer.view removeGestureRecognizer:gestureRecognizer];
	} else {
		CGPoint translation = [recognizer translationInView:self.view];
		CGRect recognizerFrame = recognizer.view.frame;
		CGRect recognizerPseudoFrame = CGRectMake(recognizer.view.frame.origin.x + recognizer.view.superview.superview.frame.origin.x, recognizer.view.frame.origin.y + recognizer.view.superview.superview.frame.origin.y, recognizer.view.frame.size.width, recognizer.view.frame.size.height);
		recognizerFrame.origin.x += translation.x;
		recognizerFrame.origin.y += translation.y;

		
		if (CGRectContainsRect(self.view.bounds, recognizerPseudoFrame))
			recognizer.view.frame = recognizerFrame;
		
		[recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

		if (recognizer.state == UIGestureRecognizerStateBegan) {
			GlyphButton *panningGlyphButton = (GlyphButton*) recognizer.view;
			GlyphButton *rockyGlyphButton = [[GlyphButton alloc] initWithFrame:panningGlyphButton.frame
																		andKey:panningGlyphButton.key
																	 withColor:panningGlyphButton.titleLabel.textColor];


			NSLog(@"Hi Blaccky: %@ %@", NSStringFromCGRect(self.topKeyboard.view.frame), NSStringFromCGRect(recognizerPseudoFrame));

			
			if (CGRectContainsRect(self.topKeyboard.view.superview.frame, recognizerPseudoFrame))
				[self hinzufugenGlyph:rockyGlyphButton toKeyboard:self.topKeyboard];
			else
				[self hinzufugenGlyph:rockyGlyphButton toKeyboard:self.leftKeyboard];
				
			[panningGlyphButton setTitleColor:[UIColor strawColor] forState:UIControlStateNormal];
		}
	}
}

- (void)hinzufugenGlyph:(GlyphButton*)glyphButton toKeyboard:(KeyboardViewController*)keyboard {
	[keyboard.view addSubview:glyphButton];
	[keyboard.view sendSubviewToBack:glyphButton];
	[self setzenGlyphPanning:glyphButton];
}

- (void)hinzufugenGlyphToCanvas:(GlyphButton*)droppedGlyphButton {
	[self.canvas addGlyph:droppedGlyphButton];
	[droppedGlyphButton removeFromSuperview];
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
