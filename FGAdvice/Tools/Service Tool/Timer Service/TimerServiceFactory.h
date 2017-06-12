//
//  TimerServiceFactory.h
//  FGAdvice
//
//  Created by Eugene Zorin on 11/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerServiceProtocol.h"

@interface TimerServiceFactory : NSObject

+ (id<ServiceProtocol>)timeLineServiceWithUserId:(NSString*) userId andAction: (void(^)())action;

@end
