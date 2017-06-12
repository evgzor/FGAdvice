//
//  TimerServiceFactory.m
//  FGAdvice
//
//  Created by Eugene Zorin on 11/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "TimerServiceFactory.h"
#import "RequestAdviceTimeLineService.h"

@implementation TimerServiceFactory

+ (id<ServiceProtocol>)timeLineServiceWithUserId:(NSString*) userId andAction: (void(^)())action {
  return [[RequestAdviceTimeLineService alloc] init:30 userId:userId andAction:action];
}

@end
