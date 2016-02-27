//
//  ObjectsFactory.m
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "RecordFactory.h"
#import "Record.h"
#import "RecordModel.h"

@implementation RecordFactory

- (id)objectFromNSManagedObject:(Record *)managedObject {
    
    if([managedObject.entity.name isEqualToString:NSStringFromClass([Record class])]) {
        RecordModel* model = [RecordModel new];
        model.title = managedObject.title;
        model.recordLength = managedObject.recordLength;
        
        return model;
    }
    
    return nil;
}

@end
