//
//  WelcomeViewController.m
//  Exchange
//
//  Created by zhiyu zhang on 13-4-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController
@synthesize exchangeViewController;
@synthesize imageView;

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
    
    //    [UIView beginAnimations:@"View Flip" context:nil];
    //    [UIView setAnimationDuration:3.25];//setAnimationDuration:设置动画时间
    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];//设置动画曲线类型，有四种，没感觉出什么不同
//    imageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 320, 460)];
//    imageView.Image=[UIImage imageNamed:@"welcome.png"];
//    [self.view addSubview:imageView];
//    [UIApplication sharedApplication].statusBarHidden = NO;
//   

    //self.view=self.exchangeViewController.view;//和insertSubView方法功能相同
    //    [self presentModalViewController:self.exchangeViewController animated:YES];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.exchangeViewController = [[[CurrencyExchangeViewController alloc] initWithNibName:@"CurrencyExchangeViewController" bundle:nil] autorelease];
    [self.view insertSubview:self.exchangeViewController.view atIndex:0];

}

-(void) changeController
{
    sleep(5);
    
//    [imageView removeFromSuperview];
    
    self.exchangeViewController = [[[CurrencyExchangeViewController alloc] initWithNibName:@"CurrencyExchangeViewController" bundle:nil] autorelease];
    [self.view insertSubview:self.exchangeViewController.view atIndex:0];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [exchangeViewController release];
    [imageView release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
