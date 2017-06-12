//
//  ActivityIndicator.h
//  ActivityIndicator
//
//  Created by Eugene Zorin on 12/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityIndicator : NSObject

- (void)startIndication;

- (void)stopIndication;

+ (instancetype)sharedIndicator;

@end
