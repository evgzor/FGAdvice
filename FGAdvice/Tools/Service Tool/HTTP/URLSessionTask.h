//
//  URLSessionTask.h
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DataTaskCompletion)(NSData *data, NSError *error);

@interface URLSessionTask : NSObject

@property (nonatomic, weak) NSMutableURLRequest *request;
@property (nonatomic, strong, readonly) NSURLSessionTask *sessionTask;
@property (nonatomic, copy, readonly) DataTaskCompletion completionBlock;

@property (nonatomic, copy, readonly) NSData *data;

- (instancetype)initWithTask:(NSURLSessionTask *)task completion:(DataTaskCompletion)block NS_DESIGNATED_INITIALIZER;

- (void)appendData:(NSData *)data;

@end
