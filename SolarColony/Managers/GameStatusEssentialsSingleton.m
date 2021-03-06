//
//  GameStatusEssentialsSingleton.m
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "GameStatusEssentialsSingleton.h"
#import "TransitionManagerSingleton.h"
#import "race.h"
#import "HomeScene.h"
#import "Friends.h"
#import "Settings.h"
#import "defense.h"
#import "GameLandingScene.h"
#import "AttackScene.h"

@implementation GameStatusEssentialsSingleton
@synthesize soldiers;
@synthesize towers;
@synthesize resourcesQuantity;
@synthesize score;
@synthesize raceType;
@synthesize userID;
@synthesize armynetwork;
@synthesize currentWave;
@synthesize paused;
@synthesize mapImageName;
@synthesize mapIndexName;
@synthesize WaveFirstVisit;
@synthesize ArmyFirstVisit;
//add

@synthesize counterA;
@synthesize counterB;
@synthesize counterC;
@synthesize WaveSettings;
@synthesize ArmySettings;

static GameStatusEssentialsSingleton *sharedInstance = nil;

// Get the shared instance and create it if necessary.
+ (GameStatusEssentialsSingleton *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

// We can still have a regular init method, that will get called the first time the Singleton is used.
- (id)init
{
    self = [super init];
    
    if (self) {
        // Work your initialising magic here as you normally would
        WaveSettings = [[NSMutableArray alloc] init];
        soldiers=[[NSMutableArray alloc] init];
        towers=[[NSMutableArray alloc] init];
        armynetwork=[[ArmyNetwork alloc] init];
        //initiallize default values
        resourcesQuantity=100;
        score=0;
        raceType=@"Robot";
        currentWave=@"w1";
        mapImageName = @"";
        mapIndexName = @"";
        paused=false;
        WaveFirstVisit = true;
        ArmyFirstVisit = true;
        
        //add
        
        counterA = 0;
        counterB = 0;
        counterC = 0;
        //SHOULD READ ALL OF THIS FROM THE DB
        
    }
    
    return self;
}

- (void) addTower:(CCNode*) tower{
    [towers addObject:tower];
}
- (void) addSoldier:(CCNode*) soldier{
    [soldiers addObject:soldier];
}
- (void) removeTowerAt:(int) index{
     
    [towers removeObjectAtIndex:index];
}

- (void) removeSoldierAt:(int) index{
    [soldiers removeObjectAtIndex:index];
}


- (CCNode*) getTowerAt:(int) index{
    return [towers objectAtIndex:index];
}


- (CCNode*) getSoldierAt:(int) index{
    return [soldiers objectAtIndex:index];
}


- (void) removeAllSoldiers{
    [soldiers removeAllObjects];
}

- (void) removeAllTowers{
    [towers removeAllObjects];
}




// Your dealloc method will never be called, as the singleton survives for the duration of your app.
// However, I like to include it so I know what memory I'm using (and incase, one day, I convert away from Singleton).
-(void)dealloc
{
    // I'm never called!
    [super dealloc];
}

// We don't want to allocate a new instance, so return the current one.
+ (id)allocWithZone:(NSZone*)zone {
    return [[self sharedInstance] retain];
}

// Equally, we don't want to generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Once again - do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// This function is empty, as we don't want to let the user release this object.
- (oneway void)release {
    
}

//Do nothing, other than return the shared instance - as this is expected from autorelease.
- (id)autorelease {
    return self;
}


//add
- (BOOL)getWaveFirstVisit {
    return WaveFirstVisit;
}
- (BOOL)getArmyFirstVisit {
    return ArmyFirstVisit;
}
- (int) GetCounterA{
    return counterA;
}
- (int) GetCounterB{
    return counterB;
}
- (int) GetCounterC{
    return counterC;
}


@end