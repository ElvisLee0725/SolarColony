//
//  GameStatusEssentialsSingleton.h
//  SolarColony
//
//  Created by Student on 2/19/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ModelsConstants.h"
#import "WaveController.h"
#import "SoldierController.h"
#import "GridMap.h"
#import "Soldier.h"
#import "Army.h"
#import "ArmyQueue.h"
#import "ArmyNetwork.h"


@interface GameStatusEssentialsSingleton : CCNode
+ (id)sharedInstance;
- (void) addTower:(CCNode*) tower;
- (void) addSoldier:(CCNode*) tower;
- (void) removeTowerAt:(int) index;
- (void) removeSoldierAt:(int) index;
- (CCNode*) getTowerAt:(int) index;
- (CCNode*) getSoldierAt:(int) index;
- (void) removeAllSoldiers;
- (void) removeAllTowers;

//add
- (BOOL)getWaveFirstVisit;
- (BOOL)getArmyFirstVisit;
- (int) GetCounterA;
- (int) GetCounterB;
- (int) GetCounterC;

@property(assign, nonatomic) NSMutableArray *soldiers;
@property(assign, nonatomic) ArmyNetwork* armynetwork;
@property(assign, nonatomic) NSMutableArray *towers;
@property(assign, nonatomic) NSString *userID;
@property(assign, nonatomic) NSString *raceType;
@property(assign, nonatomic) NSString *currentWave;
@property(assign, nonatomic) NSString *mapIndexName;
@property(assign, nonatomic) NSString *mapImageName;
@property(assign, nonatomic) int resourcesQuantity;
@property(assign, nonatomic) int score;
@property(assign, nonatomic) bool paused;

//add
@property(assign, nonatomic) bool WaveFirstVisit;
@property(assign, nonatomic) bool ArmyFirstVisit;
@property(assign, nonatomic) int counterA;
@property(assign, nonatomic) int counterB;
@property(assign, nonatomic) int counterC;
@property(assign, nonatomic) NSMutableArray *WaveSettings;
@property(assign, nonatomic) NSMutableArray *ArmySettings;

@end
