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
  _loginToFbButton.enabled = YES;
  [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
  NSLog(@"ViewDidLoad - Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
  
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
        NSLog(@"Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
    
  } else  {
  NSLog(@"We have got to the button part");
  FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
  [login logInWithPublishPermissions:@[@"publish_actions", @"photo_upload"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
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
      if ([result.grantedPermissions containsObject:@"photo_upload"]) {
        // Do work ???
      }
    }
  }];
  } // close else
} // close loginFB button



//- (void)logOut {
//  // reset the token to nil, so that i logsout, can't figure out how to get to work
//  [FBSDKAccessToken setCurrentAccessToken:nil];
//  [FBSDKProfile setCurrentProfile:nil];
//  [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
//  
//}

-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  // Connects the done button on the 3rd page back to here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
