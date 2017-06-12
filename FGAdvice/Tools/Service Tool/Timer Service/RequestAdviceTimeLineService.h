//
//  TimeLineService.h
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerServiceProtocol.h"

@interface RequestAdviceTimeLineService : NSObject <ServiceProtocol>

@property (copy, nonatomic) NSString* userId;

-(instancetype) init: (NSInteger) frequency userId: (NSString*)userId andAction: (void(^)())action NS_DESIGNATED_INITIALIZER;


@end
