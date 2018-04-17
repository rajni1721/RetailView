//
//  ViewController.m
//  RetailView
//
//  Created by Babu on 4/13/18.
//  Copyright © 2018 Babu. All rights reserved.
//

#import "LoginViewController.h"
#import <ASIHTTPRequest.h>
#import <Reachability.h>
#import "HomeViewController.h"
#import <SVProgressHUD.h>


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
    
- (IBAction)forgetButtonPressed:(id)sender {
}
    
- (IBAction)LoginButtonPressed:(id)sender {
    
    if([self.nameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""]) {
        
        [self showAlertWithTitle:@"" andMessage:@"Please enter username and password"];
    }
    else {
        
        NSString *soapBodyMessage = [NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                                 "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                                 "<soap:Body>"
                                 "<DoLogin xmlns=\"h8SSRMSAPI\">"
                                 "<Request>"
                                 "<requestDate>1990-06-09T12:07:55</requestDate>"
                                 "<extTransactionId>-99999</extTransactionId>"
                                 "<systemId>apiuser</systemId>"
                                 "<password>apiuser@123</password>"
                                 "</Request>"
                                 "<UserName>%@</UserName>"
                                 "<Password>%@</Password>"
                                 "</DoLogin>"
                                 "</soap:Body>"
                                 "</soap:Envelope>", self.nameTextField.text, self.passwordTextField.text];
        
        
        NSURL *url = [NSURL URLWithString:@"http://h8admin.worldphone.in/api/worldphonesubscriberAPI.asmx"];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
        
        NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[msgLength length]];
        
        //
        // Setting headers
        [theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [theRequest addValue: @"http://h8admin.worldphone.in/api/worldphonesubscriberAPI.asmx?op=DoLogin" forHTTPHeaderField:@"DoLogin"];
        [theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
        
        //
        // Setting body
        [theRequest setHTTPMethod:@"POST"];
        [theRequest setHTTPBody: [soapBodyMessage dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
        [theConnection start];
        [SVProgressHUD showWithStatus:@"Authenticating..."];
    }
    
}
    
- (void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}
    
- (void)parseData:(NSData *)myData {
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:myData];
    xmlParser.delegate = self;
    
    // Run the parser
    @try{
        BOOL parsingResult = [xmlParser parse];
        if (parsingResult) {
            NSLog(@"%@", userInfoDictionary);
            [self goToHomeScreen:userInfoDictionary];
        }
        // NSLog(parsingResult ? @"Yes" : @"No");
    }
    @catch (NSException* exception)
    {
        [self showAlertWithTitle:@"Server Error!" andMessage:@"Data could not parse."];
        return;
    }

}
    
- (void)goToHomeScreen:(NSDictionary *)userInfo
{
    HomeViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    homeViewController.userInfoDictionary = userInfo;
    [self.navigationController pushViewController:homeViewController animated:YES];
}

#pragma mark - NSURLConnectionDelegate Methods
    
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    webResponseData = [NSMutableData data];
    userInfoDictionary = [NSMutableDictionary dictionary];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webResponseData appendData:data];
}
    
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Some error in your Connection. Please try again.");
}
    
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [SVProgressHUD dismiss];
    NSLog(@"Received %lu Bytes", (unsigned long)[webResponseData length]);
    
    [self parseData:webResponseData];
}
    
    
#pragma mark - NSXMLParserDelegate Methods
    
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    keyString = elementName;
}
    
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    // NSLog(@"%@ : %@", keyString, string);
    [userInfoDictionary setValue:string forKey:keyString];
}
    
    
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}
    
    
    
@end















