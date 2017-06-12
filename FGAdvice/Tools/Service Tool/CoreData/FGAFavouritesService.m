//
//  FGAFavouritesService.m
//  RandomAdvice
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.

#import "FGAFavouritesService.h"
#import "CoreDataClient.h"

static NSString* const kEntityName = @"Advice";
static NSString* const kIdxKey = @"idx";
static NSString* const kTextKey = @"text";

@implementation FGAFavouritesService

+ (instancetype)sharedService
{
    static FGAFavouritesService *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"FGAFavouritesDatabase" withExtension:@"momd"];
        sharedInstance = [[self alloc] initWithModelFileURL:modelURL storageURL:nil];
    });
    
    return sharedInstance;
}



- (void)loadFavouritesWithCompletionHandler:(void (^)(NSArray<FGAModel*>* advices))completionBlock {
    __block NSArray<NSManagedObject*> *objects;
    [self.managedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kEntityName inManagedObjectContext:self.managedObjectContext];
        fetchRequest.entity = entity;
        NSError *fetchError = nil;
        objects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
        if (!fetchError && objects.count > 0) {
            NSMutableArray<FGAModel*>* advices = [[NSMutableArray alloc] initWithCapacity:objects.count];
            for (NSManagedObject *obj in objects) {
                FGAModel *advice = [[FGAModel alloc] init];
                advice.idx = [[obj valueForKey:kIdxKey] integerValue];
                advice.text = [obj valueForKey:kTextKey];
                [advices addObject:advice];
            }
            completionBlock(advices);
        } else {
            completionBlock(nil);
        }
    }];
}

- (void)addToFavourites:(FGAModel*)advice {
    [self.managedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kEntityName inManagedObjectContext:self.managedObjectContext];
        fetchRequest.entity = entity;
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(idx == %i)", advice.idx];
        NSError *fetchError = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
        if (fetchError || !results.count) {
            // Object transformation could be done in a separate class. And NSManagedObject subclass could be created to manage these via properties.
            NSManagedObject *adviceMO = [NSEntityDescription insertNewObjectForEntityForName:kEntityName inManagedObjectContext:self.managedObjectContext];
            [adviceMO setValue:@(advice.idx) forKey:kIdxKey];
            [adviceMO setValue:advice.text forKey:kTextKey];
        }
        [self saveContext];
    }];
}

- (void)removeFromFavourites:(FGAModel*)advice {
    [self.managedObjectContext performBlock:^{
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:kEntityName inManagedObjectContext:self.managedObjectContext];
        fetchRequest.entity = entity;
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"(idx == %i)", advice.idx];
        NSError *fetchError = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
        if (results.count > 0 && fetchError.code == 0) {
            NSManagedObject *obj = results[0];
            [self.managedObjectContext deleteObject:obj];
        }
        [self saveContext];
    }];
}

#pragma mark Private function

- (void)saveContext {
    NSError *error = nil;
    if (self.managedObjectContext != nil) {
        if ((self.managedObjectContext).hasChanges && ![self.managedObjectContext save:&error]) {
          NSAssert(NO,@"Unresolved error %@ %@", error, error.userInfo);
        }
    }
}

@end
