//
//  FGAModel.m
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

#import "FGAModel.h"
#import "NSString+DecodeHTML.h"


NSString *const kFGAModelId = @"id";
NSString *const kFGAModelText = @"text";
NSString *const kFGAModelSound = @"sound";


@interface FGAModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FGAModel



+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initModelWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            _idx = [[self objectOrNilForKey:kFGAModelId fromDictionary:dict] integerValue];
            _text = [self objectOrNilForKey:kFGAModelText fromDictionary:dict];
            _text = [_text stringByDecodingHTMLEntities];
            _sound = [self objectOrNilForKey:kFGAModelSound fromDictionary:dict];

    }
    
    return self;
    
}

-(instancetype)init {
  self = [self initModelWithDictionary:nil];
  
  return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:@(self.idx) forKey:kFGAModelId];
    [mutableDict setValue:self.text forKey:kFGAModelText];
    [mutableDict setValue:self.sound forKey:kFGAModelSound];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = dict[aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];

    _idx = [[aDecoder decodeObjectForKey:kFGAModelId] integerValue];
    _text = [aDecoder decodeObjectForKey:kFGAModelText];
    _sound = [aDecoder decodeObjectForKey:kFGAModelSound];
  
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:@(_idx) forKey:kFGAModelId];
    [aCoder encodeObject:_text forKey:kFGAModelText];
    [aCoder encodeObject:_sound forKey:kFGAModelSound];
}

- (id)copyWithZone:(NSZone *)zone
{
    FGAModel *copy = [[self.class alloc] init];
    
    if (copy) {

        copy.idx = self.idx ;
        copy.text = [self.text copyWithZone:zone];
        copy.sound = [self.sound copyWithZone:zone];
    }
    
    return copy;
}


@end
