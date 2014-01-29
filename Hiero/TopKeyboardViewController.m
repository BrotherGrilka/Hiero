//
//  TopKeyboardViewController.m
//  Hiero
//
//  Created by Dunc on 1/26/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "TopKeyboardViewController.h"
#import "GlyphButton.h"
#import "GlyphViewController.h"
#import	"HieroViewController.h"

@interface TopKeyboardViewController ()

@end

@implementation TopKeyboardViewController

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
}

- (void)viewDidAppear:(BOOL)animated {
	int r = 0;
    int z = 0;
	
	HieroViewController *hieroViewController = (HieroViewController*) self.parentViewController;
	uint unicodeCount = [[GlyphHelper unicodes] count];
	
	for (uint i = 0; i < 18; i++) {
		uint keyIndex = arc4random() % unicodeCount;
		NSString *key = [[GlyphHelper glyphs] allKeys][keyIndex];
		
		GlyphButton *rockyGlyphButton = [[GlyphButton alloc] initWithFrame:CGRectMake(r * 95, (z % 2) * 95, 95, 95)
																	andKey:key
																 withColor:[UIColor iceColor]];
		[self.view addSubview:rockyGlyphButton];
		[hieroViewController setzenGlyphPanning:rockyGlyphButton forKeyboard:self];
		
		z++;
		NSArray *modArgs = [NSArray arrayWithObjects: [NSExpression expressionForConstantValue:[NSNumber numberWithInteger:z]], [NSExpression expressionForConstantValue:[NSNumber numberWithInteger:2]], nil];
		NSExpression *modExpression =[NSExpression expressionForFunction:@"modulus:by:" arguments:modArgs];
		
		if (![[modExpression expressionValueWithObject:nil context: nil] boolValue])
			r++;
	}
	
	[super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
