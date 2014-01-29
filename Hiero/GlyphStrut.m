//
//  GlyphStrut.m
//  Hiero
//
//  Created by Dunc on 1/25/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphStrut.h"
#import "GlyphButton.h"
#import "Strut.h"
#import "Glyph.h"

@interface GlyphStrut ()

@property (nonatomic, strong) Strut *strut;
@property (nonatomic, weak) IBOutlet UIView *leftIndicator;
@property (nonatomic, weak) IBOutlet UIView *bottomIndicator;
@property (nonatomic, weak) IBOutlet UIView *rightIndicator;

@end

@implementation GlyphStrut

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithGlyphButton:(GlyphButton *)glyphButton withinCanvas:(CGRect)canvasFrame {
	Glyph *glyph = [Glyph MR_createEntity];
	
	glyph.key = glyphButton.key;
	glyph.originX = 0;
	glyph.originY = 0;
	
	Strut *strut = [Strut MR_createEntity];

	strut.originX = [NSNumber numberWithFloat:glyphButton.frame.origin.x - canvasFrame.origin.x];
	strut.originY = [NSNumber numberWithFloat:glyphButton.frame.origin.y - canvasFrame.origin.y];
	
	[strut addGlyphsObject:glyph];
	
	[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
	
	return [self initWithStrut:strut];
}

- (id)initWithStrut:(Strut *)strut {
	self = [self initWithNibName:@"GlyphStrut" bundle:nil];
	self.view.frame = CGRectMake([strut.originX floatValue], [strut.originY floatValue], 95.0, 95.0);
	self.strut = strut;

	[self renderStrut];

	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)renderStrut {
	for (UIView *view in self.view.subviews)
		if ([view isKindOfClass:[GlyphButton class]])
			[view removeFromSuperview];
	
	NSSortDescriptor *ascending = [[NSSortDescriptor alloc] initWithKey:@"index" ascending:YES];
	NSArray *sortedGlyphs = [self.strut.glyphs sortedArrayUsingDescriptors:[NSArray arrayWithObject:ascending]];
	
	[sortedGlyphs enumerateObjectsUsingBlock:^(Glyph *glyph, NSUInteger idx, BOOL *stop) {
		GlyphButton *glyphButton = [[GlyphButton alloc] initWithFrame:CGRectMake(0.0, idx * 95.0, 95.0, 95.0)
															   andKey:glyph.key
															withColor:[UIColor cantaloupeColor]];
		[self.view addSubview:glyphButton];
	}];

	[self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, [self.strut.glyphs count] * 95.0)];
}

- (void)addGlyph:(GlyphButton *)glyphButton {
	Glyph *glyph = [Glyph MR_createEntity];
	
	glyph.key = glyphButton.key;
	glyph.originX = [NSNumber numberWithFloat:glyphButton.frame.origin.x];
	glyph.originY = [NSNumber numberWithFloat:glyphButton.frame.origin.y];
	glyph.index = [NSNumber numberWithInt:[self.strut.glyphs count]];
		
	[self.strut addGlyphsObject:glyph];

	[[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
	
	[self renderStrut];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
