//
//  DetailViewController.h
//  RIT Maps
//
//  Created by Brendan Kenny on 10/29/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RITBuilding.h"
#import "DataStore.h"

@import MapKit;
@interface DetailViewController : UIViewController <MKMapViewDelegate, UIWebViewDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapTypeSegmentedControl;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) RITBuilding *building;
@property (strong, nonatomic) NSMutableArray *buildings;
-(void)zoomTo:(id<MKAnnotation>)annotation;
@end

