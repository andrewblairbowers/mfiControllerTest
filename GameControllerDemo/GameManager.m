//
//  GameManager.m

//
//  Created by Andrew Bowers on 12/28/13.
//  Copyright (c) 2013 GrillaDev. All rights reserved.
//


#import "GameManager.h"
#import "SKTAudio.h"

@interface GameManager()

@end

@implementation GameManager {
    
  
}



+(GameManager*)sharedGameManager {
    static dispatch_once_t pred;
    static GameManager* gameManager = nil;
    dispatch_once(&pred, ^{gameManager = [[GameManager alloc] init]; });
    return gameManager;
}


-(id)init {
    self = [super init];
    if (self!=nil) {
      NSLog(@"%@%@", self, NSStringFromSelector(_cmd));
      //Game manager initialized

        
      [SKTAudio sharedInstance];
      
      _controllerDiscoveryInterface = [[GCDiscoverControllerInterface alloc] init];
      _controllerBehavior = [[GameControllerBehavior alloc] init];
        
      

    }
    return self;
}

- (void)setupGameController:(GCController *)gameController {
  
  [self.controllerBehavior setupGameController:gameController];
}



-(void)dealloc {
    NSLog(@"%@%@", self, NSStringFromSelector(_cmd));
}





@end




