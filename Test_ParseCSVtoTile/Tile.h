//
//  Tile.h
//  Test_ParseCSVtoTile
//
//  Created by Eduardo Flores on 4/8/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tile : NSObject

@property (nonatomic, copy) NSString *tile_coordinates;
@property (nonatomic, copy) NSString *tile_personID;
@property (nonatomic, copy) NSString *tile_personID_lc;
@property (nonatomic, copy) NSString *tile_personName;
@property (nonatomic, copy) NSString *tile_personName_lc;

@end
