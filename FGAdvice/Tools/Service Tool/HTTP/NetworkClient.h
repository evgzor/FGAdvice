//
//  WebClient.h
//  testTask
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLSessionTask.h"

@interface NetworkClient : NSObject <NSURLSessionDelegate>


- (void)startDataTaskWithRequest:(NSMutableURLRequest *)request completionHandler:(DataTaskCompletion)completionHandler;
- (void)cancel;

@end
