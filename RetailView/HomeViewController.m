//
//  HomeViewController.m
//  RetailView
//
//  Created by Babu on 4/14/18.
//  Copyright © 2018 Babu. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    NSLog(@"%@", self.userInfoDictionary);
     
    self.nameString = [self.userInfoDictionary valueForKey:@"Name"];
    
    self.infoLabel.text = [NSString stringWithFormat:@"Welcome %@", self.nameString];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
