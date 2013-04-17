//
//  ExchangeAppDelegate.m
//  Exchange
//
//  Created by zhiyu zhang on 13-4-14.
//  Copyright (c) 2013年 __MyCompanyName__. All rights reserved.
//

#import "ExchangeAppDelegate.h"

#import "WelcomeViewController.h"
#import "Reachability.h"
#import "HttpUtil.h"
@implementation ExchangeAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize welcomeController=_welcomeController;
@synthesize exchangeController;
@synthesize responseData;
- (void)dealloc
{
    [_window release];
    [_welcomeController release];
    [_viewController release];
    [exchangeController release];
    [responseData release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    self.welcomeController = [[[WelcomeViewController alloc] initWithNibName:@"WelcomeViewController" bundle:nil] autorelease];
    [UIApplication sharedApplication].statusBarHidden = YES;
    UIImageView  *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    imageView.Image=[UIImage imageNamed:@"welcome.png"];
    [self.window addSubview:imageView];
//    self.exchangeController = [[[CurrencyExchangeViewController alloc] initWithNibName:@"CurrencyExchangeViewController" bundle:nil] autorelease];
    
    
    [self.window makeKeyAndVisible];
    NSThread* myThread = [[NSThread alloc] initWithTarget:self  
                                                 selector:@selector(changeController)  
                                                   object:nil];  
    [myThread start]; 
    return YES;
}
-(void) changeController
{
    NSDateFormatter *nsdf2=[[[NSDateFormatter alloc] init]autorelease];
    [nsdf2 setDateStyle:NSDateFormatterShortStyle];
    [nsdf2 setDateFormat:@"YYYYMMdd"];
    NSString *dataString=[nsdf2 stringFromDate:[NSDate date]];
    
    NSString *url=[[NSString alloc] initWithFormat:@"http://localhost:8080/webtest/%@.xml",dataString];
    
    Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"not net");
            self.responseData =[HttpUtil post:url];
            break;
        case ReachableViaWWAN:
            NSLog(@"3G OK");
            break;
        case ReachableViaWiFi:
            NSLog(@"WIFI OK");
            self.responseData =[HttpUtil post:url];
            if(self.responseData==false){
                break;
            }
            NSRange foundObj=[self.responseData rangeOfString:@"HTTP Status 404" options:NSCaseInsensitiveSearch]; 
            if(foundObj.length>0){
                break;
            }
            
            NSString *path=[[NSBundle mainBundle] bundlePath];
            NSString *filePath=[[NSString alloc] initWithFormat:@"%@/rate.xml", path];
            NSFileHandle *file=[NSFileHandle fileHandleForUpdatingAtPath:filePath];
            
            [file truncateFileAtOffset:[self.responseData length]];
            [file seekToFileOffset:0];
            [file writeData:[self.responseData dataUsingEncoding:NSUTF8StringEncoding]];
            [file seekToFileOffset:0];
            NSData *fileData=[file readDataToEndOfFile];
            NSString *content=[[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
            NSLog(@"filecontent:%@",content);
            [file closeFile];
            break;
    }

    sleep(3);
    self.window.rootViewController = self.welcomeController;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
