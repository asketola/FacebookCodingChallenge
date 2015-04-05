//
//  ImageViewController.h
//  FacebookCodingChallenge
//
//  Created by Annemarie Ketola on 4/2/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

@interface ImageViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

{
  __weak IBOutlet UIButton *button1;
  __weak IBOutlet UIButton *button2;
  __weak IBOutlet UIButton *button3;
  __weak IBOutlet UIButton *button4;
  __weak IBOutlet UIButton *uploadToFbButton;
  
}

@property(nonatomic, strong, readonly) PHObjectPlaceholder *placeholderForCreatedAssetCollection;
@property (nonatomic) UIImagePickerControllerSourceType sourceTypeForPicker;
@property (nonatomic) UIImage *imageNumber;
@property (nonatomic, assign) int buttonNumber;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSMutableArray *imagesArray;
@property (strong, atomic) PHAssetCollection * library;

- (IBAction)imageButton1Pressed:(id)sender;
- (IBAction)imageButton2Pressed:(id)sender;
- (IBAction)imageButton3Pressed:(id)sender;
- (IBAction)imageButton4Pressed:(id)sender;


@end
