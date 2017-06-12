//
//  FGAFavouritesService.h
//  RandomAdvice
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "CoreDataClient.h"
#import "FGAModel.h"

@interface FGAFavouritesService : CoreDataClient

+ (instancetype)sharedService;

- (void)loadFavouritesWithCompletionHandler:(void (^)(NSArray<FGAModel*>* advices))completionBlock;

- (void)addToFavourites:(FGAModel*)advice;
- (void)removeFromFavourites:(FGAModel*)advice;

@end
