//
//  GlyphViewController.h
//  Hiero
//
//  Created by Dunc on 1/28/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GlyphViewController : UIViewController

@property (nonatomic, strong) NSString *key;

- (id)initWithNibName:(NSString *)nibNameOrNil andFrame:(CGRect)frame andKey:(NSString *)key withColor:(UIColor *)color;
- (void)setGlyphText:(NSString *)key withColor:(UIColor *)color;

@end
