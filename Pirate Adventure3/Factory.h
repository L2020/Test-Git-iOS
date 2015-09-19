//
//  Factory.h
//  Pirate Adventure3
//
//  Created by LJM on 9/12/15.
//  Copyright (c) 2015 LJM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCCharacter.h"
#import "CCboss.h"

@interface Factory : NSObject

-(NSArray *)tiles;            // 12 tiles per game
-(CCCharacter *)ccharacter;   // One Character instance per game
-(CCboss *)boss;              // One Boss instance per game
@end
