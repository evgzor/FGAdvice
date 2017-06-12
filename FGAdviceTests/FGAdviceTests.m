//
//  FGAdviceTests.m
//  FGAdviceTests
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NetworkClient+LoadAdvice.h"
#import "FGAFavouritesService.h"

@interface FGAdviceTests : XCTestCase
@property __block NSInteger _recordsCount;
@end

@implementation FGAdviceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testLoadDataFromWeb {
  NetworkClient* httpClient = [[NetworkClient alloc] init];
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"web request"];
  
  [httpClient loadRandomAdviceWithCompletionHandler:^(FGAModel *advice, NSError *error) {
    XCTAssertEqual(error.code, 0);
    XCTAssertNotEqual(advice.text.length, 0);
    XCTAssertNotEqual(advice.idx, 0);
    [expectation fulfill];
  }];
  
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
    
      if(error)
        {
          XCTFail(@"Expectation Failed with error: %@", error);
        }
    
  }];
}

-(void) testAddCoreDataRequests {
  FGAFavouritesService* service = [FGAFavouritesService sharedService];
  
  NSDictionary* data = @{@"id" : @(100), @"text": @"test", @"sound" : @"sound test"};
  
  FGAModel* model = [[FGAModel alloc] initModelWithDictionary: data];
  
  [service addToFavourites: model];
  __recordsCount = 0;
  XCTestExpectation *expectation = [self expectationWithDescription:@"db request"];
  [service loadFavouritesWithCompletionHandler:^(NSArray<FGAModel *> *advices) {
    XCTAssertNotEqual(advices.count, 0);
    __recordsCount = advices.count;
    [expectation fulfill];
  }];
  
  [self waitForExpectationsWithTimeout:1.0 handler:^(NSError *error) {
    
    if(error)
    {
      XCTFail(@"Expectation Failed with error: %@", error);
    }
    
  }];
}

-(void) testRemoveCoreDataRequests {
  
  XCTestExpectation *expectation = [self expectationWithDescription:@"db model remove"];
  
  FGAFavouritesService* service = [FGAFavouritesService sharedService];
  NSDictionary* data = @{@"id" : @(100), @"text": @"test", @"sound" : @"sound test"};
  
  FGAModel* model = [[FGAModel alloc] initModelWithDictionary: data];
  
  [service removeFromFavourites:model];
  
  [service loadFavouritesWithCompletionHandler:^(NSArray<FGAModel *> *advices) {
    XCTAssertNotEqual(advices.count, __recordsCount - 1);
    [expectation fulfill];
  }];
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {

      if(error)
      {
        XCTFail(@"Expectation Failed with error: %@", error);
      }
      
    }];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
