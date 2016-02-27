//
//  CDManager.h
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CDManager : NSObject

+ (instancetype) instance;

@property (nonatomic, strong) NSManagedObjectContext* mainContext;

@end
