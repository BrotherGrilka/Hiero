//
//  RockyCanvasViewController.m
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "CanvasViewController.h"
#import "Glyph.h"

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

	NSArray *savedGlyphs = [Glyph MR_findAll];
	
	[savedGlyphs enumerateObjectsUsingBlock:^(Glyph *glyph, NSUInteger idx, BOOL *stop) {
		GlyphButton *rockyGlyphButton = [[GlyphButton alloc] initWithFrame:CGRectMake([glyph.originX floatValue], [glyph.originY floatValue], 95, 95)
																	andKey:glyph.key
																 withColor:[GlyphColor cantaloupeColor]];

		[self.view addSubview:rockyGlyphButton];
	}];
}

- (void)addGlyph:(GlyphButton *)glyphButton {
	[self.view addSubview:glyphButton];
	
	Glyph *glyph = [Glyph MR_createEntity];
	
	glyph.key = glyphButton.key;
	glyph.originX = [NSNumber numberWithFloat:glyphButton.frame.origin.x];
	glyph.originY = [NSNumber numberWithFloat: glyphButton.frame.origin.y];
	
	[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
