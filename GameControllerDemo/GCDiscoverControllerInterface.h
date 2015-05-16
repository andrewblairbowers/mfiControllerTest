//
//  GCDiscoverControllerInterface.h
//  Floris Too
//
//  Created by Andrew Bowers on 2/22/14.
//  Copyright (c) 2014 GrillaDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameController/GameController.h>

@interface GCDiscoverControllerInterface : NSObject

-(void)discoverController:(void (^)(GCController *gameController))controllerCallbackSetup
     disconnectedCallback:(void (^)(void))controllerDisconnectedCallback;

-(void)stop;

@end
