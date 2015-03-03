//
//  iFixitAPI.m
//  Pods
//
//  Created by Stefan Ayala on 2/18/15.
//
//

#import "iFixitAPI.h"
#import "RestKit.h"
#import "Wiki.h"


@implementation iFixitAPI

+(void)getWikisForNamespace:(NSString*)nameSpace usingDisplayOption:(NSString*)display onCompletion:(void (^) (NSArray *wikis, NSError *error))handler {
    
    // Create the mapping for Wiki's
    RKObjectMapping *wikiMapping = [RKObjectMapping mappingForClass:[Wiki class]];
    [wikiMapping addAttributeMappingsFromArray:@[@"title"]];
    
    // Create a similar mapping to allow for resursive mapping of wiki children
    RKObjectMapping *innerWikiMapping = [RKObjectMapping mappingForClass:[Wiki class]];
    [innerWikiMapping addAttributeMappingsFromArray:@[@"title"]];
    
    // Create the relationship
    [wikiMapping addPropertyMapping:[RKRelationshipMapping
                                     relationshipMappingFromKeyPath:@"children"
                                     toKeyPath:@"children"
                                     withMapping:innerWikiMapping]
    ];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor
                                                responseDescriptorWithMapping:wikiMapping
                                                method:RKRequestMethodGET
                                                pathPattern:nil
                                                keyPath:nil
                                                statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)
    ];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/wikis/%@?display=%@", BASE_URL, nameSpace, display]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc]
                                                        initWithRequest:request
                                                        responseDescriptors:@[ responseDescriptor ]
    ];

    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        handler(mappingResult.array, nil);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        handler(nil, error);
    }];
    
    [objectRequestOperation start];
}

@end