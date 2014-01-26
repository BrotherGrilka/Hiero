//
//  MannysViewController.m
//  Hiero
//
//  Created by Dunc on 1/17/14.
//  Copyright (c) 2014 Mmyrmidons. All rights reserved.
//

#import "MannysViewController.h"

@interface MannysViewController ()

@property (nonatomic, strong) IBOutlet UIButton *harleyButton;
@property (nonatomic, strong) IBOutlet UIButton *appaloosaButton;
@property (nonatomic, strong) IBOutlet UIButton *missTikkyButton;

@end

@implementation MannysViewController

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
    // Do any additional setup after loading the view from its nib.


	[self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
	
	NSDictionary *viewsDictionary = @{@"harleyButton": self.harleyButton,
									  @"appaloosaButton": self.appaloosaButton,
									  @"missTikkyButton": self.missTikkyButton};
	
	NSArray *con = [NSLayoutConstraint constraintsWithVisualFormat:@"[harleyButton]-40-[appaloosaButton]-40-[missTikkyButton]" options:0 metrics:nil views:viewsDictionary];

	[self.view addConstraint:con[0]];
}

- (void)letMissTikkyOutside:(id)sender {
	NSLog(@"Come on Tikky: %@", sender);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
