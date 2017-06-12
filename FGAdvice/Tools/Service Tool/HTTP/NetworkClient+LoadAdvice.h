//
//  NetworkClient+LoadAdvice.h
//  RandomAdvice
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "NetworkClient.h"
#import "FGAModel.h"

@interface NetworkClient(LoadAdvice)

- (void)loadRandomAdviceWithCompletionHandler:(void (^)(FGAModel *advice, NSError *error))completionBlock;

@end
