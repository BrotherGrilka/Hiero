//
//  AnimatedGlyphButton.h
//  Hiero
//
//  Created by Dunc on 1/25/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "GlyphButton.h"

@interface AnimatedGlyphButton : GlyphButton

- (void)displayLinkToPoint:(CGPoint)destination withFinishedBlock:(AnimationFinishedBlock)finished;
- (void)bezierToPoint:(CGPoint)destination withFinishedBlock:(AnimationFinishedBlock)finished;

@end
