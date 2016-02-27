//
//  InteractorOutput.h
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "CacheTransactionBatch.h"

@protocol InteractorOutput <NSObject>

- (void) processTransactionBatch:(CacheTransactionBatch*) batch;

@end
