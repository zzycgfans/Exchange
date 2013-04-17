//
//  ExchangeAppDelegate.h
//  Exchange
//
//  Created by zhiyu zhang on 13-4-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExchangeViewController;
@class WelcomeViewController;
@class CurrencyExchangeViewController;

@interface ExchangeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ExchangeViewController *viewController;
@property (strong, nonatomic) WelcomeViewController *welcomeController;
@property (strong, nonatomic) CurrencyExchangeViewController *exchangeController;

@property(retain,nonatomic) NSString *responseData;

@end
