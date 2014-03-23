//
//  ArmyQueue.m
//  SolarColony
//
//  Created by Charles on 2/19/14.
//  Copyright 2014 solarcolonyteam. All rights reserved.
//

#import "ArmyQueue.h"
#import "BasicSoldier.h"
#import "HumanSoldier.h"
#import "RobotSoldier.h"
#import "MageSoldier.h"
//#import "GridMap.h"
#import "GameStatusEssentialsSingleton.h"


static ArmyQueue *sharedInstance = nil;
int WAVE_START_RATE = 4;
int WAVE_SHOW_RATE = 2;
int ARMY_GEN_RATE = 12;
float AI_HEALTH = 15;
NSString *AI_REQUEST = @"AI";

@implementation ArmyQueue {
    BOOL _inWave;
    BOOL _showMSG;
    int _army_gen_tick;
    int _wave_show_tick;
    NSMutableArray *_show_queue;
    NSMutableArray *_sprite_queue;
}
+ (instancetype) layer
{
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}
- (instancetype) init
{
    self = [super init];
    if (self) {
        _queue = [[NSMutableArray alloc] init];
        _show_queue = [[NSMutableArray alloc] init];
        _sprite_queue = [[NSMutableArray alloc] init];
        _inWave = FALSE;
        _showMSG = TRUE;
        _army_gen_tick = 0;
        _wave_show_tick = 0;
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Waves: " fontName:@"Outlier.ttf" fontSize:15];
        [label setAnchorPoint:ccp(0,1)];
        [label setPosition:ccp(-100,0)];
        [self setAnchorPoint:ccp(0,1)];
        [self addChild:label];
        [self genertateAIarmy];
        [self schedule:@selector(update:) interval:1];
    }

    return self;
}
- (void) update:(ccTime)delta
{
    if(!_inWave){
        _army_gen_tick++;
        _wave_show_tick++;
        [self updateTick];
    }else{
        [[WaveController controller] update];
    }
}
- (void) updateTick
{
        if(_army_gen_tick == ARMY_GEN_RATE){
            _army_gen_tick = 0;
            [self genertateAIarmy];
        }
        if(_wave_show_tick == WAVE_SHOW_RATE){
            _wave_show_tick = 0;
            [self showArmy];
        }
}
- (void) endWave
{
    _inWave = FALSE;
    [self resumeAnimate];
}

#pragma mark - Army operation

- (void) pauseAnimate
{
    //[self pauseSchedulerAndActions];
    int count = [_sprite_queue count];
    for(int i=0; i<count; i++){
        CCSprite *qitem = (CCSprite*)[_sprite_queue objectAtIndex:i];
        [qitem pauseSchedulerAndActions];
    }
}

- (void) resumeAnimate
{
    //[self resumeSchedulerAndActions];
    int count = [_sprite_queue count];
    for(int i=0; i<count; i++){
        CCSprite *qitem = (CCSprite*)[_sprite_queue objectAtIndex:i];
        [qitem resumeSchedulerAndActions];
    }
    
}

- (void) startWave
{
    _inWave = TRUE;
    [self pauseAnimate];
    Wave *target = (Wave *)[_show_queue objectAtIndex:0];
    if(_showMSG){
        [[GridMap map] showMessage:[NSString stringWithFormat:@"%@ Attack!", target.attacker]];
        _showMSG = FALSE;
    }else{
        if ([target getEndFlag])
            _showMSG = TRUE;
    }
    [_show_queue removeObjectAtIndex:0];
    WaveSprite *qitem = (WaveSprite*)[_sprite_queue objectAtIndex:0];
    [_sprite_queue removeObjectAtIndex:0];
    [qitem setVisible:FALSE];
    [self removeChild:qitem cleanup:YES];
    [[WaveController controller] startWave:target];
}

- (void) showArmy
{
    int count = [_queue count];
    if(count == 0) {
        _wave_show_tick = WAVE_SHOW_RATE - 1;
        return;
    }
    Wave *target = (Wave *)[_queue objectAtIndex:0];
    [_queue removeObjectAtIndex:0];
    [_show_queue addObject:target];
    WaveSprite *qitem = [WaveSprite sprtieWithUserID:target.attacker Race:target.race];
    [qitem setPosition:ccp(0,-5)];
    [self addChild: qitem];
    [_sprite_queue addObject:qitem];
    id move = [CCMoveTo actionWithDuration:WAVE_START_RATE position:ccp(125,-5)];
    id wrapperAction = [CCCallFunc actionWithTarget:self selector:@selector(startWave)];
    id sequence = [CCSequence actions: move, wrapperAction, nil];
    [qitem runAction:sequence];
    //NSLog(@"ArmyQueue: %d waves in show queue", [_show_queue count]);
    //NSLog(@"ArmyQueue: %d waves in sprite queue", [_sprite_queue count]);
}

