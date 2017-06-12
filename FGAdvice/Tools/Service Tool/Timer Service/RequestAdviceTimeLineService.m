//
//  TimeLineService.m
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "RequestAdviceTimeLineService.h"

@interface RequestAdviceTimeLineService() {
  NSInteger _freq;
  void (^ _action)();
}


@end

@implementation RequestAdviceTimeLineService

-(instancetype) init: (NSInteger) frequency userId: (NSString*)userId andAction: (void(^)())action {
    self = [super init];
    _freq = frequency;
    _userId = userId;
    _action = action;
  return self;
}

-(instancetype)init
{
  self = [self init:0 userId:@"" andAction:nil];
  return self;
}

-(NSInteger)frequency {
  return _freq;
}

-(void)execute {
  if (_action) {
    _action();
  }
}

@end
