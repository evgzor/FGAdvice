//
//  FGAModel.h
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FGAModel : NSObject <NSCoding, NSCopying>

@property (nonatomic) NSInteger idx;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *sound;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initModelWithDictionary:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
- (NSDictionary *)dictionaryRepresentation;

@end
