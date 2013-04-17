//
//  CurrencyExchangeViewController.m
//  汇率计算
//
//  Created by zhiyu zhang on 12-3-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CurrencyExchangeViewController.h"

@interface CurrencyExchangeViewController ()

@end

@implementation CurrencyExchangeViewController
@synthesize current_rate;
@synthesize exchange_munber;
@synthesize resultLabel;
@synthesize resultLabel_2;
@synthesize resultLabel_3;
@synthesize from_currency_button;
@synthesize to_currency_button;

@synthesize xmlRead;

@synthesize popUpBoxTableView;
@synthesize dataSource;
@synthesize myAlertView;

@synthesize from_currency;
@synthesize to_currency;

@synthesize button;

double from_rate,to_rate;

- (void)viewDidLoad
{
    [super viewDidLoad];
    //预读rate.xml
    NSString *string1=[[NSBundle mainBundle] bundlePath];
    NSString *xmlText=[[NSString alloc] initWithFormat:@"%@/rate.xml", string1];
    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlText];
    self.xmlRead = [[NSXMLParser alloc] initWithData:xmlData];
    [xmlRead setDelegate:self];
	// Do any additional setup after loading the view, typically from a nib.
    // 添加一个tableView
    popUpBoxTableView = [[UITableView alloc] initWithFrame: CGRectMake(15, 50, 255, 225)];
    popUpBoxTableView.delegate = self;
    popUpBoxTableView.dataSource = self;
    
    // 添加一个alertView
    myAlertView = [[UIAlertView alloc] initWithTitle: @"请选择一个单位" message: @"\n\n\n\n\n\n\n\n\n\n\n" delegate: nil cancelButtonTitle: @"取消" otherButtonTitles: nil];
    [myAlertView addSubview: popUpBoxTableView];
}

- (void)viewDidUnload
{
    [self setFrom_currency_button:nil];
    [self setTo_currency_button:nil];
    [self setCurrent_rate:nil];
    [self setExchange_munber:nil];
    [self setResultLabel:nil];
    [self setResultLabel_2:nil];
    [self setResultLabel_3:nil];
    [self setXmlRead:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)popCurrencyWindow:(id)sender {
    NSArray *boxData = [[NSArray alloc] initWithObjects: @"美元-USD", @"人民币-CNY", @"港币-HKD", @"欧元-EUR", @"英镑-GBP", @"日元-JPY", @"韩元-KRW", @"加拿大元-CAD", @"印度卢比-INR", @"俄罗斯卢布-RUB", @"泰铢-THB", @"越南盾-IDR", nil];
    self.dataSource=boxData;
    
    button=sender;//sender是UIButton
    
    [self.myAlertView show];
}
- (void)dealloc {
    [from_currency_button release];
    [to_currency_button release];
    [current_rate release];
    [exchange_munber release];
    [resultLabel release];
    [resultLabel_2 release];
    [super dealloc];
}
- (IBAction)backgroundTap:(id)sender {
    [exchange_munber resignFirstResponder];
}

- (IBAction)onValueChanged:(id)sender{
    [xmlRead parse];
    double rate=to_rate/from_rate;
    current_rate.text=[NSString stringWithFormat:@"1 : %.2f%", rate];
    
    //计算结果输出
    NSString *fromCurrency=from_currency_button.titleLabel.text;
    NSString *toCurrency=to_currency_button.titleLabel.text;
    if([exchange_munber.text doubleValue]==0){//用户没有填入金额的情况
        exchange_munber.text=@"1";
    }
    double result=[exchange_munber.text doubleValue]*rate;
    NSString *resultText=[[NSString alloc] initWithFormat:@"%@ %@",exchange_munber.text,[toCurrency stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    NSString *resultText2=[[NSString alloc] initWithFormat:@"%@ %@",[NSString stringWithFormat:@"%.2f%", result],fromCurrency];
    resultLabel.text=resultText;
    resultLabel_2.text=resultText2;
    resultLabel_3.text=@"=";
}

- (IBAction)exchange:(id)sender {
//    NSString *string1=[[NSBundle mainBundle] bundlePath];
//    NSString *xmlText=[[NSString alloc] initWithFormat:@"%@/rate.xml", string1];
//    NSData *xmlData = [[NSData alloc] initWithContentsOfFile:xmlText];
//    NSXMLParser* xmlRead = [[NSXMLParser alloc] initWithData:xmlData];

    [xmlRead parse];
    double rate=from_rate/to_rate;
    current_rate.text=[NSString stringWithFormat:@"1 : %.2f%", rate];
    
    //计算结果输出
    NSString *fromCurrency=from_currency_button.titleLabel.text;
    NSString *toCurrency=to_currency_button.titleLabel.text;
    if([exchange_munber.text doubleValue]==0){//用户没有填入金额的情况
        exchange_munber.text=@"1";
    }
    double result=[exchange_munber.text doubleValue]*rate;
    NSString *resultText=[[NSString alloc] initWithFormat:@"%@ %@",exchange_munber.text,[fromCurrency stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    NSString *resultText2=[[NSString alloc] initWithFormat:@"%@ %@",[NSString stringWithFormat:@"%.2f%", result],toCurrency];
    resultLabel.text=resultText;
    resultLabel_2.text=resultText2;
    resultLabel_3.text=@"=";

}




- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    NSString * fromLabelText=[from_currency_button.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString * toLabelText=[to_currency_button.titleLabel.text stringByReplacingOccurrencesOfString:@" " withString:@""]; 
 
    if([elementName isEqualToString: [fromLabelText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]])
    {
        NSString* rate=[attributeDict valueForKey:@"value"];
        from_rate=[rate doubleValue];
        NSLog(@"key：%@,value：%@", elementName,rate);
    }else if([elementName isEqualToString: [toLabelText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]]){
        NSString* rate=[attributeDict valueForKey:@"value"];
        to_rate=[rate doubleValue];
        NSLog(@"key：%@,value：%@", elementName,rate);
    }
    
    
}

#pragma mark table data source delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {	
	int n = [dataSource count];
	return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"SimpleTableIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
	NSString *text = [dataSource objectAtIndex:indexPath.row];
	cell.textLabel.text = text;
	cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
	
	return cell;
}
#pragma mark tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 35.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// 点击使alertView消失
	NSUInteger cancelButtonIndex = myAlertView.cancelButtonIndex;
	[myAlertView dismissWithClickedButtonIndex: cancelButtonIndex animated: YES];
	NSString *selectedCellText = [dataSource objectAtIndex:indexPath.row];	
    button.titleLabel.text=selectedCellText;
	
}
@end
