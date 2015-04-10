//
//  TilesVC.h
//  Test_ParseCSVtoTile
//
//  Created by Eduardo Flores on 4/9/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tile.h"

@interface TilesVC : UIViewController

@property (nonatomic, strong) Tile *tileToFind;

@property (nonatomic, retain) UIPinchGestureRecognizer *pinchGestureRecognizer;
@property (nonatomic, retain) UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, unsafe_unretained) CGFloat currentScale;

@end
