//
//  GlyphViewController.m
//  Hiero
//
//  Created by Dunc on 1/28/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphViewController.h"
#import "GlyphHelper.h"

@interface GlyphViewController ()

@property (nonatomic, weak) IBOutlet UILabel *glyphLabel;

@end

@implementation GlyphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil andFrame:(CGRect)frame andKey:(NSString *)key withColor:(UIColor *)color
{
    if (self = [super initWithNibName:nibNameOrNil bundle:nil]) {
		[self.view setFrame:frame];
		[self setGlyphText:key withColor:color];
		[self.glyphLabel setTextColor:color];
		[self.glyphLabel setFont:[UIFont fontWithName:@"Gardiner" size:72]];
	}
	
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setGlyphText:(NSString *)key withColor:(UIColor *)color {
	_key = key;
	
	unsigned hexen = 0;
	NSScanner *hexenScanner = [NSScanner scannerWithString:_key];
	
	[hexenScanner scanHexInt:&hexen];
	
	[self.glyphLabel setText:[[GlyphHelper unicodes] objectAtIndex:hexen - 0x13000]];
	[self.glyphLabel setTextColor:color];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
