//
//  MasterViewController.h
//  RIT Maps
//
//  Created by Brendan Kenny on 10/29/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"
#import "RITBuilding.h"
@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (nonatomic, strong) RITBuilding *building;
@property(nonatomic, strong) NSMutableArray *buildings;

@end

