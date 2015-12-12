//
//  DataStore.m
//  National Parks
//
//  Created by Brendan Kenny on 10/14/14.
//  Copyright (c) 2014 Student. All rights reserved.
//

#import "DataStore.h"

@implementation DataStore

+ (id)sharedStore{
    static DataStore *sharedStore = nil;
    if (!sharedStore){
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}

-(instancetype) init{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"Use +[DataStore sharedStore]!" userInfo:nil];
    return nil;
}

-(instancetype)initPrivate{
    self = [super init];
    if(self){
        self.allItems = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
