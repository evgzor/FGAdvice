//
//  FGAHTTPClient.m
//  RandomAdvice
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NetworkClient+LoadAdvice.h"

static NSString* const kWebServiceURLString = @"http://fucking-great-advice.ru/api/random/censored";

@implementation NetworkClient(LoadAdvice)

- (void)loadRandomAdviceWithCompletionHandler:(void (^)(FGAModel *advice, NSError *error))completionBlock
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    request.URL = [NSURL URLWithString:kWebServiceURLString];
    request.HTTPMethod = @"GET";
    
    [self startDataTaskWithRequest:request completionHandler:^(NSData *data, NSError *error) {
        if (error == nil)
        {
            NSError *jsonError;
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
            if (!jsonError)
            {
                // This should be done in HTTPResponseTransformer Advice-specific class
              FGAModel *advice = [[FGAModel alloc] initModelWithDictionary:jsonObject];
                completionBlock(advice, nil);
            }
            else
            {
                completionBlock(nil, jsonError);
            }
        }
        else
        {
            completionBlock(nil, error);
        }
    }];
}

@end
