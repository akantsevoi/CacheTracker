//
//  Interactor.m
//  CacheTracker
//
//  Created by Alexandr on 24.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "Interactor.h"
#import "Record.h"

@interface Interactor ()

@property (nonatomic, strong) CacheTracker* cacheTracker;

@end

@implementation Interactor


#pragma mark -
#pragma mark - InteractorInput

- (void)startDeliveredData {
    [self runCacheTracker];
}

#pragma mark -
#pragma mark - CacheTrackerDelegate

- (void)didProcessTransactionBatch:(CacheTransactionBatch *)transactionBatch {
    [self.output processTransactionBatch:transactionBatch];
}

#pragma mark -
#pragma mark - Support methods

- (void) runCacheTracker {
    
    CacheRequest* request = [CacheRequest new];
    
    // make request
    
    request.entityName = NSStringFromClass([Record class]);
    request.predicate = [NSPredicate predicateWithFormat:@"recordLength > 2 AND recordLength < 300"];
    request.sortDescriptors = @[
                                [NSSortDescriptor sortDescriptorWithKey:@"recordLength"
                                                              ascending:YES],
                                [NSSortDescriptor sortDescriptorWithKey:@"title"
                                                              ascending:YES]
                                ];
    
    // start cache tracker work
    
    self.cacheTracker = [CacheTracker cacheTracker:request
                                          delegate:self
                                    objectsFactory:self.objectFactory
                                           context:self.cdManager.mainContext];
    
    CacheTransactionBatch* initBatch = [self.cacheTracker obtainTransactionBatchFromCurrentCache];
    [self.output processTransactionBatch:initBatch];
    
    
    // manipulate with managed objects.
    
    Record* firstChange = [self createRecordWithTitle:@"start value 0" recordLength:@(0)];
    Record* secondChange = [self createRecordWithTitle:@"start value 140" recordLength:@(140)];
    Record* thirdChange = [self createRecordWithTitle:@"start value 130" recordLength:@(130)];
    Record* fourthChange = [self createRecordWithTitle:@"start value 1" recordLength:@(1)];
    
    [self createRecordWithTitle:@"start value 58" recordLength:@(58)];
    [self createRecordWithTitle:@"start value 100" recordLength:@(100)];
    [self createRecordWithTitle:@"start value 120" recordLength:@(120)];
    [self createRecordWithTitle:@"start value 234" recordLength:@(234)];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        firstChange.recordLength = @(45);
        firstChange.title = [NSString stringWithFormat:@"%@ new value 45", firstChange.title];
        
        secondChange.recordLength = @(30);
        secondChange.title = [NSString stringWithFormat:@"%@ new value 30", secondChange.title];
        
        thirdChange.recordLength = @(350);
        thirdChange.title = [NSString stringWithFormat:@"%@ new value 350", thirdChange.title];
        
        fourthChange.recordLength = @(100);
        fourthChange.title = [NSString stringWithFormat:@"%@ new value 100",fourthChange.title];
        
        [self.cdManager.mainContext save:nil];
    });
}

- (Record*) createRecordWithTitle:(NSString*) title recordLength:(NSNumber*) length {
    Record* record = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Record class])
                                                   inManagedObjectContext:self.cdManager.mainContext];
    record.title = title;
    record.recordLength = length;
    [self.cdManager.mainContext save:nil];
    
    return record;
}

@end
