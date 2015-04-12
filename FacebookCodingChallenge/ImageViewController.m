//
//  ImageViewController.m
//  FacebookCodingChallenge
//
//  Created by Annemarie Ketola on 4/2/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

#import "ImageViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>


@import Photos;

@interface ImageViewController () <PHPhotoLibraryChangeObserver>
@property (strong) NSArray *collectionsFetchResults;
@property (nonatomic) UIImage *image1;
@property (nonatomic) UIImage *image2;
@property (nonatomic) UIImage *image3;
@property (nonatomic) UIImage *image4;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
    NSLog(@"we have publish permissions");
    // TODO: publish content.
  }
  uploadToFbButton.layer.cornerRadius = 10.0;
//  uploadToFbButton.backgroundColor = [UIColor lightGrayColor];
  uploadToFbButton.enabled = NO;

  [button1 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button1.layer.cornerRadius = 10.0f;
  [button1.layer setMasksToBounds:YES];
  
  [button2 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button2.layer.cornerRadius = 10.0f;
  [button2.layer setMasksToBounds:YES];
  button2.enabled = NO;
  
  [button3 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button3.layer.cornerRadius = 10.0f;
  [button3.layer setMasksToBounds:YES];
  button3.enabled = NO;
  
  [button4 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button4.layer.cornerRadius = 10.0f;
  [button4.layer setMasksToBounds:YES];
  button4.enabled = NO;
  
  NSString *title = @"OfferUp";
  _assetCollection = [self albumWithTitle:title];
  
  if(self.assetCollection){
    // Album exists
  } else {
    // Need to create OfferUp album
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title];
    } completionHandler:^(BOOL success, NSError *error) {
      if (!success) {
        NSLog(@"Error creating album: %@", error);
      } else {
        NSLog(@"album created");
        _assetCollection = [self albumWithTitle:title];
      }
    }];
  }
} // close viewDidLoad


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButton1Pressed:(id)sender {
  // Ask the user to pick an album cover
  UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select an Album Cover" preferredStyle:UIAlertControllerStyleAlert];
  UIAlertAction* OK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    [view dismissViewControllerAnimated:YES completion:nil];
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    // check to see what device our user has and have them pick which source from the actionSheet
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
      UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
      UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [imagePicker setDelegate:self];
        _type = @"camera";
        [self presentViewController:imagePicker animated:YES completion:nil];
      }];
      UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [imagePicker setDelegate:self];
        _type = @"gallery";
        [self presentViewController:imagePicker animated:YES completion:nil];
      }];
      UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [view dismissViewControllerAnimated:YES completion:nil];
      }];
      
      [view addAction:Camera];
      [view addAction:PhotoGallery];
      [view addAction:Cancel];
      [self presentViewController:view animated:YES completion:nil];
      
    } else {
      // if no camera, set source to PhotoLibrary
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
      _type = @"gallery";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }
    
    _buttonNumber = 1;
  }];
  [view addAction:OK];
  [self presentViewController:view animated:YES completion:nil];
  

} // end button1 action

- (IBAction)imageButton2Pressed:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      _type = @"camera";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
      _type = @"gallery";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [view addAction:Camera];
    [view addAction:PhotoGallery];
    [view addAction:Cancel];
    [self presentViewController:view animated:YES completion:nil];
    
  } else {
    // if no camera, set source to PhotoLibrary
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setDelegate:self];
    _type = @"gallery";
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
  _buttonNumber = 2;
} // end button2 action

- (IBAction)imageButton3Pressed:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      _type = @"camera";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
      _type = @"gallery";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [view addAction:Camera];
    [view addAction:PhotoGallery];
    [view addAction:Cancel];
    [self presentViewController:view animated:YES completion:nil];
    
  } else {
    // if no camera, set source to PhotoLibrary
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setDelegate:self];
    _type = @"gallery";
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
  _buttonNumber = 3;
} // end button3 action

- (IBAction)imageButton4Pressed:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      _type = @"camera";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
      _type = @"gallery";
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [view addAction:Camera];
    [view addAction:PhotoGallery];
    [view addAction:Cancel];
    [self presentViewController:view animated:YES completion:nil];
    
  } else {
    // if no camera, set source to PhotoLibrary
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [imagePicker setDelegate:self];
    _type = @"gallery";
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
  _buttonNumber = 4;
} // end button4 action

