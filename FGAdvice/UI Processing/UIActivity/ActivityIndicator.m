//
//  ActivityIndicator.m
//  FGAdvice
//
//  Created by Eugene Zorin on 12/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ActivityIndicator.h"
@import UIKit;

@interface ActivityIndicator()

@property (nonatomic, strong, readonly, nonnull) dispatch_queue_t privateQueue;
@property (nonatomic) NSInteger activeNetworkingTaskCount;

@end


@implementation ActivityIndicator

- (dispatch_queue_t)privateQueue
{
  if (!_privateQueue)
  {
    _privateQueue = dispatch_queue_create([NSStringFromClass([self class]) cStringUsingEncoding:NSUTF8StringEncoding], NULL);
  }
  return _privateQueue;
}

@synthesize privateQueue = _privateQueue;

- (void)setActiveNetworkingTaskCount:(NSInteger)activeNetworkingTaskCount
{
  if (_activeNetworkingTaskCount == 0 && activeNetworkingTaskCount != 0)
  {
    //Start activity
    dispatch_async(dispatch_get_main_queue(), ^{
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    });
  } else if (_activeNetworkingTaskCount != 0 && activeNetworkingTaskCount == 0)
  {
    //Finish activiy
    dispatch_async(dispatch_get_main_queue(), ^{
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    });
  }
  _activeNetworkingTaskCount = (activeNetworkingTaskCount >= 0) ? activeNetworkingTaskCount : 0;
}

- (void)startIndication
{
  dispatch_sync(self.privateQueue, ^{
    self.activeNetworkingTaskCount++;
  });
}

- (void)stopIndication
{
  dispatch_sync(self.privateQueue, ^{
    self.activeNetworkingTaskCount--;
  });
}

+ (instancetype)sharedIndicator
{
  static id sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[[self class] alloc] init];
  });
  return sharedInstance;
}


@end
