//
//  CurrencyExchangeViewController.h
//  汇率计算
//
//  Created by zhiyu zhang on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrencyExchangeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, 
NSXMLParserDelegate>{
    UITableView		*popUpBoxTableView;
	NSArray		    *dataSource;
	UIAlertView		*myAlertView;
}
@property(nonatomic, retain) UITableView *popUpBoxTableView;
@property(nonatomic, retain) NSArray *dataSource;
@property(nonatomic, retain) UIAlertView *myAlertView;
@property(nonatomic, retain) UIButton *button;

@property(nonatomic, retain) NSXMLParser *xmlRead;

@property (retain, nonatomic) IBOutlet UIButton *from_currency_button;
@property (retain, nonatomic) IBOutlet UIButton *to_currency_button;
@property (retain, nonatomic) IBOutlet UILabel *current_rate;
@property (retain, nonatomic) IBOutlet UITextField *exchange_munber;
@property (retain, nonatomic) IBOutlet UILabel *resultLabel;
@property (retain, nonatomic) IBOutlet UILabel *resultLabel_2;
@property (retain, nonatomic) IBOutlet UILabel *resultLabel_3;

@property (retain, nonatomic) IBOutlet UITextField *from_currency;
@property (retain, nonatomic) IBOutlet UITextField *to_currency;

- (IBAction)backgroundTap:(id)sender;

- (IBAction)exchange:(id)sender;
- (IBAction)onValueChanged:(id)sender;
- (IBAction)popCurrencyWindow:(id)sender;
@end
