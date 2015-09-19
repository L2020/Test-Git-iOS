//
//  Tile.h
//  Pirate Adventure3
//
//  Created by LJM on 9/11/15.
//  Copyright (c) 2015 LJM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Weapon.h"
#import "Armor.h"

@interface Tile : NSObject

@property (strong, nonatomic) NSString *story;
@property (strong, nonatomic) UIImage *backgroundImage;
@property (strong, nonatomic) NSString *actionButtonName;
@property (strong, nonatomic) Weapon *weapon;
@property (strong, nonatomic) Armor  *armor;
@property (nonatomic) int     healthEffect;

@end
