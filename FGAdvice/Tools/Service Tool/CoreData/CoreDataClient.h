//
//  CoreDataClient.h
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.
//

@import CoreData;

@interface CoreDataClient : NSObject

/**
 Designated initializer.

 @param modelFileURL Path to the *.xcdatamodel (*.momd in runtime) file.
 @param storageURL Path to the directory which will contain CoreData files. If nil then using ~/Documents/_modelFileName_ directory in user domain.
 @return Initialized object.
 */
- (nonnull instancetype)initWithModelFileURL:(nonnull NSURL *)modelFileURL storageURL:(nullable NSURL *)storageURL NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong, readonly, nonnull) NSURL *modelFileURL;
@property (nonatomic, strong, readonly, null_resettable) NSURL *storageURL;

@property (readonly, strong, nonatomic, null_resettable) NSManagedObjectContext *managedObjectContext;

@end
