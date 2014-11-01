//
//  NCToolBelt.h
//
//
//  Created by Nick Chavez on 11/1/14.
//
//

#import <Foundation/Foundation.h>

@interface NCToolBelt : NSObject

+ (NCToolBelt *)sharedInstance;
- (NSBundle *)internalBundle;

@end
