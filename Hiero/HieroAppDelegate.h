//
//  HieroAppDelegate.h
//  Hiero
//
//  Created by Duncan Davidson on 8/28/11.
//  Copyright 2011 Mmyrmidons. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HieroViewController;

@interface HieroAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet HieroViewController *viewController;

@end
