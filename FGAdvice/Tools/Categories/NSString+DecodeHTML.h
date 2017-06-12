//
//  NSString+DecodeHTML.h
//  RandomAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DecodeHTML)

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSString *stringByDecodingHTMLEntities;

@end
