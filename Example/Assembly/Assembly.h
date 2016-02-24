//
//  Assembly.h
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewController;

@interface Assembly : NSObject

+ (void) injectProperiesInController:(ViewController*) controller;

@end
