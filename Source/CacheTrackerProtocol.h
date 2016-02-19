//
//  CacheTrackerProtocol.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "CacheTransactionBatch.h"
#import "CacheRequest.h"

@protocol CacheTrackerProtocol <NSObject>

/**
 Set up cache tracker
 
 @param cacheRequest Запрос, описывающий поведение трекера
 */
- (void)setupWithCacheRequest:(CacheRequest *)cacheRequest forContext:(NSManagedObjectContext*) context;

/**
 Create transaction batch from current cache state
 
 @return CacheTransactionBatch
 */
- (CacheTransactionBatch *)obtainTransactionBatchFromCurrentCache;



@end

@protocol CacheTrackerDelegate <NSObject>

- (void) didProcessTransactionBatch:(CacheTransactionBatch *)transactionBatch;

@end
