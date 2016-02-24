//
//  ViewController.m
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import "ViewController.h"

static NSString* const kCellIdentifier = @"cellIdentifier";

@interface ViewController ()

@end

@implementation ViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [Assembly injectProperiesInController:self];
}

#pragma mark -
#pragma mark - CacheTrackerDelegate

//- (void)didProcessTransactionBatch:(CacheTransactionBatch *)transactionBatch {
//
//}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    
    
    
    return cell;
}

@end
