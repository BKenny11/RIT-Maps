//
//  AppDelegate.m
//  RIT Maps
//
//  Created by Brendan Kenny on 10/29/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "AppDelegate.h"
#import "DetailViewController.h"
#import "DataStore.h"
#import "RITBuilding.h"
NSString * const kBUILDING_DATA = @"all-rit-polygons";
@interface AppDelegate () <UISplitViewControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self loadData];
    UISplitViewController *splitViewController = (UISplitViewController *)self.window.rootViewController;
    UINavigationController *navigationController = [splitViewController.viewControllers lastObject];
    navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem;
    splitViewController.delegate = self;
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Split view

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    if ([secondaryViewController isKindOfClass:[UINavigationController class]] && [[(UINavigationController *)secondaryViewController topViewController] isKindOfClass:[DetailViewController class]] && ([(DetailViewController *)[(UINavigationController *)secondaryViewController topViewController] detailItem] == nil)) {
        // Return YES to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
        return YES;
    } else {
        return NO;
    }
}

-(void)loadData{
    NSDictionary *jsonDictionary;
    NSString *path = [[NSBundle mainBundle] pathForResource:kBUILDING_DATA ofType:@"js"];
    NSError *error;
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    
    if(error){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Loading JSON file" message:[error description] delegate:self cancelButtonTitle:nil otherButtonTitles:@":-(", nil];
        [alert show];
        
    }else{
        jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        if(error){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error parsing JSON data" message:[error description] delegate:self cancelButtonTitle:nil otherButtonTitles:@":-(", nil];
            [alert show];
            
        }else{
            
            NSMutableArray *allBuildings = jsonDictionary[@"response"][@"docs"];
            [DataStore sharedStore].allItems = allBuildings;
            
            NSSortDescriptor *sortDescriptor;
            sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
            NSArray *sortedBuildings;
            sortedBuildings = [allBuildings sortedArrayUsingDescriptors:sortDescriptors];
            
            NSMutableArray *sortedBuildings2 = [[NSMutableArray alloc]initWithArray:sortedBuildings];
               
            NSMutableArray *buildings = [NSMutableArray array];
            RITBuilding *building;
            
            for (NSDictionary *dictionary in sortedBuildings2){
                NSString *name = dictionary[@"name"];
                NSString *mdo_id = dictionary[@"mdo_id"];
                NSString *bDescription = dictionary[@"bDescription"];
                NSString *polygon_id = dictionary[@"polygon_id"];
                NSString *path = dictionary[@"path"];
                NSString *image = dictionary[@"image"];
                NSString *abbreviation = dictionary[@"abbreviation"];
                NSString *history = dictionary[@"history"];
                NSString *fulldescription = dictionary[@"full_description"];
                float longitude = [dictionary[@"longitude"] floatValue];
                float latitude = [dictionary[@"latitude"] floatValue];
                building = [[RITBuilding alloc] initWithName: (NSString*)name mdo_id:(NSString*)mdo_id bDescription:(NSString*)bDescription polygon_id:(NSString*)polygon_id image:(NSString*)image abbreviation:(NSString*)abbreviation history:(NSString*)history fulldescription:(NSString*)fulldescription latitude:(float)latitude longitude:(float)longitude path:(NSString*)path];
                [buildings addObject:building];
            }
            [DataStore sharedStore].allItems = buildings;
            
        
                    }
    }
}



@end
