//
//  BasicSoldier.m
//  SolarColony
//
//  Created by Student on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "BasicSoldier.h"
#import "GameStatsLoader.h"

@implementation BasicSoldier

+ (id) soldierWithRace:(NSString *) race
{
    NSMutableDictionary *stats = [GameStatsLoader loader].stats;
    if ([race isEqualToString:@"Human"]) {
        return([[BasicSoldier alloc]human_init:[stats[race][@"Runner"][@"health"] integerValue] ATTACK:1 Speed:[stats[race][@"Runner"][@"speed"] integerValue] ATTACK_SP:1]);
    }
         
    else if([race isEqualToString:@"Robot"]){
         return([[BasicSoldier alloc]robot_init:[stats[race][@"Runner"][@"health"] integerValue] ATTACK:1 Speed:[stats[race][@"Runner"][@"speed"] integerValue] ATTACK_SP:1]);
    }
    
    else{
        return([[BasicSoldier alloc]mage_init:[stats[race][@"Runner"][@"health"] integerValue] ATTACK:1 Speed:[stats[race][@"Runner"][@"speed"] integerValue] ATTACK_SP:1]);
    }
    
}
+ (instancetype) human:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]human_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
+ (instancetype) robot:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]robot_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
+ (instancetype) mage:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    return([[BasicSoldier alloc]mage_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp]);

}
- (instancetype) human_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:health ATTACK:attack Speed:speed ATTACK_SP:attack_sp];
    if (!self) return(nil);
    _soldier = [CCSprite spriteWithFile:@"HumanSoldier_Basic.gif"];
    type = @"H1";
    [self addChild:_soldier];
    return self;
}
- (instancetype) robot_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp];
    if (!self) return(nil);
    _soldier = [CCSprite spriteWithFile:@"RobotSoldier_Basic.png"];
    type = @"R1";
    [self addChild:_soldier];
    return self;
}
- (instancetype) mage_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp{
    self = [super runner_init:(int)health ATTACK:(int)attack Speed:(int)speed ATTACK_SP:(int)attack_sp];
    if (!self) return(nil);
    _soldier = [CCSprite spriteWithFile:@"MageSoldier_Basic.png"];
    type = @"M1";
    [self addChild:_soldier];
    return self;
}







@end
