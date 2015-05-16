//
//  GameManager.h
//  Floris Too
//
//  Created by Andrew Bowers on 12/28/13.
//  Copyright (c) 2013 GrillaDev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDiscoverControllerInterface.h"
#import "GameControllerBehavior.h"
#import <GameController/GameController.h>


@interface GameManager : NSObject

@property (nonatomic, strong) GCDiscoverControllerInterface *controllerDiscoveryInterface;
@property (nonatomic, strong) GameControllerBehavior *controllerBehavior;

+(GameManager*)sharedGameManager;

-(void)setupGameController:(GCController*)gameController;

@end

