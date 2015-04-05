//
//  ViewController.m
//  FacebookCodingChallenge
//
//  Created by Annemarie Ketola on 4/2/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  _uploadImagesButton.layer.cornerRadius = 10.0;
  _loginToFbButton.layer.cornerRadius = 10.0;
  _uploadImagesButton.enabled = NO;
  [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
  [_loginToFbButton.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
  
//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
//  
  
} // close viewdidload


- (IBAction)loginToFbButtonPressed:(id)sender {

  
  FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
  [login logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    _uploadImagesButton.enabled = YES;
    if (error) {
      // Process error
      NSLog(@"Error message: %@", error);
      _uploadImagesButton.enabled = NO;
    } else if (result.isCancelled) {
      // Handle Cancellations - send AlertController to say we need access??
      _uploadImagesButton.enabled = NO;
    } else {
      // If you ask for multiple permissions once, you should should check if specific permissions missing
      if ([result.grantedPermissions containsObject:@"public_profile"]) {
        // Do work
      }
    }
  }];
  
  if ([FBSDKAccessToken currentAccessToken]) {
}
  
} // close loginFB button



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
