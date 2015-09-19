//
//  CCCharacter.h
//  Pirate Adventure3
//
//  Created by LJM on 9/14/15.
//  Copyright (c) 2015 LJM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Armor.h"
#import "Weapon.h"


@interface CCCharacter : NSObject

@property (strong, nonatomic) Armor *armor;
@property (strong, nonatomic) Weapon *weapon;
@property (nonatomic) int damage;
@property (nonatomic) int health;

@end
