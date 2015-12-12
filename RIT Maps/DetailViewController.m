//
//  DetailViewController.m
//  RIT Maps
//
//  Created by Brendan Kenny on 10/29/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//


#import "DetailViewController.h"
#import "DetailsViewController.h"
#import "MyMarker.h"
#import "DataStore.h"

@import MapKit;

#define METERS_PER_MILE 1609.344

@interface DetailViewController ()
@property (nonatomic) NSMutableArray *markers;
@property (nonatomic, strong) UIPopoverController *popover;
-(void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    
    UIImage *image = [UIImage imageNamed:@"rit-orange-no-bar-50x15"];
    UIImageView *imgView =[[UIImageView alloc] initWithImage:image];
    
    [annotationView setLeftCalloutAccessoryView:imgView];

    
    return annotationView;
}

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
    
    if(self.popover != nil){
        [self.popover dismissPopoverAnimated:YES];
    }

}

- (void)configureView {
    if (self.detailItem) {
        
        MyMarker *currentselection = [[MyMarker alloc] initWithTitle:[self.detailItem name] Coordinate:CLLocationCoordinate2DMake([self.detailItem latitude], [self.detailItem longitude])];
        currentselection.subtitle = [self.detailItem abbreviation];
        [self.mapView addAnnotation:currentselection];
        [self zoomTo:currentselection];
        self.building = self.detailItem;
        
       
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.buildings = [DataStore sharedStore].allItems;
    self.markers = [NSMutableArray array];
    for( int i = 0; i < [DataStore sharedStore].allItems.count; i++){
        RITBuilding *b = self.buildings[i];
        MyMarker *m1 = [[MyMarker alloc] initWithTitle:b.name Coordinate:CLLocationCoordinate2DMake(b.latitude, b.longitude)];
        m1.subtitle = b.abbreviation;
        self.detailItem = b;
        [self.markers addObject:m1];
   }
   self.detailItem = self.buildings[22];
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = [self.detailItem latitude];
    zoomLocation.longitude = [self.detailItem longitude];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, METERS_PER_MILE, METERS_PER_MILE);
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotations:self.markers];
    [self configureView];
 }

-(void) zoomTo:(id<MKAnnotation>)annotation{
    self.tabBarController.selectedIndex = 0;
    [self.mapView selectAnnotation:annotation animated:YES];
}

-(void)didSelectAnnotationView{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
 
    [mapView deselectAnnotation:view.annotation animated:YES];
    DetailsViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsPopover"];
    
    
    controller.annotation = view.annotation;
    for (int i = 0; i < self.buildings.count; i++) {
        if(view.annotation.title == [self.buildings[i] name]){
            self.detailItem = self.buildings[i];
        }
    }
    controller.building = self.building;
    self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
    
    self.popover.delegate = self;
    
    [self.popover presentPopoverFromRect:view.frame inView:view.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:NO];
   

}

- (void)splitViewController:(UISplitViewController *)iSplitViewController
     willHideViewController:(UIViewController *)iViewController
          withBarButtonItem:(UIBarButtonItem *)iBarButtonItem
       forPopoverController:(UIPopoverController *)iPopoverController {
    
    self.popover = iPopoverController;
}


- (void)splitViewController:(UISplitViewController *)iSplitViewController
     willShowViewController:(UIViewController *)iViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)iBarButtonItem {
    
    self.popover = nil;
}


- (IBAction)mapTypeChanged:(id)sender {
    switch (self.mapTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        default:
            break;
    }
}


@end
