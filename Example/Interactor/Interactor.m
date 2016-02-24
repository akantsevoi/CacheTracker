//
//  Interactor.m
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "Interactor.h"
#import "Record.h"

@interface Interactor ()

@property (nonatomic, strong) CacheTracker* cacheTracker;

@end

@implementation Interactor

#pragma mark -
#pragma mark - CacheTrackerDelegate

- (void)didProcessTransactionBatch:(CacheTransactionBatch *)transactionBatch {
    
}

#pragma mark -
#pragma mark - Support methods

- (void) runCacheTracker {
    
    CacheRequest* request = [CacheRequest new];
    
    request.entityName = NSStringFromClass([Record class]);
    request.predicate = [NSPredicate predicateWithFormat:@"recordLength > 2 AND recordLength < 300"];
    request.sortDescriptors = @[
                                [NSSortDescriptor sortDescriptorWithKey:@"recordLength"
                                                              ascending:YES],
                                [NSSortDescriptor sortDescriptorWithKey:@"title"
                                                              ascending:YES]
                                ];
    
    self.cacheTracker = [CacheTracker cacheTracker:request
                                          delegate:self
                                    objectsFactory:self.objectFactory
                                           context:nil];
    
    [self.cacheTracker obtainTransactionBatchFromCurrentCache];
}

@end
