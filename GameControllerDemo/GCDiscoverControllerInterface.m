//
//  GCDiscoverControllerInterface.m
//  Floris Too
//
//  Created by Andrew Bowers on 2/22/14.
//  Copyright (c) 2014 GrillaDev. All rights reserved.
//

#import "GCDiscoverControllerInterface.h"

@interface GCDiscoverControllerInterface ()

@property (nonatomic,copy) void (^controllerCallbackSetup)(GCController *gameController);
@property (nonatomic,copy) void (^controllerDisconnectedCallback)(void);
@end

@implementation GCDiscoverControllerInterface

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:GCControllerDidConnectNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:GCControllerDidDisconnectNotification
                                                object:nil];
}

- (void)discoverController:(void (^)(GCController *gameController))controllerCallbackSetup
      disconnectedCallback:(void (^)(void))controllerDisconnectedCallback
{
  self.controllerCallbackSetup = controllerCallbackSetup;
  self.controllerDisconnectedCallback = controllerDisconnectedCallback;
  
  if ([self hasControllerConnected]) {
    NSLog(@"Discovery finished on first pass");
    [self foundController];
  } else {
    NSLog(@"Discovery happening patiently");
    [self patientlyDiscoverController];
  }
}

- (void)stop
{
  NSLog(@"Discovery stopped");
  [GCController stopWirelessControllerDiscovery];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:GCControllerDidConnectNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:GCControllerDidDisconnectNotification
                                                object:nil];
}

- (void)controllerDisconnected
{
  if (self.controllerDisconnectedCallback){
    self.controllerDisconnectedCallback();
  }
  [self patientlyDiscoverController];
}

- (void)patientlyDiscoverController

{
  
  [GCController startWirelessControllerDiscoveryWithCompletionHandler:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(foundController)
                                               name:GCControllerDidConnectNotification
                                             object:nil];
}

- (void)foundController
{
  NSLog(@"Found Controller");
  if (self.controllerCallbackSetup) {
    self.controllerCallbackSetup([[GCController controllers] firstObject]);
  }
  [self stop];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(controllerDisconnected)
                                               name:GCControllerDidDisconnectNotification
                                             object:nil];
}

- (BOOL)hasControllerConnected
{
  return [[GCController controllers] count] > 0;
}

@end