- (void) addArmy: (Army *) army
{
    int count = [army count];
    for(int i=0; i<count; i++){
        Wave* temp = [army popWave];
        if(i==count-1)
            [temp setEndFlag:TRUE];
        [_queue addObject:temp];
    }
    [army autorelease];
    NSLog(@"ArmyQueue: %d waves in queue", [_queue count]);
}

- (void) genertateAIarmy
{
    NSLog(@"ArmyQueue: generate AI army");
    // add one AI army in queue
    Army *army = [Army army: AI_REQUEST Attacker:AI_REQUEST];
    for(int x=0; x<3; x++){
        Wave *wave = [Wave wave];
        for (int i=0; i<3; i++) {
            //CCLOG(@"runner!!!");
            Soldier *temp;
            if(x ==0){
                wave.race = @"human";
                temp = [BasicSoldier human:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }else if(x == 1){
                wave.race = @"robot";
                temp = [BasicSoldier robot:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }else{
                wave.race = @"magic";
                temp = [BasicSoldier mage:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }
            [wave addSoldier: temp];
        }
        for (int i=0; i<3; i++) {
            //CCLOG(@"attacker!!!");
            Soldier *temp;
            if(x ==0)
                temp = [HumanSoldier typeA:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else if(x == 1)
                temp = [RobotSoldier typeA:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else
                temp = [MageSoldier typeA:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            [wave addSoldier: temp];
        }
        [army addWave: wave];
    }
    [self addArmy: army];
    if(AI_HEALTH < 100)
        AI_HEALTH *= 1.5f;
    
}

- (void) genertateTestarmy
{
    NSLog(@"ArmyQueue: generate Test army");
    // add one AI army in queue
    NSString *att;
    int type;
    int basic_num;
    int spec_num;
    if([[[GameStatusEssentialsSingleton sharedInstance] userID] isEqualToString:@"User1"]){
        att = @"User2";
        type = 2;
    }else{
        att = @"User1";
        type = 1;
    }
    Army *army = [Army army: att Attacker:att];
    for(int x=0; x<3; x++){
        Wave *wave = [Wave wave];
        if(x == 0){
            if(type == 1){
                basic_num = 5;
                spec_num = 0;
            }else if(type == 2){
                basic_num = 5;
                spec_num = 0;
            }
        }else if(x == 1){
            if(type == 1){
                basic_num = 0;
                spec_num = 5;
            }else if(type == 2){
                basic_num = 0;
                spec_num = 5;
            }
        }else{
            if(type == 1){
                basic_num = 5;
                spec_num = 5;
            }else if(type == 2){
                basic_num = 5;
                spec_num = 5;
            }
        }
        for (int i=0; i<basic_num; i++) {
            //CCLOG(@"runner!!!");
            Soldier *temp;
            if(type == 1){
                wave.race = @"human";
                temp = [BasicSoldier human:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }else if(type == 2){
                wave.race = @"robot";
                temp = [BasicSoldier robot:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            }
            [wave addSoldier: temp];
        }
        for (int i=0; i<spec_num; i++) {
            //CCLOG(@"attacker!!!");
            Soldier *temp;
            if(type == 1)
                temp = [HumanSoldier typeA:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            else if(type == 2)
                temp = [RobotSoldier typeA:(int)AI_HEALTH ATTACK:(int)80 Speed:(int)1 ATTACK_SP:(int)2];
            [wave addSoldier: temp];
        }
        [army addWave: wave];
    }
    [self addArmy: army];
    if(AI_HEALTH < 100)
        AI_HEALTH *= 1.5f;
    
}
@end

@implementation WaveSprite

+ (id) sprtieWithUserID: (NSString *) uid Race: (NSString *) race
{
    return [[[self alloc] init: uid Race:race] autorelease];
}
- (id) init: (NSString *) uid Race: (NSString *) race
{
    self = [super init];
    if (!self) return(nil);
    // initial sprite and label
    CCSprite *sprite;
    if([race isEqualToString: @"human"]){
        sprite = [CCSprite spriteWithFile:@"angrybomb.png"];
    }else if ([race isEqualToString: @"robot"]){
        sprite = [CCSprite spriteWithFile:@"angrybomb.png"];
    }else{
        sprite = [CCSprite spriteWithFile:@"angrybomb.png"];
    }
    [self addChild:sprite];
    CCLabelTTF *label = [CCLabelTTF labelWithString:uid fontName:@"Outlier.ttf" fontSize:10];
    [label setAnchorPoint:ccp(0.5,0.5)];
    CGSize size = sprite.boundingBox.size;
    [label setPosition:ccp(size.width*0.5, size.height*0.5)];
    [self addChild:label];
    return self;
}

- (void) dealloc
{
    [self release];
    [super dealloc];
}

@end
