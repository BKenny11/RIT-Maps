//
//  MyMarker.m
//  National Parks
//
//  Created by Brendan Kenny on 10/9/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "MyMarker.h"

@implementation MyMarker

-(id)initWithTitle:(NSString *)title Coordinate:(CLLocationCoordinate2D)coord{
    self = [super init];
    if(self){
        _title = title;
        _coordinate = coord;
    }
    return self;
}



@end
