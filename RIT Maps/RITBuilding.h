//
//  RITBuilding.h
//  RIT Maps
//
//  Created by Brendan Kenny on 11/2/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;
@interface RITBuilding : NSObject<MKAnnotation>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mdo_id;
@property (nonatomic, copy) NSString *bDescription;
@property (nonatomic) float latitude;
@property (nonatomic) float longitude;
@property (nonatomic, copy) NSString *polygon_id;
@property (nonatomic) NSString *path;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *abbreviation;
@property (nonatomic, copy) NSString *history;
@property (nonatomic, copy) NSString *fulldescription;


@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSMutableArray *parsePath;

-(instancetype) initWithName: (NSString*)name mdo_id:(NSString*)mdo_id bDescription:(NSString*)bDescription polygon_id:(NSString*)polygon_id image:(NSString*)image abbreviation:(NSString*)abbreviation history:(NSString*)history fulldescription:(NSString*)fulldescription latitude:(float)latitude longitude:(float)longitude path:(NSString*) path;

-(id)initWithTitle:(NSString*)title Coordinate:(CLLocationCoordinate2D)coord;

@end
