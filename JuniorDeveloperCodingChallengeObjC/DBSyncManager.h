//
//  DBSyncManager.h
//  JuniorDeveloperCodingChallengeObjC
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#ifndef JuniorDeveloperCodingChallengeObjC_DBSyncManager_h
#define JuniorDeveloperCodingChallengeObjC_DBSyncManager_h

#import <Dropbox/Dropbox.h>

@interface DBSyncManager : NSObject

+(DBSyncManager*) getSharedInstance;
+(BOOL) isAuthenticated;
-(NSArray*) getImages;
-(void) sendImage:(UIImage*)image;
-(void)emptyNewlyUploadedImages;
-(NSArray*)getNewlyUploadedImages;
@end

#endif
