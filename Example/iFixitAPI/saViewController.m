//
//  saViewController.m
//  iFixitAPI
//
//  Created by BaseInfinity on 02/18/2015.
//  Copyright (c) 2014 BaseInfinity. All rights reserved.
//

#import "saViewController.h"
#import <iFixitAPI.h>
#import <Wiki.h>

@interface saViewController ()

@end

@implementation saViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    [iFixitAPI getWikisForNamespace:@"CATEGORY"
                 usingDisplayOption:@"hierarchyOrder"
                       onCompletion:^(NSArray *wikis, NSError *error) {
                           if (!error) {
                               [self logTopLevelWikiTitles:wikis];
                           } else {
                               NSLog(@"there was an error retrieving wikis");
                           }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logTopLevelWikiTitles:(NSArray *)wikis {
    for (Wiki *wiki in wikis) {
        NSLog(@"wiki title: %@", wiki.title);
    }
}

@end
