//
//  DoneViewController.h
//  FacebookCodingChallenge
//
//  Created by Annemarie Ketola on 4/2/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoneViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

- (IBAction)doneButtonPressed:(id)sender;

@end
