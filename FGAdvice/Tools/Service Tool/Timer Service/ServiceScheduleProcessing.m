//
//  ServisceScheduleProcessing.m
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "ServiceScheduleProcessing.h"

@interface ServiceScheduleProcessing() {
  NSMutableArray <id<ServiceProtocol>> *_services;
}

@end

@implementation ServiceScheduleProcessing

-(instancetype)init
{
  self = [self init:nil];
  
  return self;
}

-(instancetype)init: (id<TimerProtocol>) timer {
  self = [super init];
  _timer = timer;
  _services = [NSMutableArray array];
  
  return self;
}

-(void)start {
  [_timer start];
  [_timer onTick:^(NSInteger tick) {
    [self timerDidTick:tick];
  }];
}

-(void)stop {
  [_timer stop];
}

-(void)registerService:(id<ServiceProtocol>) service {
  [_services addObject:service];
}

-(void) timerDidTick:(NSInteger) tick {
  [self runServicesWithTick:tick];
}

-(void) runServicesWithTick: (NSInteger) tick {
  for (id<ServiceProtocol> service in _services) {
    if ([self shouldExecuteFrequency: service.frequency onTick:tick]) {
      [service execute];
    }
  }
}

-(BOOL) shouldExecuteFrequency: (NSInteger) frequency onTick: (NSInteger) tick {
  
  return tick % frequency == 0;
}

@end
