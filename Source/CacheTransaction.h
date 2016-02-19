//
//  CacheTransaction.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CacheTransaction : NSObject

/**
 Changed object
 */
@property (strong, nonatomic, readonly) id object;

/**
 Objects indexPath before changed
 */
@property (copy, nonatomic, readonly) NSIndexPath *oldIndexPath;

/**
 Objects indexPath after change
 */
@property (copy, nonatomic, readonly) NSIndexPath *updatedIndexPath;

/**
 Type of changed object
 */
@property (copy, nonatomic, readonly) NSString *objectType;

/**
 Type of change
 */
@property (assign, nonatomic, readonly) NSFetchedResultsChangeType changeType;

+ (instancetype)transactionWithObject:(id)object
                         oldIndexPath:(NSIndexPath *)oldIndexPath
                     updatedIndexPath:(NSIndexPath *)updatedIndexPath
                           objectType:(NSString *)objectType
                           changeType:(NSUInteger)changeType;

@end
