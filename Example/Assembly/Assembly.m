//
//  Assembly.m
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "Assembly.h"

#import "ViewController.h"
#import "Interactor.h"

@implementation Assembly

+ (void)injectProperiesInController:(ViewController *)controller {
    Interactor* interactor = [Interactor new];
    
    controller.interactor = interactor;
    
    interactor.output = controller;
    interactor.objectFactory = [RecordFactory new];
    interactor.cdManager = [CDManager instance];
}

@end
