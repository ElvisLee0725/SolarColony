//
//  Wave.m
//  SolarColony
//
//  Created by Charles on 3/5/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "Wave.h"

@implementation Wave {
    NSMutableArray *_list;
    BOOL endofArmy;
}
@synthesize race;
@synthesize request_id;
@synthesize attacker;

#pragma mark - Create and Destroy

+ (instancetype) wave
{
    return [[self alloc] init];
}

- (instancetype) init
{
    self = [super init];
    if (!self) return(nil);
    _list = [[NSMutableArray alloc] init];
    endofArmy = FALSE;
    return self;
}

-(BOOL)getEndFlag{
    return endofArmy;
}

-(void)setEndFlag:(BOOL)flag{
    endofArmy = flag;
}

- (void) dealloc
{
    if(endofArmy){
        [request_id release]; request_id = nil;
        [race release]; race = nil;
        [attacker release]; attacker = nil;
    }
    [_list release]; _list = nil;
    [self release];
    [super dealloc];
    //CCLOG(@"A wave was deallocated");
}

#pragma mark - operation of soldiers

- (int) count
{
    return [_list count];
}
- (void) addSoldier: (Soldier *) sol
{
    [_list addObject: sol];
}

- (Soldier *) popSoldier
{
    int r = arc4random() % [_list count];
    Soldier *sol = (Soldier *)[_list objectAtIndex: r];
    [_list removeObjectAtIndex: r];
    return sol;
}

- (NSMutableArray *) getList
{
    return _list;
}

@end