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
  
    // added styling features to our UIButtons
  _uploadImagesButton.layer.cornerRadius = 10.0;
  _loginToFbButton.layer.cornerRadius = 10.0;
  _loginToFbButton.enabled = YES;
  [FBSDKProfile enableUpdatesOnAccessTokenChange:YES];
  NSLog(@"ViewDidLoad - Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
  
    // check to see if we are already logged in, set the appropriate enablement of the uploadImagesButton and title to the loginToFbButtton
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
    // If we are logged in, the button should be set to let the user logout
    NSLog(@"If statement (there is - should be yes) - Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
      FBSDKLoginManager *logOut = [[FBSDKLoginManager alloc]init];
      [logOut logOut];
        NSLog(@"Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
    [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
    _uploadImagesButton.enabled = NO;
    
  } else  {
  // If we are logged out, the button should be set to log the user in
  NSLog(@"Else (should be no token) - Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
  FBSDKLoginManager *login = [[FBSDKLoginManager alloc]init];
  [login logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    _uploadImagesButton.enabled = YES;
    
     NSLog(@"After LoginManager login (should be yes) - Is there a token? %@", [FBSDKAccessToken currentAccessToken]);
    [_loginToFbButton setTitle:@"Logout" forState:UIControlStateNormal];
    NSLog(@"Permissions granted = %@", result.grantedPermissions);
    if (error) {
      // Process error
      NSLog(@"Error message: %@", error);
      [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
      _uploadImagesButton.enabled = NO;
    } else if (result.isCancelled) {
      // Handle Cancellations - send AlertController to say we need access??
      _uploadImagesButton.enabled = NO;
      [_loginToFbButton setTitle:@"Login To Facebook" forState:UIControlStateNormal];
    }
    
    // this code is in case we want to ask for all the permissions up front. Facebook recommends we seperate them out to locations only when we need them
    // else {
//      // If you ask for multiple permissions once, you should should check if specific permissions missing
//      if ([result.grantedPermissions containsObject:@"publish_actions"]) {
//        [login logInWithReadPermissions:@[@"user_photos"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//          if (error) {
//            // process error
//          } else if (result.isCancelled) {
//            NSLog(@"Error message: %@", error);
//          } else {
//            if ([result.grantedPermissions containsObject:@"user_photos"]) {
//              NSLog(@"Permissions granted = %@", result.grantedPermissions);
//            }
//          }
//        }];
//      }
//    }
  }];
  } // close else
} // close loginFB button


-(IBAction)prepareForUnwind:(UIStoryboardSegue *)segue {
  // Connects the done button on the 3rd page back to here
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
