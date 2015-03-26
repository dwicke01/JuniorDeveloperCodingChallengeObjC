//
//  ViewController.m
//  JuniorDeveloperCodingChallengeObjC
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import "ViewController.h"
#import <Dropbox/Dropbox.h>

@interface ViewController ()

@property (strong, nonatomic) DBAccount *userDBAccount;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.userDBAccount = [[DBAccountManager sharedManager] linkedAccount];
    if (self.userDBAccount) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:self.userDBAccount];
        [DBFilesystem setSharedFilesystem:filesystem];
        [self.linkButton setEnabled:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didPressLink {
    [[DBAccountManager sharedManager] linkFromController:self];
    [self.linkButton setEnabled:NO];
}

/*
- (void)updateButtons {
    NSString* title = [[DBSession sharedSession] isLinked] ? @"Unlink Dropbox" : @"Link Dropbox";
    [self.linkButton setTitle:title forState:UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem.enabled = [[DBSession sharedSession] isLinked];
}
 */

@end
