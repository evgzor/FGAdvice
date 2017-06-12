//
//  CoreDataClient.m
//
//  Created by Evgeny Zorin on 10/06/2017
//  Copyright (c) 2017 __MyCompanyName__. All rights reserved.//

#import "CoreDataClient.h"

@interface CoreDataClient ()

@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation CoreDataClient

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize storageURL = _storageURL;

- (instancetype)init {
    NSAssert(NO, @"Use -initWithModelFileURL:storageURL: instead.");
    return nil;
}

- (instancetype)initWithModelFileURL:(NSURL *)modelFileURL storageURL:(NSURL *)storageURL {
    NSParameterAssert(modelFileURL);

    self = [super init];
    if (self)
    {
        _modelFileURL = modelFileURL;
        _storageURL = storageURL;
    }
    return self;
}

- (NSURL *)storageURL {
    if (!_storageURL) {
        NSURL *documentsDirectory = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        NSURL *directoryURL = [documentsDirectory URLByAppendingPathComponent:[self modelFileName]];
        NSString *directoryPath = directoryURL.path;
        if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath]) {
            NSError *error;
            [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error.code > 0) {
               NSAssert(YES, @"Error during creating directory for storage: %@", error.debugDescription);
            }
            if (![directoryURL setResourceValue:@YES forKey:NSURLIsExcludedFromBackupKey error:&error]) {
              NSAssert(YES, @"Error during setting attribute for storage directory: %@", error.debugDescription);
            }
        }
        _storageURL = [directoryURL URLByAppendingPathComponent:self.modelFileName];
    }
    return _storageURL;
}

- (NSString *)modelFileName {
    return self.modelFileURL.lastPathComponent;
}

#pragma mark Core Data stack

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        @synchronized(self) {
            _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
        }
    }
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (!_persistentStoreCoordinator) {
        @synchronized(self) {
            _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
            NSError *error = nil;
            if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:self.storageURL options:nil error:&error]) {
              NSAssert(YES, @"Unresolved error %@, %@", error, error.userInfo);
            }
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (!_managedObjectModel) {
        @synchronized(self) {
            _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:self.modelFileURL];
        }
    }
    return _managedObjectModel;
}

@end
