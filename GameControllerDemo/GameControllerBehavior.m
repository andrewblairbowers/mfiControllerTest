//
//  GameControllerBehavior.m
//  Floris Too
//
//  Created by Andrew Bowers on 2/22/14.
//  Copyright (c) 2014 GrillaDev. All rights reserved.
//

#import "GameControllerBehavior.h"

NSString *const GCEJumpButtonKey = @"GCEJumpButtonKey";

@interface GameControllerBehavior()
@property (nonatomic, strong) NSMutableDictionary *buttonDownStates;
@end

@implementation GameControllerBehavior

- (id)init
{
  self = [super init];
  
  if (self != nil) {
    _buttonDownStates = [NSMutableDictionary dictionary];
  }
  return self;
}

- (void)setupGameController:(GCController *)controller
{
  
  __weak typeof(self) weakSelf = self;
  
  GCControllerButtonInput *jumpButton = nil;
  if (controller.gamepad) {
    jumpButton = controller.gamepad.buttonA;
  } else if (controller.extendedGamepad) {
    jumpButton = controller.extendedGamepad.buttonA;
  }
  
  jumpButton.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed) {
    
    BOOL firstExecutionForPress = [weakSelf.buttonDownStates[GCEJumpButtonKey] boolValue] ? NO : YES;
    
    if (pressed && firstExecutionForPress) {
      NSLog(@"JUMP!!");
    }
    weakSelf.buttonDownStates[GCEJumpButtonKey] = @(pressed);
  };
  
  
  GCControllerDirectionPad *dpad = nil;
  if (controller.gamepad) {
    dpad = controller.gamepad.dpad;
  } else if (controller.extendedGamepad) {
    dpad = controller.extendedGamepad.dpad;
  }
  
  dpad.valueChangedHandler = ^ (GCControllerDirectionPad *dpad, float xValue, float yValue) {
    NSLog(@"Changed xValue = %f",xValue);
    
  };
  
  controller.extendedGamepad.leftThumbstick.valueChangedHandler = dpad.valueChangedHandler;
  
}

@end
