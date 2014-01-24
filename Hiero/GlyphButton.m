//
//  RockyGlyphButton.m
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphButton.h"

@implementation GlyphButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andKey:(NSString *)key withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
		[self setTitle:key withColor:color];
		[self.titleLabel setFont:[UIFont fontWithName:@"Gardiner" size:72]];
	}
    return self;
}

- (void)setTitle:(NSString *)key withColor:(UIColor *)color {
	_key = key;
	
	unsigned hexen = 0;
	NSScanner *hexenScanner = [NSScanner scannerWithString:_key];
	
	[hexenScanner scanHexInt:&hexen];
	
	[self setTitle:[[GlyphHelper unicodes] objectAtIndex:hexen - 0x13000] forState:UIControlStateNormal];
	[self setTitleColor:color forState:UIControlStateNormal];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
