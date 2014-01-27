//
//  AnimatedGlyphButton.m
//  Hiero
//
//  Created by Dunc on 1/25/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "AnimatedGlyphButton.h"
#import "GlyphButton.h"

@interface AnimatedGlyphButton()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) BOOL animating;
@property (nonatomic, assign) CGPoint destination;
@property (nonatomic, assign) int directionX;
@property (nonatomic, assign) int directionY;
@property (nonatomic, strong) AnimationFinishedBlock finished;

@end

@implementation AnimatedGlyphButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)bezierToPoint:(CGPoint)destination withFinishedBlock:(AnimationFinishedBlock)finished {
	self.finished = [finished copy];
	self.destination = destination;
	
	UIBezierPath *path  = [UIBezierPath bezierPath];
	[path moveToPoint:CGPointMake(self.center.x, self.center.y)];
	
//	CGPoint controlPoint1 = CGPointMake(self.center.x + destination.x / 2, self.center.y + destination.y / 2);
//	CGPoint controlPoint2 = CGPointMake(self.center.x + destination.x / 2, self.center.y + destination.y / 2);
	
//	float controlFudge = 40.0;
//
//	CGPoint controlPoint1 = CGPointMake((self.center.x + destination.x) / 2 + controlFudge, (self.center.y + destination.y) / 2 + controlFudge);
//	CGPoint controlPoint2 = CGPointMake((self.center.x + destination.x) / 2 + controlFudge, (self.center.y + destination.y) / 2 + controlFudge);
//	
//	[path addCurveToPoint:destination controlPoint1:controlPoint1 controlPoint2:controlPoint2];

	[path addLineToPoint:destination];
	
	CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
	pathAnimation.duration = 0.4;
	pathAnimation.path = path.CGPath;
	pathAnimation.removedOnCompletion = YES;
	pathAnimation.delegate = self;
	
	[self.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
}

- (void)displayLinkToPoint:(CGPoint)destination withFinishedBlock:(AnimationFinishedBlock)finished {
	self.destination = destination;
	self.directionX = self.frame.origin.x - self.destination.x > 0 ? 1 : -1;
	self.directionY = self.frame.origin.y - self.destination.y > 0 ? 1 : -1;
	self.finished = [finished copy];
	self.animating = YES;

	self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];

	[self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	self.finished();
}

- (void)drawRect:(CGRect)rect {
	if (self.animating) {
//		float progressX = (self.frame.origin.x - self.destination.x) * 0.98;//self.duration;
		
		
		[self setFrame:CGRectMake(self.frame.origin.x - 4.0 * self.directionX, self.frame.origin.y - 4.0 * self.directionY, self.frame.size.width, self.frame.size.height)];

		if (self.frame.origin.x - self.destination.x < 0) {
			[self.displayLink invalidate];
			self.animating = NO;

			[self setFrame:CGRectMake(self.destination.x, self.destination.y, self.frame.size.width, self.frame.size.height)];
			self.finished();
		}
	}
	

//	if (!self.animationRunning)
//    {
//        [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
//        self.animationRunning = YES;
//        return;
//    }
	
//    if (self.lastDrawTime == 0)
//    {
//        self.lastDrawTime = self.displayLink.timestamp;
////		self.finished();
//        return;
//    }
	
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, [[UIColor blueColor] CGColor]);
//	
//    CFTimeInterval elapsedTime = self.displayLink.timestamp - self.lastDrawTime;
//    NSLog(@"elapsed %f", elapsedTime);
//	
//    CGFloat radiansToDraw = self.drawProgress + ((2 * M_PI) / self.drawDuration) * elapsedTime;
//	
//    NSLog(@"drawing %f radians", radiansToDraw);
//	
//    CGContextMoveToPoint(ctx, self.center.x, self.center.y);
//    CGContextAddLineToPoint(ctx, self.center.x + 100, self.center.y);
//    CGContextAddArc(ctx, self.center.x, self.center.y, 100, 0, radiansToDraw, 0);
//    CGContextClosePath(ctx);
//    CGContextFillPath(ctx);
//	
//    self.lastDrawTime = self.displayLink.timestamp;
//    self.drawProgress = radiansToDraw;
	
//    if (radiansToDraw > 2 * M_PI)
//    {
//        NSLog(@"Invalidate display link");
//        [self.displayLink invalidate];
//        self.animationRunning = NO;
//        self.lastDrawTime = 0;
//    }
}

@end
