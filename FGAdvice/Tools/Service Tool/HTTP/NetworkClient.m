//
//  NetworkClient.m
//  testTask
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NetworkClient.h"

static NSString* const kErrorDomainString = @"Server Error";

@interface NetworkClient ()

@property (strong, nonatomic) NSURLSession *urlSession;
@property (nonatomic, strong) NSMutableArray<URLSessionTask*> *runningTasks;
@property (nonatomic, strong, readonly) dispatch_queue_t protectingQueue;

@end

@implementation NetworkClient


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _runningTasks = [[NSMutableArray alloc] init];
        _protectingQueue = dispatch_queue_create("Protecting Queue", NULL);
    }
    return self;
}

- (NSURLSession*)urlSession
{
    if (_urlSession == nil)
    {
        _urlSession = [self createURLSession];
    }
    return _urlSession;
}

- (NSURLSession *)createURLSession
{
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:nil];
    return session;
}

- (void)startDataTaskWithRequest:(NSMutableURLRequest *)request completionHandler:(DataTaskCompletion)completionHandler
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(weakSelf.protectingQueue, ^{
        NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request];
        URLSessionTask *runningTask = [[URLSessionTask alloc] initWithTask:task completion:completionHandler];
        runningTask.request = request;
        [weakSelf.runningTasks addObject:runningTask];
        [task resume];
    });
}

- (URLSessionTask *)runningTaskForSessionTask:(NSURLSessionTask *)task
{
    NSUInteger index = [self.runningTasks indexOfObjectPassingTest:^BOOL(URLSessionTask *runningTask, NSUInteger idx, BOOL *stop) {
        return (runningTask.sessionTask == task);
    }];
    return (index != NSNotFound) ? self.runningTasks[index] : nil;
}

- (void)completeTask:(URLSessionTask *)task error:(NSError *)error
{
    NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.sessionTask.response;
    DataTaskCompletion block = task.completionBlock;
    NSData *data = task.data;
  
  NSError* taskError;
    if (error.code  > 0 ) {
      taskError =  [self errorFromHTTPURLResponse:(NSHTTPURLResponse*)response data:data];
    }
  
    
    if (block)
    {
        block((taskError == nil) ? data : nil, taskError);
    }
    
    dispatch_sync(self.protectingQueue, ^{
        [self.runningTasks removeObject:task];
        if (self.runningTasks.count == 0)
        {
            [self.urlSession invalidateAndCancel];
            self.urlSession = nil;
        }
    });
}

- (void)cancel {
    for (URLSessionTask *runningTask in self.runningTasks) {
        [runningTask.sessionTask cancel];
    }
}

// Could be implemented as HTTPURLResponseErrorFactory but there is no any documented error response format in the API

- (NSError *)errorFromHTTPURLResponse:(NSHTTPURLResponse *)response data:(NSData*)data
{
    NSError *error = nil;
    NSInteger responseStatusCode = response.statusCode;
    if (responseStatusCode != 200)
    {
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        error = [NSError errorWithDomain:kErrorDomainString code:responseStatusCode userInfo:@{NSLocalizedDescriptionKey : responseString}];
    }
    return error;
}

#pragma mark - NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    URLSessionTask *runningTask = [self runningTaskForSessionTask:dataTask];
    [runningTask appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    URLSessionTask *runningTask = [self runningTaskForSessionTask:task];
    if (runningTask)
    {
        [self completeTask:runningTask error:error];
    }
}

@end
