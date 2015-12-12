//
//  DetailsViewController.m
//  RIT Maps
//
//  Created by Brendan Kenny on 11/8/14.
//  Copyright (c) 2014 Brendan Kenny. All rights reserved.
//

#import "DetailsViewController.h"
#import "RITBuilding.h"
#import "MasterViewController.h"
@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString   *path = [[NSBundle mainBundle] pathForResource: @"building-detail-template" ofType: @"html"];
    NSString *template = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSMutableString *html = [NSMutableString stringWithString:template];
    
    if (self.building.title != nil){
   [html replaceOccurrencesOfString:@"[[[name]]]" withString: self.building.title options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }else{
    [html replaceOccurrencesOfString:@"[[[name]]]" withString: @"" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    
    
    
    
    if([self.building.image  isEqual: @"http://maps.rit.edu/images/photo-placeholder.gif"]){
            [html replaceOccurrencesOfString:@"[[[image]]]" withString: @"http://upload.wikimedia.org/wikipedia/en/thumb/4/48/RIT_Athletics_Logo.svg/1280px-RIT_Athletics_Logo.svg.png" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }else{
        
        [html replaceOccurrencesOfString:@"[[[image]]]" withString: self.building.image options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
        
    


    if (self.building.fulldescription != nil){
     [html replaceOccurrencesOfString:@"[[[full_description]]]" withString: self.building.fulldescription options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }else{
        [html replaceOccurrencesOfString:@"[[[full_description]]]" withString: @"No Description" options: NSLiteralSearch range: NSMakeRange(0, html.length)];
    }
    if (self.building.history != nil){
        [html replaceOccurrencesOfString:@"[[[history]]]" withString: self.building.history options: NSLiteralSearch range: NSMakeRange(0, html.length)];
     
    }else{
        [html replaceOccurrencesOfString:@"[[[history]]]" withString: @"No History" options: NSLiteralSearch range: NSMakeRange(0, html.length)];

    }
    // load html string into webView
    [self.webview loadHTMLString:html baseURL:nil];
    
    
    self.webview.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString *scheme = request.URL.scheme;
    if([scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"])
    {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
