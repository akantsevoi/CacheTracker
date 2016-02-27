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
