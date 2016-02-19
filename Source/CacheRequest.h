//
//  CacheRequest.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheRequest : NSObject

@property (nonatomic, copy) NSString* entityName;
@property (nonatomic, copy) NSPredicate* predicate;
@property (nonatomic, copy) NSArray<NSSortDescriptor *> *sortDescriptors;

@end
