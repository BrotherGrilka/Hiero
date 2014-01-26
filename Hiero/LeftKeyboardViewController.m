//
//  LeftKeyboardViewController.m
//  Hiero
//
//  Created by Dunc on 1/26/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "LeftKeyboardViewController.h"
#import "GlyphButton.h"

@interface LeftKeyboardViewController ()

@end

@implementation LeftKeyboardViewController

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

	__block int r = 0;
    __block int z = 0;
	__block int glyphTally = 6;
	
    [[GlyphHelper glyphs] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		GlyphButton *rockyGlyphButton = [[GlyphButton alloc] initWithFrame:CGRectMake((z % 2) * 95, r * 95, 95, 95)
																	andKey:key
																 withColor:[GlyphColor yellowGreenColor]];
		
		[self.view addSubview:rockyGlyphButton];
		
        if (++z == glyphTally)
			*stop = YES;
		else {
			NSArray *modArgs = [NSArray arrayWithObjects: [NSExpression expressionForConstantValue:[NSNumber numberWithInteger:z]], [NSExpression expressionForConstantValue:[NSNumber numberWithInteger:2]], nil];
			NSExpression *modExpression =[NSExpression expressionForFunction:@"modulus:by:" arguments:modArgs];
			
			if (![[modExpression expressionValueWithObject:nil context: nil] boolValue])
				r++;
		}
		
		//		if (++z == glyphTally)
		//			*stop = YES;
		//        else if (!(z % 2))
		//            r++;
		
		[rockyGlyphButton addTarget:self action:@selector(handleGlyphTouch:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
