//
//  RockyCanvasViewController.m
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "CanvasViewController.h"
#import "Glyph.h"
#import "Strut.h"
#import "GlyphStrut.h"

@interface CanvasViewController ()

@end

@implementation CanvasViewController

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

	[[Strut MR_findAll] enumerateObjectsUsingBlock:^(Strut *strut, NSUInteger idx, BOOL *stop) {
		if (!self.focusedStrut)
			self.focusedStrut = [[GlyphStrut alloc] initWithStrut:strut];
	}];
}

- (void)viewDidAppear:(BOOL)animated {
	if (self.focusedStrut)
		[self.view addSubview:self.focusedStrut.view];
}

- (void)addGlyph:(GlyphButton *)glyphButton {
	if (self.focusedStrut)
		[self.focusedStrut addGlyph:glyphButton];
	else {
		self.focusedStrut = [[GlyphStrut alloc] initWithGlyphButton:glyphButton withinCanvas:self.view.superview.frame];
		[self.view addSubview:self.focusedStrut.view];
	}
}

- (void)clearGlyphs {
	[Strut MR_deleteAllMatchingPredicate:[NSPredicate predicateWithFormat:nil]];
	[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
	
	self.focusedStrut = nil;
 
	for (UIView *subview in self.view.subviews)
		[subview removeFromSuperview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
