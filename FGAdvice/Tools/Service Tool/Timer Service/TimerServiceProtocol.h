//
//  TimerserviceProtocol.h
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceProtocol <NSObject>

  - (void) execute;
  @property (NS_NONATOMIC_IOSONLY, readonly) NSInteger frequency;

@end

@protocol TimerProtocol <NSObject>

  - (void) start;
  - (void) stop;
  - (void) onTick: (void (^)(NSInteger))action;

@end

@protocol ServiceScheduleProtocol <NSObject>

  - (void) start;
  - (void) stop;

@end
