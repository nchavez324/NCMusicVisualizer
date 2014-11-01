//
//  NCToolBelt.m
//
//
//  Created by Nick Chavez on 11/1/14.
//
//

#import <UIKit/UIKit.h>

#import "NCToolBelt.h"

static NCToolBelt *_sharedBelt;

@interface NCToolBelt ()

@property (strong, nonatomic) NSBundle *mInternalBundle;

@end

@implementation NCToolBelt

+ (NCToolBelt *)sharedInstance {
    
    if(!_sharedBelt)
        _sharedBelt = [[NCToolBelt alloc] init];
    
    return _sharedBelt;
}

- (NSBundle *)internalBundle {
    
    if(self.mInternalBundle)
        return self.mInternalBundle;
    
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[NSBundle mainBundle] bundlePath] error:NULL];
    
    for (NSString *fileName in files) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSURL *url = [NSURL fileURLWithPath:path];
        
        if([[url lastPathComponent] isEqual:@"NCMusicVisualizer.bundle"]){
            
            self.mInternalBundle = [NSBundle bundleWithPath:url.path];
        }
    }
    
    return self.mInternalBundle;
}

@end
