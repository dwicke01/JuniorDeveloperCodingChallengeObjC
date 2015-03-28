//
//  CameraViewController.m
//  JuniorDeveloperCodingChallengeObjC
//
//  Created by Daniel Wickes on 3/27/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@property DBSyncManager *syncManager;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *uploadPhoto;
- (IBAction)uploadPhoto:(id)sender;

@end

@implementation CameraViewController

-(void) viewDidLoad {
    self.syncManager = [DBSyncManager getSharedInstance];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)uploadPhoto:(id)sender {
    [self.syncManager sendImage:self.imageView.image];
    self.imageView.image = nil;
}
@end
