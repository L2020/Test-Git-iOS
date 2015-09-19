//
//  ViewController.m
//  Pirate Adventure3
//
//  Created by LJM on 9/11/15.
//  Copyright (c) 2015 LJM. All rights reserved.
//

#import "ViewController.h"
#import "Factory.h"
#import "Tile.h"

//@interface ViewController ()
//
//@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    Factory *factory = [[Factory alloc] init];
    self.tiles = [factory tiles];
    self.ccharacter = [factory ccharacter];
    self.boss = [factory boss];
    
    self.currentPoint = CGPointMake(0, 0); //First tile in 2D Array 0.0

    //initial defaults
    [self updateCharacterAtStatsForArmor:nil withWeapons:nil withHealthEffect:0];
    
    [self updateTile];
    [self updateButtons];
}  //                            NSLog(@"%f %f", self.currentPoint.x, self.currentPoint.y);

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  IBActions
- (IBAction)actionButtonPressed:(UIButton *)sender
{
    Tile *tile = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    if (tile.healthEffect == -15){        // fight the boss
        self.boss.health = self.boss.health - self.ccharacter.damage;
    }
    [self updateCharacterAtStatsForArmor:tile.armor withWeapons:tile.weapon withHealthEffect:tile.healthEffect];
    
    if(self.ccharacter.health <=0)
    {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Death Message!"
                                      message:@"You have died please restart the game!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];

        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    } else if (self.boss.health <=0){
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"Victory Message!"
                                      message:@"You have defeated the bad Pirate Boss!"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    
    [self updateTile];
}

- (IBAction)northButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y + 1);
    [self updateButtons];
    [self updateTile];
}


- (IBAction)westButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x - 1 , self.currentPoint.y);
    [self updateButtons];
    [self updateTile];
    
}

- (IBAction)eastButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x + 1, self.currentPoint.y);
    [self updateButtons];
    [self updateTile];
    
}

- (IBAction)southButtonPressed:(UIButton *)sender
{
    self.currentPoint = CGPointMake(self.currentPoint.x, self.currentPoint.y -1);
    [self updateButtons];
    [self updateTile];
    
}

- (IBAction)resetButtonPressed:(UIButton *)sender {
    self.ccharacter = nil;  // clear ccharacter
    self.boss = nil;        // clear boss
    [self viewDidLoad];
    
}

#pragma mark -  helper methods
- (void)updateTile
{
    Tile *tileModel = [[self.tiles objectAtIndex:self.currentPoint.x] objectAtIndex:self.currentPoint.y];
    //   Tile
    self.storyLabel.text = tileModel.story;
    self.backgroundImageView.image  = tileModel.backgroundImage;
    //   CCCharacter->Armor
    self.armorLabel.text  = self.ccharacter.armor.name;
    self.healthLabel.text = [NSString stringWithFormat:@"%i",self.ccharacter.health];
    //   CCCharacter->Weapon
    self.damageLabel.text = [NSString stringWithFormat:@"%i",self.ccharacter.damage];
    self.weaponLabel.text = self.ccharacter.weapon.name;
    [self.actionButton setTitle:tileModel.actionButtonName forState:UIControlStateNormal];
                                                                     
}

-(void)updateButtons
{
    self.westButton.hidden  = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x -1, self.currentPoint.y)];
    self.eastButton.hidden  = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x +1, self.currentPoint.y)];
    self.northButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y +1)];
    self.southButton.hidden = [self tileExistsAtPoint:CGPointMake(self.currentPoint.x, self.currentPoint.y -1)];
    
}

-(BOOL)tileExistsAtPoint:(CGPoint)point  // for any point returns YES if the nav button should be hidden
{
    if (point.y >= 0 && point.x >=0 && point.x < [self.tiles count] &&
        point.y < [[self.tiles objectAtIndex:point.x] count]){
        return NO;
    }
    else {
        return YES;
    }
}

-(void)updateCharacterAtStatsForArmor:(Armor *)armor
            withWeapons:(Weapon *)weapon withHealthEffect:(int)healthEffect
{
    if (armor != nil){
        self.ccharacter.health = self.ccharacter.health -
            self.ccharacter.armor.health + armor.health;
        self.ccharacter.armor = armor;
    }
    else if (weapon !=nil){
        self.ccharacter.damage = self.ccharacter.damage -
            self.ccharacter.weapon.damage + weapon.damage;
        self.ccharacter.weapon = weapon;
    }
    else if (healthEffect != 0){
        self.ccharacter.health = self.ccharacter.health + healthEffect;
    }
    else {
        self.ccharacter.health = self.ccharacter.health + self.ccharacter.armor.health;
        self.ccharacter.damage = self.ccharacter.damage + self.ccharacter.weapon.damage;
    }
}



@end
