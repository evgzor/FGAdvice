//
//  ServisceScheduleProcessing.h
//  FGAdvice
//
//  Created by Eugene Zorin on 10/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerServiceProtocol.h"

@interface ServiceScheduleProcessing : NSObject <ServiceScheduleProtocol>

@property(readonly, strong, nonatomic) id <TimerProtocol> timer;

-(instancetype)init: (id<TimerProtocol>) timer NS_DESIGNATED_INITIALIZER;
-(void)registerService:(id<ServiceProtocol>) service;

@end
