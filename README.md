# CacheTracker

Based on https://github.com/rambler-ios/The-Book-of-VIPER/blob/master/FRCInVIPER.md

Divide NSFetchedResultsController in Business logic layer and UI layer.

How use on BLL:

Create CacheTracker:
```
CacheTracker* cacheTracker = [CacheTracker cacheTracker:<#request#>
                                               delegate:<#delegate#>
                                         objectsFactory:<#object factory#>
                                                context:<#managedObjectContext#>];
```

`Object factory` allows convert NSManagedObjects to plain objects.

Example use on UI Layer:

```
/*
@property (nonatomic,strong) NSMutableArray* records; // It array contains plain objects on ui layer.
*/

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
```
