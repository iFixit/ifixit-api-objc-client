//
//  iFixitAPI.h
//  Pods
//
//  Created by Stefan Ayala on 2/18/15.
//
//

#ifndef Pods_iFixitAPI_h
#define Pods_iFixitAPI_h
#define BASE_URL @"https://www.ifixit.com/api/2.0"


#endif

#include <UIKit/UIKit.h>

@interface iFixitAPI : NSObject


+(void)getWikisForNamespace:(NSString*)nameSpace usingDisplayOption:(NSString*)display onCompletion:(void (^) (NSArray *wikis, NSError *error))handler;
@end
