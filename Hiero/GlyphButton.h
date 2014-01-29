//
//  RockyGlyphButton.h
//  Hiero
//
//  Created by Dunc on 1/11/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AnimationFinishedBlock)();

@interface GlyphButton : UIButton

@property (nonatomic, strong) NSString *key;

- (id)initWithFrame:(CGRect)frame andKey:(NSString *)key withColor:(UIColor *)color;
- (void)setTitle:(NSString *)key withColor:(UIColor *)color;
- (void)bezierToPoint:(CGPoint)destination withFinishedBlock:(AnimationFinishedBlock)finished;

@end
