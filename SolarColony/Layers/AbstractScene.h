//
//  AbstractScene.h
//  SolarColony
//
//  Created by Student on 2/7/14.
//  Copyright (c) 2014 solarcolonyteam. All rights reserved.
//

#import "cocos2d.h"
#import "CCLayer.h"
#import <GameKit/GameKit.h>
#import "TransitionManagerSingleton.h"
#import "MusicManagerSingleton.h"
#import "GameStatusEssentialsSingleton.h"

@protocol  AbstractScene

    @required
        
        -(CCMenu*)loadMenu;
        -(void)moveToScene:(id)scene;
        -(void)dealloc;
        +(CCScene *) scene;

    @optional
        -(int)dummyMethodForReference:(int) value;

    @property(assign, nonatomic) int layerId;
    @property  CGSize mobileDisplaySize;
    

@end