- (IBAction)uploadToFBButtonPressed:(id)sender {
  
  // Checking for FB permissions first, Facebook now wants you to get specific permissions only when you need them, at specific times when you will use them
  if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"user_photos"]) {
    // publish content/send our photo album
    NSLog(@"we checked if we had access and we do");
  } else {
    NSLog(@"we do not have permission");
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"This app needs permission to post photos to Facebook" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Get_Permission = [UIAlertAction actionWithTitle:@"Get Permission" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      // put code to get "user_photos" permission from Facebook
          FBSDKLoginManager *loginManger = [[FBSDKLoginManager alloc]init];
          [loginManger logInWithReadPermissions:@[@"user_photos"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
            NSLog(@"we did not get permission because: %@", error);
          }];
    }];
    UIAlertAction* Cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [view dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [view addAction:Get_Permission];
    [view addAction:Cancel];
    [self presentViewController:view animated:YES completion:nil];
  }
  
  if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
    if (_image1 != nil) {
      FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
      photo.image = _image1;
      photo.userGenerated = YES;
      FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
      content.photos = @[photo];
      [FBSDKShareAPI shareWithContent:content delegate:nil];
      
    } if (_image2 != nil) {
      FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
      photo.image = _image2;
      photo.userGenerated = YES;
      FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
      content.photos = @[photo];
      [FBSDKShareAPI shareWithContent:content delegate:nil];
      
    } if (_image3 != nil) {
      FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
      photo.image = _image3;
      photo.userGenerated = YES;
      FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
      content.photos = @[photo];
      [FBSDKShareAPI shareWithContent:content delegate:nil];
      
    } if (_image4 != nil) {
      FBSDKSharePhoto *photo = [[FBSDKSharePhoto alloc] init];
      photo.image = _image4;
      photo.userGenerated = YES;
      FBSDKSharePhotoContent *content = [[FBSDKSharePhotoContent alloc]init];
      content.photos = @[photo];
      [FBSDKShareAPI shareWithContent:content delegate:nil];
    }
  }
} // close uploadbutton action

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  _image = [info objectForKey:UIImagePickerControllerOriginalImage];
  NSLog(@"We got here");
// not sure why this doesn't work
//  PHAssetChangeRequest *createAssetRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:_image];
  NSLog(@"type: %@", _type);
  if ([_type isEqualToString:@"gallery"]) {
  // creates PHasset from photo gallery
  NSURL *url = [info objectForKey:@"UIImagePickerControllerReferenceURL"];
  PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[url] options:nil];
  NSLog(@"result %@", result);
  _asset = result.firstObject;
    NSLog(@"asset from photo gallery: %@", _asset);
  } else if ([_type isEqualToString:@"camera"]){
  // creates PHasset for image from camera
  _asset = [info objectForKey:UIImagePickerControllerMediaMetadata];
  NSLog(@"We created an asset from camera: %@", _asset);
  }

  // Add PHAsset to the photo library
  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    NSLog(@"We got here");
    PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:_assetCollection];
//    PHObjectPlaceholder *assetPlaceholder = [createAssetRequest placeholderForCreatedAsset];
//    [changeRequest addAssets:@[assetPlaceholder]];
    [changeRequest addAssets:@[_asset]];
  } completionHandler:^(BOOL success, NSError *error) {
      if (success){
        NSLog(@"Success saving picture to album");
      } else {
        NSLog(@"Error creating asset: %@", error);
      }
    }];
  
  // puts image on the thumbnail back on the screen
  if (_buttonNumber == 1) {
    [button1 setBackgroundImage:_image forState:UIControlStateNormal];
    self.image1 = _image;
    button1.layer.cornerRadius = 10.0;
    [button1.layer setMasksToBounds:YES];
    button2.enabled = YES;
  } else if (_buttonNumber == 2) {
    [button2 setBackgroundImage:_image forState:UIControlStateNormal];
    self.image2 = _image;
    button2.layer.cornerRadius = 10.0;
    [button2.layer setMasksToBounds:YES];
    button3.enabled = YES;
  } else if (_buttonNumber == 3) {
    [button3 setBackgroundImage:_image forState:UIControlStateNormal];
    self.image3 = _image;
    button3.layer.cornerRadius = 10.0;
    [button3.layer setMasksToBounds:YES];
    button4.enabled = YES;
  } else if (_buttonNumber == 4) {
    [button4 setBackgroundImage:_image forState:UIControlStateNormal];
    self.image4 = _image;
    button4.layer.cornerRadius = 10.0;
    [button4.layer setMasksToBounds:YES];
  }

  [self dismissViewControllerAnimated:YES completion:nil];
//  NSLog(@"The picture Dictionary: %@", info);
    uploadToFbButton.enabled = YES;
}

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
  // Call might come on any background queue. Re-dispatch to the main queue to handle it.
  dispatch_async(dispatch_get_main_queue(), ^{
    
    NSMutableArray *updatedCollectionsFetchResults = nil;
    
    for (PHFetchResult *collectionsFetchResult in self.collectionsFetchResults) {
      PHFetchResultChangeDetails *changeDetails = [changeInstance changeDetailsForFetchResult:collectionsFetchResult];
      if (changeDetails) {
        if (!updatedCollectionsFetchResults) {
          updatedCollectionsFetchResults = [self.collectionsFetchResults mutableCopy];
        }
        [updatedCollectionsFetchResults replaceObjectAtIndex:[self.collectionsFetchResults indexOfObject:collectionsFetchResult] withObject:[changeDetails fetchResultAfterChanges]];
      }
    }
    
  });
}

-(PHAssetCollection*)albumWithTitle:(NSString*)title{
  // Check if album exists. If not, create it.
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"localizedTitle = %@", title];
  PHFetchOptions *options = [[PHFetchOptions alloc]init];
  options.predicate = predicate;
  PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:options];
  if(result.count){
    return result[0];
  }
  return nil;
  
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
