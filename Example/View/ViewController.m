//
//  ViewController.m
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "ViewController.h"
#import "RecordModel.h"

static NSString* const kCellIdentifier = @"cellIdentifier";

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray<RecordModel*>* records;

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [Assembly injectProperiesInController:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.records = [NSMutableArray new];
    [self.interactor startDeliveredData];
}

#pragma mark -
#pragma mark - InteractorOutput

- (void)processTransactionBatch:(CacheTransactionBatch*) batch {
    
    [self.tableView beginUpdates];
    
    NSMutableArray<NSIndexPath*>* updateRows = [NSMutableArray new];
    NSMutableArray<NSIndexPath*>* deleteRows = [NSMutableArray new];
    NSMutableArray<NSIndexPath*>* insertRows = [NSMutableArray new];
    
    for (CacheTransaction* transaction in batch.updateTransactions) {
        [self.records replaceObjectAtIndex:transaction.oldIndexPath.row withObject:transaction.object];
        [updateRows addObject:transaction.oldIndexPath];
    }
    
    for (CacheTransaction* transaction in batch.deleteTransactions) {
        [self.records removeObjectAtIndex:transaction.oldIndexPath.row];
        [deleteRows addObject:transaction.oldIndexPath];
    }
    
    for (CacheTransaction* transaction in batch.insertTransactions) {
        [self.records insertObject:transaction.object atIndex:transaction.updatedIndexPath.row];
        [insertRows addObject:transaction.updatedIndexPath];
    }
    
    
    
    [self.tableView reloadRowsAtIndexPaths:updateRows withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView deleteRowsAtIndexPaths:deleteRows withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView insertRowsAtIndexPaths:insertRows withRowAnimation:UITableViewRowAnimationFade];
    
    [self.tableView endUpdates];
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    cell.textLabel.text = self.records[indexPath.row].title;
    
    return cell;
}

@end
