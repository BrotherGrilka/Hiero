//
//  UIStoryboard+ViewControllerById.m
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "UIStoryboard+ViewControllerById.h"

@implementation UIStoryboard (ViewControllerById)

+ (UIViewController*)rocky:(NSString*)identifier {
	UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Rocky" bundle:nil];
	
	if (identifier)
		return [storyboard instantiateViewControllerWithIdentifier:identifier];

	return [storyboard instantiateInitialViewController];
}

@end
