//
//  CacheTracker.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CacheTrackerProtocol.h"
#import "ObjectsFactoryProtocol.h"

@interface CacheTracker : NSObject <CacheTrackerProtocol, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) id<ObjectsFactoryProtocol> objectsFactory;
@property (nonatomic, weak) id<CacheTrackerDelegate> delegate;

+ (instancetype) cacheTracker:(CacheRequest*) request
                     delegate:(id<CacheTrackerDelegate>) delegate
               objectsFactory:(id<ObjectsFactoryProtocol>) objectsFactory
                      context:(NSManagedObjectContext*) context;

@end
