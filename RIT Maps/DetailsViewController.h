//
//  DetailsViewController.h
//  RIT Maps
//
//  Created by Brendan Kenny on 11/8/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RITBuilding.h"

@interface DetailsViewController : UIViewController <UIWebViewDelegate>
@property (nonatomic, strong) RITBuilding *building;
@property (nonatomic, strong) NSObject *annotation;

@end
