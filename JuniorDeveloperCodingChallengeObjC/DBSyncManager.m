//
//  DBSyncManager.m
//  JuniorDeveloperCodingChallengeObjC
//
//  This class will allow the other classes to better interface with the Sync API
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>

#import "DBSyncManager.h"

@interface DBSyncManager ()

@property (strong, nonatomic) DBAccount *userDBAccount;
@property NSMutableArray *newlyUploadedImages; // this array will contain uploaded images so they do not need to be redownloaded

@end

@implementation DBSyncManager

+(DBSyncManager*) getSharedInstance {
    static DBSyncManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

-(id) init {
    self.userDBAccount = [[DBAccountManager sharedManager] linkedAccount];
    if (self.userDBAccount) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:self.userDBAccount];
        [DBFilesystem setSharedFilesystem:filesystem];
    }
    return self;
}

+(BOOL) isAuthenticated {
    return [[DBAccountManager sharedManager] linkedAccount];
}

// This will get the file extension
- (NSString*)getExtension:(NSString*)path {
    NSInteger index = path.length - 1;
    while ([path characterAtIndex:index] != '.') {
        index--;
    }
    return [path substringFromIndex:index];
}

// This will check that the file is one of the image types supported by dropbox
- (BOOL)isImage:(NSString*)path {
    NSString *extension = [self getExtension:path];
    return ([extension  isEqualToString: @".bmp"] || [extension isEqualToString:@".cr2"] || [extension isEqualToString:@".gif" ] || [extension isEqualToString:@".ico"] || [extension isEqualToString:@".ithmb"]
            || [extension isEqualToString:@".jpeg"] || [extension isEqualToString:@".jpg"] || [extension isEqualToString:@".nef"] || [extension isEqualToString:@".png"] || [extension isEqualToString:@".raw"] || [extension isEqualToString:@".svg"] || [extension isEqualToString:@".tif"] || [extension isEqualToString:@".tiff"] || [extension isEqualToString:@".wbmp"] || [extension isEqualToString:@".webp"]);
}

// This will retrieve an array of images
-(NSArray*) getImages {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    NSArray *files = [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil];

    for (DBFileInfo *info in files) {
        if ([self isImage:[[info path] stringValue]])
        {
            DBFile *file = [[DBFilesystem sharedFilesystem] openFile:[info path] error:nil];
            if (file.status.cached)
                [images addObject:[UIImage imageWithData:[file readData:nil]]];
        }
    }
    
    return images;
}
/*
-(NSArray*) getCoordinates {
    NSMutableArray *coordinates = [[NSMutableArray alloc] init];
    NSArray *files = [[DBFilesystem sharedFilesystem] listFolder:[DBPath root] error:nil];
    
    for (DBFileInfo *info in files) {
        if ([self isImage:[[info path] stringValue]])
        {
            DBFile *file = [[DBFilesystem sharedFilesystem] openFile:[info path] error:nil];
            if (file.status.cached)
            {
                CGImageSourceRef source = CGImageSourceCreateWithData( (CFDataRef) [file readData:nil], NULL);
                NSDictionary* metadata = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
                [coordinates addObject:metadata];
            }
        }
    }
    return coordinates;
}
*/


- (void)sendImage:(UIImage*)image
{
    NSData *imageData = UIImageJPEGRepresentation(image, 0.6);
    DBPath *newPath = [[DBPath root] childPath:[NSString stringWithFormat:@"image_%i.jpg", arc4random()]];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    [file writeData:imageData error:nil];
    [self.newlyUploadedImages addObject:image];
}

- (void)emptyNewlyUploadedImages {
    [self.newlyUploadedImages removeAllObjects];
}

-(NSArray*)getNewlyUploadedImages {
    return self.newlyUploadedImages;
}













@end