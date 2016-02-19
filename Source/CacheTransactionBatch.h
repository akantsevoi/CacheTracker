//
//  CacheTransactionBatch.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CacheTransaction.h"

/**
 *  @brief CacheTransactionBatch made for work with NSFetchedResultController.
 *
 *  All operations from NSFetchedResultController will transforms to CacheTransaction.
 *  You have to use transactions array with next order:
 *      1. Run all update operations
 *      2. Run all delete operations
 *      3. Run all insert operations
 */


@interface CacheTransactionBatch : NSObject

/**
 *  All update operations. Order run operations doesn't matter.
 *
 *  You have to use oldIndexPath
 *
 *  @return all update operations in current batch.
 */
- (NSArray<CacheTransaction*> *) updateTransactions;

/**
 *  All delete operations. Order - descending.
 *
 *  You have to use oldIndexPath
 *
 *  @return all delete operations in current batch.
 */
- (NSArray<CacheTransaction*> *) deleteTransactions;

/**
 *  @brief All insert operations. Order - ascending.
 *
 *  You have to use updateIndexPath
 *
 *  @return all insert operations in current batch.
 */
- (NSArray<CacheTransaction*> *) insertTransactions;


/**
 Add new transaction to batch. You have to use this method for add transaction to batch.
 
 @param transaction - Transaction
 */
- (void)addTransaction:(CacheTransaction *)transaction;

/**
 Method say is it has any batches
 
 @return YES/NO
 */
- (BOOL)isEmpty;

@end
