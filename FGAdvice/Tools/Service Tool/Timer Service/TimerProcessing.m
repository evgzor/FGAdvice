//
//  TimerProcessing.m
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "TimerProcessing.h"

@interface TimerProcessing() {
  NSTimer* _internalTimer;
  NSInteger _tick;
  void (^_tickAction)(NSInteger) ;
}

@end

@implementation TimerProcessing

-(instancetype)init {
  self = [super init];
  _internalTimer = nil;
  _tick = 0;
  _tickAction = nil;
  
  return self;
}

-(void)start {
  _internalTimer = [NSTimer scheduledTimerWithTimeInterval:1. target:self selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
}

-(void)onTick:(void (^)(NSInteger))action {
  _tickAction = action;
}

-(void)stop {
  [_internalTimer invalidate];
  _internalTimer = nil;
  _tick = 0;
}

-(void)timerDidFire: (NSTimer*)timer {
  _tick = _tick + 1;
  _tickAction(_tick);
}
@end
