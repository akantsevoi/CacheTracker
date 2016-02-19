//
//  CacheTransactionBatch.m
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "CacheTransactionBatch.h"

@interface CacheTransactionBatch ()

@property (strong, nonatomic) NSMutableArray<CacheTransaction*> *updateTransactionOperations;
@property (strong, nonatomic) NSMutableArray<CacheTransaction*> *deleteTransactionOperations;
@property (strong, nonatomic) NSMutableArray<CacheTransaction*> *insertTransactionOperations;

@end

@implementation CacheTransactionBatch

- (instancetype)init {
    self = [super init];
    
    if(self) {
        self.updateTransactionOperations = [NSMutableArray new];
        self.deleteTransactionOperations = [NSMutableArray new];
        self.insertTransactionOperations = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark -
#pragma mark - Work methods

- (NSArray<CacheTransaction *> *)updateTransactions {
    return [self.updateTransactionOperations copy];
}

- (NSArray<CacheTransaction *> *)deleteTransactions {
    return [self.deleteTransactionOperations sortedArrayUsingComparator:^NSComparisonResult(CacheTransaction*  _Nonnull obj1, CacheTransaction*  _Nonnull obj2) {
        return [obj2.oldIndexPath compare:obj1.oldIndexPath];
    }];
}

- (NSArray<CacheTransaction *> *) insertTransactions {
    return [self.insertTransactionOperations sortedArrayUsingComparator:^NSComparisonResult(CacheTransaction*  _Nonnull obj1, CacheTransaction*  _Nonnull obj2) {
        return [obj1.updatedIndexPath compare:obj2.updatedIndexPath];
    }];
}

- (void)addTransaction:(CacheTransaction *)transaction {
    
    switch (transaction.changeType) {
        case NSFetchedResultsChangeInsert:{
            [self.insertTransactionOperations addObject:transaction];
        }
            break;
        case NSFetchedResultsChangeDelete:{
            [self.deleteTransactionOperations addObject:transaction];
        }
            break;
        case NSFetchedResultsChangeMove:{
            [self.deleteTransactionOperations addObject:transaction];
            [self.insertTransactionOperations addObject:transaction];
        }
            break;
        case NSFetchedResultsChangeUpdate:{
            [self.updateTransactionOperations addObject:transaction];
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)isEmpty {
    return (self.updateTransactionOperations.count == 0 &&
            self.deleteTransactionOperations.count == 0 &&
            self.insertTransactionOperations.count == 0);
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@:\nUpdate: %@\nDelete:%@\n Insert:%@",
            self.class,
            self.updateTransactions,
            self.deleteTransactions,
            self.insertTransactions];
}

@end
