//
//  TowerMagic.m
//  SolarColony
//
//  Created by Student on 2/18/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "TowerMagic.h"

@implementation TowerMagic
@synthesize  targetLocation;
@synthesize towerTowerId;

@synthesize towerLife;
@synthesize towerPower;
@synthesize towerLocation;
@synthesize towerSpeed;
@synthesize towerActiveRadius;
@synthesize isAttacking;
@synthesize selfLocation;
@synthesize isCharging;
@synthesize isDeath;

- (instancetype) initTower:(CGPoint)location{
    
    self = [super init];
    if (!self) return(nil);
    
    CCSprite* towerSprite = [CCSprite spriteWithFile:@"towerA.png"];
    [towerSprite setAnchorPoint:ccp(0.5,0.5)];
    //[self setLocation:ccp(200,200)];
    [self setLocation:location];
    towerTowerId=3;
    selfLocation=location;
    [self setLife:200];
    [self setPower:10];
    [self setSetSpeedAttack:20];
    [self setSetSpeedAttack:10];
    [self setIsAttacking:false];
    
    //bullet= [CCSprite spriteWithFile:@"bulletA.png"];
    isDeath=false;
    bullet = [[ NormalBullet alloc] initTower:location];
    
    [self setPosition:[self getLocation]];
    [self addChild:bullet];
    [self addChild:towerSprite];
    
    
    return self;
}

- (void) surveilance{
    
}
- (void) attack:(Soldier*) soldier{
    
}
- (void) attackTest:(CGPoint) soldier{
    
    [self setIsAttacking:true];
    
    //
    targetLocation=soldier;
  //  [self schedule: @selector(animatonAttack:) interval:1];
    bullet.targetLocation=soldier;
    [self schedule: @selector(animatonAttackTest:) interval:1];

    
}

-(void) animatonAttackTest: (ccTime) dt
{
  //  bullet.targetLocation=soldier;
    [bullet delegateRaceAttack];
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
}

-(void)beignattacked{
    
    if ([self getLife]<=0) {
        isDeath=true;
    }else{
        [self setLife:([self getLife]-10)];
    }
}
/*
 -(void) animatonAttack: (ccTime) dt
{
    // bla bla bla
    //   if (counterTest<=5) {
    CCLOG(@"SHOTTING");
    //    counterTest++;
    //     if ([self numberOfRunningActions]==0) {
    [bullet setVisible:true];
    //   CCLOG(@"coord x %f",targetLocation.x);
    //  CCLOG(@"coord x %f",targetLocation.y);
    CGPoint targetLocations = [self convertToNodeSpace:targetLocation];
    //   CCLOG(@"coord x %f",targetLocations.x);
    //   CCLOG(@"coord x %f",targetLocations.y);
    CGPoint targetPrevious = [bullet position];
    //   id appearAction = [CCFadeIn actionWithDuration:.1];
    // id disappearAction = [CCFadeOut actionWithDuration:.1];
    movePoint = [CCMoveTo actionWithDuration:.1 position:targetLocations];
    returnPoint = [CCMoveTo actionWithDuration:.01 position:ccp(targetLocations.x*((1)*0.1)  ,targetLocations.y*((1)*0.1))];
    
    //[bullet runAction:[CCSequence actions: movePoint,returnPoint,nil]];
    
    //  [bullet runAction:[CCJumpBy actionWithDuration:0.75 position:targetLocations height:25 jumps:4]];
    //
    //    }
    
     // ccBezierConfig bezier;
    // bezier.controlPoint_1 = ccp(targetPrevious.x*1.5, targetPrevious.y);
     //bezier.controlPoint_2 = ccp(targetPrevious.x, targetLocations.y*1.2);
     //bezier.endPosition = ccp(targetLocations.x,targetLocations.y);
     //CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:1 bezier:bezier];
     
    ccBezierConfig bezier;
    bezier.controlPoint_1 = ccp(targetLocations.x*.05, targetLocations.y*.75);
 //   bezier.controlPoint_2 = ccp(targetPrevious.x*.5, targetLocations.y*.5);
    bezier.controlPoint_2 = ccp(targetLocations.x*.75, targetLocations.y*.85);
    bezier.endPosition = ccp(targetLocations.x,targetLocations.y);
    CCBezierTo *bezierAction = [CCBezierTo actionWithDuration:.4 bezier:bezier];
    
     [bullet runAction:[CCSequence actions:bezierAction,returnPoint,nil]];
     
    
    //   }else{
    //   counterTest=0;
    
    [self unscheduleAllSelectors];
    [self setIsAttacking:false];
    // }
    

}
*/

-(bool) getIsattacking{
    
    return nil;
}
-(void) setIsattacking:(bool) attack{
    
}

-(CCMenu*)loadMenu{
    
    return nil;
}

-(void) setPower:(int) power{
    towerPower=power;
}

-(int) getPower{
    return nil;
}

-(void) setLife:(int) life{
    towerLife=life;
}

-(int) getLife{
    return towerLife;
}

-(void) setSetSpeedAttack:(int) speed{
    towerSpeed=speed;
}

-(int) getSetSpeedAttack{
    return nil;
}

-(void) setClosesTarget:(Soldier*) soldier{}

-(Soldier*) getClosesTarget{
    return nil;
}

-(void) setLocation:(CGPoint) location{
    towerLocation=location;
}
-(CGPoint) getLocation{
    return towerLocation;
}

-(void) destroyedAnimation{}

-(void)beingAttacked:(int)attack_power{
    /*  int newHealth = [self getHEALTH] - attack_power;
     [self setHEALTH:newHealth];*/
}

-(void)dealloc{}
@end
