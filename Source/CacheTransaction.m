//
//  CacheTransaction.m
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "CacheTransaction.h"
#import <CoreData/CoreData.h>

@interface CacheTransaction ()

@property (strong, nonatomic) id object;
@property (copy, nonatomic) NSIndexPath *oldIndexPath;
@property (copy, nonatomic) NSIndexPath *updatedIndexPath;
@property (copy, nonatomic) NSString *objectType;
@property (assign, nonatomic) NSFetchedResultsChangeType changeType;

@end

@implementation CacheTransaction

+ (instancetype)transactionWithObject:(id)object
                         oldIndexPath:(NSIndexPath *)oldIndexPath
                     updatedIndexPath:(NSIndexPath *)updatedIndexPath
                           objectType:(NSString *)objectType
                           changeType:(NSUInteger)changeType {
    CacheTransaction* transaction = [CacheTransaction new];
    
    transaction.object = object;
    transaction.oldIndexPath = oldIndexPath;
    transaction.updatedIndexPath = updatedIndexPath;
    transaction.objectType = objectType;
    transaction.changeType = changeType;
    
    return transaction;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@:\roldIndex: %@\rupdateIndex: %@\robjectName: %@\rchangeType: %lu",
            NSStringFromClass(self.class),
            self.oldIndexPath,
            self.updatedIndexPath,
            self.objectType,
            (unsigned long)self.changeType];
}

@end
