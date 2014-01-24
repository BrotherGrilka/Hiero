//
//  RockyViewController.m
//  Hiero
//
//  Created by Dunc on 1/10/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "HieroViewController.h"
#import "CanvasViewController.h"
#import "KeyboardViewController.h"
#import "MannysViewController.h"

@interface HieroViewController ()

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

	KeyboardViewController *keyboardViewController = self.childViewControllers[0];
	
	[self addObserver:keyboardViewController forKeyPath:@"droppedGlyphs" options:0 context:NULL];
	
	MannysViewController *mannysViewController = [[MannysViewController alloc] initWithNibName:@"MannysViewController" bundle:nil];
	
	mannysViewController.view.frame = CGRectMake(self.view.frame.size.width - mannysViewController.view.frame.size.width, mannysViewController.view.frame.origin.y, mannysViewController.view.frame.size.width, mannysViewController.view.frame.size.height);
	
//	[self becomeFirstResponder];
	[self.view addSubview:mannysViewController.view];
}

- (void)copy:(id)sender {
	NSLog(@"Copy Miss Tikky from HieroViewController: %@", sender);
}



- (void)cloneGlyphButton:(GlyphButton *)glyphButton {
	UIView *keyboardView = self.view.subviews[0];
	
	GlyphButton *clonedGlyphButton = [[GlyphButton alloc] initWithFrame:CGRectMake(glyphButton.frame.origin.x + keyboardView.frame.origin.x, glyphButton.frame.origin.y + keyboardView.frame.origin.y, 95, 95)
																		   andKey:glyphButton.key
																		withColor:[GlyphColor strawColor]];

	[self.view addSubview:clonedGlyphButton];
	
	UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(dragClone:)];
//    [panRecognizer setMinimumNumberOfTouches:1];
//    [panRecognizer setMaximumNumberOfTouches:3];
    [clonedGlyphButton addGestureRecognizer:panRecognizer];
}

- (void)dragClone:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
		UIView *canvasView = self.view.subviews[1];

		if (recognizer.view.frame.origin.x < canvasView.frame.origin.x
			|| recognizer.view.frame.origin.x + recognizer.view.frame.size.width > canvasView.frame.origin.x + canvasView.frame.size.width
			|| recognizer.view.frame.origin.y < canvasView.frame.origin.y
			|| recognizer.view.frame.origin.y + recognizer.view.frame.size.height > canvasView.frame.origin.y + canvasView.frame.size.height)
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
			GlyphButton *glyphButton = (GlyphButton *) recognizer.view;
			CanvasViewController *canvasViewController = (CanvasViewController *) self.childViewControllers[1];

			[recognizer.view removeFromSuperview];
			[glyphButton setTitleColor:[GlyphColor cantaloupeColor] forState:UIControlStateNormal];
			[glyphButton setFrame:CGRectMake(glyphButton.frame.origin.x - canvasView.frame.origin.x, glyphButton.frame.origin.y - canvasView.frame.origin.y, glyphButton.frame.size.width, glyphButton.frame.size.height)];
			[canvasViewController addGlyph:glyphButton];
		}
		
		for (UIGestureRecognizer *gestureRecognizer in recognizer.view.gestureRecognizers)
			[recognizer.view removeGestureRecognizer:gestureRecognizer];
	}
	else {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	UIView *keyboardView = self.view.subviews[0];
	
	NSLog(@"Manners");

	[self removeObserver:keyboardView forKeyPath:@"droppedGlyphs"];
}

@end
