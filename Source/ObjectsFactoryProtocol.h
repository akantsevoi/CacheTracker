//
//  ObjectsFactoryProtocol.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

@protocol ObjectsFactoryProtocol <NSObject>

- (id) objectFromNSManagedObject:(NSManagedObject*) managedObject;

@end
