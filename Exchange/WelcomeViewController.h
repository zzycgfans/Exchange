//
//  WelcomeViewController.h
//  Exchange
//
//  Created by zhiyu zhang on 13-4-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrencyExchangeViewController.h"
@interface WelcomeViewController : UIViewController
@property (retain, nonatomic) UIImageView  *imageView;
@property (strong, nonatomic) CurrencyExchangeViewController *exchangeViewController;
@end
