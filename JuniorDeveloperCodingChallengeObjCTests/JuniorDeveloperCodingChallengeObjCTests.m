//
//  JuniorDeveloperCodingChallengeObjCTests.m
//  JuniorDeveloperCodingChallengeObjCTests
//
//  Created by Daniel Wickes on 3/26/15.
//  Copyright (c) 2015 danielwickes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

@interface JuniorDeveloperCodingChallengeObjCTests : XCTestCase

@end

@implementation JuniorDeveloperCodingChallengeObjCTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end