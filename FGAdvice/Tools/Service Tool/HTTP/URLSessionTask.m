//
//  URLSessionTask.m
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "URLSessionTask.h"

@interface URLSessionTask ()

@property (nonatomic, strong) NSMutableData *mutableData;

@end

@implementation URLSessionTask

- (instancetype)initWithTask:(NSURLSessionTask *)task completion:(DataTaskCompletion)block
{
    self = [super init];
    if (self)
    {
        _sessionTask = task;
        _completionBlock = [block copy];
    }
    return self;
}

-(instancetype)init {
  
  self = [self initWithTask:nil completion:nil];
  
  return self;
}

- (NSData *)data
{
    return [self.mutableData copy];
}

- (void)appendData:(NSData *)data
{
    if (!self.mutableData)
    {
        self.mutableData = [NSMutableData data];
    }
    [self.mutableData appendData:data];
}

@end
