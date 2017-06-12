//
//  SchedulerFactory.m
//  FGAdvice
//
//  Created by Eugene Zorin on 11/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "SchedulerFactory.h"
#import "TimerProcessing.h"
#import "ServiceScheduleProcessing.h"
#import "TimerServiceFactory.h"

@implementation SchedulerFactory


+ (id<ServiceScheduleProtocol>) serviceSchedulerWithUserId:(NSString*) userId andAction: (void(^)())action {
  id <TimerProtocol> timer = [[self class] makeTimer];
  
  ServiceScheduleProcessing* scheduler = [[ServiceScheduleProcessing alloc] init:timer];
  [scheduler registerService: [TimerServiceFactory timeLineServiceWithUserId:userId andAction:action]];
  
  return scheduler;
  
}

+ (id<TimerProtocol>) makeTimer {
  return [TimerProcessing new];
}

@end
