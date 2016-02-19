//
//  CacheTracker.m
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "CacheTracker.h"

#import "CacheTracker.h"

@interface CacheTracker ()

@property (nonatomic, strong) NSFetchedResultsController* controller;
@property (nonatomic, strong) CacheRequest* cacheRequest;
@property (nonatomic, strong) CacheTransactionBatch* transactionBatch;

@end

@implementation CacheTracker

+ (instancetype)cacheTracker:(CacheRequest *)request delegate:(id<CacheTrackerDelegate>)delegate objectsFactory:(id<ObjectsFactoryProtocol>)objectsFactory context:(NSManagedObjectContext *)context {
    
    CacheTracker* tracker = [CacheTracker new];
    tracker.delegate = delegate;
    tracker.objectsFactory = objectsFactory;
    [tracker setupWithCacheRequest:request
                        forContext:context];
    
    return tracker;
}

- (void)setupWithCacheRequest:(CacheRequest *)cacheRequest
                   forContext:(NSManagedObjectContext *)context {
    self.cacheRequest = cacheRequest;
    NSFetchRequest *fetchRequest = [self fetchRequestWithCacheRequest:cacheRequest];
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                          managedObjectContext:context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
    self.controller.delegate = self;
    [self.controller performFetch:nil];
}

- (NSFetchRequest *)fetchRequestWithCacheRequest:(CacheRequest *)cacheRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:cacheRequest.entityName];
    [fetchRequest setPredicate:cacheRequest.predicate];
    [fetchRequest setSortDescriptors:cacheRequest.sortDescriptors];
    return fetchRequest;
}

- (CacheTransactionBatch *) obtainTransactionBatchFromCurrentCache {
    CacheTransactionBatch *batch = [CacheTransactionBatch new];
    for (NSUInteger i = 0; i < self.controller.fetchedObjects.count; i++) {
        id object = self.controller.fetchedObjects[i];
        NSIndexPath *indexPath = [self.controller indexPathForObject:object];
        id plainObject = [self.objectsFactory objectFromNSManagedObject:object];
        CacheTransaction *transaction = [CacheTransaction transactionWithObject:plainObject
                                                                   oldIndexPath:nil
                                                               updatedIndexPath:indexPath
                                                                     objectType:self.cacheRequest.entityName
                                                                     changeType:NSFetchedResultsChangeInsert];
        [batch addTransaction:transaction];
    }
    
    return batch;
}

#pragma mark - Методы NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    self.transactionBatch = [CacheTransactionBatch new];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(NSManagedObject *)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    id plainObject = [self.objectsFactory objectFromNSManagedObject:anObject];
    CacheTransaction *transaction = [CacheTransaction transactionWithObject:plainObject
                                                               oldIndexPath:indexPath
                                                           updatedIndexPath:newIndexPath
                                                                 objectType:self.cacheRequest.entityName
                                                                 changeType:type];
    [self.transactionBatch addTransaction:transaction];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if ([self.transactionBatch isEmpty]) {
        return;
    }
    
    [self.delegate didProcessTransactionBatch:self.transactionBatch];
}

@end
