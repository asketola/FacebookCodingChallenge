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
  [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
  
    // check to see if we are already logged in if not, then login in
  if ([FBSDKAccessToken currentAccessToken]) {
    _uploadImagesButton.enabled = YES;
    [_loginToFbButton setTitle:@"Logout" forState:UIControlStateNormal];
  } else {
    _uploadImagesButton.enabled = NO;
    [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
    [_loginToFbButton.titleLabel setFont:[UIFont boldSystemFontOfSize:28]];
  }

} // close viewdidload


- (IBAction)loginToFbButtonPressed:(id)sender {

  if ([FBSDKAccessToken currentAccessToken]) {
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    [FBSDKProfile setCurrentProfile:nil];
//    [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
    
  } else  {
  FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
  [login logInWithReadPermissions:@[@"public_profile"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    _uploadImagesButton.enabled = YES;
    [_loginToFbButton setTitle:@"Logout" forState:UIControlStateNormal];
    if (error) {
      // Process error
      NSLog(@"Error message: %@", error);
      [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
      _uploadImagesButton.enabled = NO;
    } else if (result.isCancelled) {
      // Handle Cancellations - send AlertController to say we need access??
      _uploadImagesButton.enabled = NO;
      [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
    } else {
      // If you ask for multiple permissions once, you should should check if specific permissions missing
      if ([result.grantedPermissions containsObject:@"public_profile"]) {
        // Do work
      }
    }
  }];
  } // close else
} // close loginFB button

- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBSDKAppEvents activateApp];
}



- (void)logOut {
  // reset the token to nil, so that i logsout, can't figure out how to get to work
  [FBSDKAccessToken setCurrentAccessToken:nil];
  [FBSDKProfile setCurrentProfile:nil];
  [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
  
}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
