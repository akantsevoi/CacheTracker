//
//  Interactor.h
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CacheTracker.h"
#import "InteractorInput.h"
#import "InteractorOutput.h"
#import "RecordFactory.h"
#import "CDManager.h"

@interface Interactor : NSObject <CacheTrackerDelegate, InteractorInput>

@property (nonatomic, weak) id<InteractorOutput> output;
@property (nonatomic, strong) CDManager* cdManager;
@property (nonatomic, strong) RecordFactory* objectFactory;

@end
