//
//  UIColor+AppaloosaColor.m
//  Hiero
//
//  Created by Dunc on 1/27/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "UIColor+AppaloosaColor.h"

@implementation UIColor (AppaloosaColor)

+ (UIColor*)iceColor {
	return [[UIColor alloc] initWithRed:102.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
}

+ (UIColor*)strawColor {
	return  [[UIColor alloc] initWithRed:255.0/255 green:0.0/255 blue:128.0/255 alpha:1.0];
}

+ (UIColor*)cantaloupeColor {
	return  [[UIColor alloc] initWithRed:255.0/255 green:204.0/255 blue:102.0/255 alpha:1.0];
}

+ (UIColor*)yellowGreenColor {
	return  [[UIColor alloc] initWithRed:154.0/255 green:205.0/255 blue:50.0/255 alpha:1.0];
}

+ (UIColor*)orangeRedColor {
	return  [[UIColor alloc] initWithRed:255.0/255 green:69.0/255 blue:0.0/255 alpha:1.0];
}

@end