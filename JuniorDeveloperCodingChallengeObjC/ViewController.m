//
//  ViewController.m
//  JuniorDeveloperCodingChallengeObjC
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import "ViewController.h"
#import "DBSyncManager.h"
#import <Dropbox/Dropbox.h>

@interface ViewController ()

@property (nonatomic, retain) IBOutlet UIButton* linkButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([DBSyncManager isAuthenticated]) {
        [self performSegueWithIdentifier:@"Authenticated" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPressLink {
    [[DBAccountManager sharedManager] linkFromController:self];
    [self performSegueWithIdentifier:@"Authenticated" sender:self];
}

@end
