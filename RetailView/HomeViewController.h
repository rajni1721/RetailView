//
//  HomeViewController.h
//  RetailView
//
//  Created by Babu on 4/14/18.
//  Copyright © 2018 Babu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController
    
@property (strong, nonatomic) NSString *nameString;
@property (strong, nonatomic) NSDictionary *userInfoDictionary;
    
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
