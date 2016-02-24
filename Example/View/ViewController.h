//
//  ViewController.h
//  CacheTracker
//
//  Created by Alexandr on 18.02.16.
//  Copyright © 2016 Aliksandr Kantsevoi. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Assembly.h"

#import "InteractorInput.h"
#import "InteractorOutput.h"

@interface ViewController : UIViewController <UITableViewDataSource, InteractorOutput>

@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, strong) id<InteractorInput> interactor;

@end

