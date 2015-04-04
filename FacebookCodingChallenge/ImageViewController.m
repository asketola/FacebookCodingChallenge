//
//  ImageViewController.m
//  FacebookCodingChallenge
//
//  Created by Annemarie Ketola on 4/2/15.
//  Copyright (c) 2015 UpEarly. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  uploadToFbButton.layer.cornerRadius = 10.0;
  
  [button1 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button1.layer.cornerRadius = 10.0f;
  [button1.layer setMasksToBounds:YES];
  
  [button2 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button2.layer.cornerRadius = 10.0f;
  [button2.layer setMasksToBounds:YES];
  
  [button3 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button3.layer.cornerRadius = 10.0f;
  [button3.layer setMasksToBounds:YES];
  
  [button4 setBackgroundImage:[UIImage imageNamed:@"Unknown.png"] forState:UIControlStateNormal];
  button4.layer.cornerRadius = 10.0f;
  [button4.layer setMasksToBounds:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)imageButton1Pressed:(id)sender {

  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
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
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
  
  _buttonNumber = 1;
} // end button1 action

- (IBAction)imageButton2Pressed:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
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
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
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
    [self presentViewController:imagePicker animated:YES completion:nil];
  }  _buttonNumber = 3;
} // end button3 action

- (IBAction)imageButton4Pressed:(id)sender {
  UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
  
  // check to see what device our user has and have them pick which source from the actionSheet
  if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    UIAlertController * view = [UIAlertController alertControllerWithTitle:nil message:@"Please Select Photo Source" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* Camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
      [imagePicker setDelegate:self];
      [self presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction* PhotoGallery = [UIAlertAction actionWithTitle:@"Photo Gallery" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
      [imagePicker setDelegate:self];
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
    [self presentViewController:imagePicker animated:YES completion:nil];
  }
  _buttonNumber = 4;
} // end button4 action

- (IBAction)uploadToFBButtonPressed:(id)sender {
  
  if (_info == nil) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"You have not picked any images to upload" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    
      [alert addAction:defaultAction];
      [self presentViewController:alert animated:YES completion:nil];
    
 } // close uploadbutton action
  
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  _image = [info objectForKey:UIImagePickerControllerOriginalImage];
  
  // puts image on the thumbnail back on the screen
  
  if (_buttonNumber == 1) {
    [button1 setBackgroundImage:_image forState:UIControlStateNormal];
    button1.layer.cornerRadius = 10.0;
    [button1.layer setMasksToBounds:YES];
  } else if (_buttonNumber == 2) {
    [button2 setBackgroundImage:_image forState:UIControlStateNormal];
    button2.layer.cornerRadius = 10.0;
    [button2.layer setMasksToBounds:YES];
  } else if (_buttonNumber == 3) {
    [button3 setBackgroundImage:_image forState:UIControlStateNormal];
    button3.layer.cornerRadius = 10.0;
    [button3.layer setMasksToBounds:YES];
  } else if (_buttonNumber == 4) {
    [button4 setBackgroundImage:_image forState:UIControlStateNormal];
    button4.layer.cornerRadius = 10.0;
    [button4.layer setMasksToBounds:YES];
  }

  [self dismissViewControllerAnimated:YES completion:nil];
  NSLog(@"The picture Dictionary: %@", info);

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
