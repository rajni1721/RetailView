//
//  ViewController.h
//  RetailView
//
//  Created by Babu on 4/13/18.
//  Copyright © 2018 Babu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ASIHTTPRequest.h>
#import <Reachability.h>

@interface LoginViewController : UIViewController <NSURLConnectionDataDelegate, NSXMLParserDelegate>
    {
        NSMutableData *webResponseData;
        NSMutableDictionary *userInfoDictionary;
        NSString *keyString;
    }
    
    @property (weak, nonatomic) IBOutlet UITextField *nameTextField;
    @property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
- (IBAction)forgetButtonPressed:(id)sender;
- (IBAction)LoginButtonPressed:(id)sender;
    @property (weak, nonatomic) IBOutlet UITextField *userTextField;
    
    
@end

