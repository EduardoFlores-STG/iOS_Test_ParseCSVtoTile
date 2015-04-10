//
//  TilesVC.m
//  Test_ParseCSVtoTile
//
//  Created by Eduardo Flores on 4/9/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "TilesVC.h"

#define kButtonColumns 26
#define kButtonRows 36

@interface TilesVC ()
{
    UIButton *buttons[kButtonColumns][kButtonRows];
}
@end

@implementation TilesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    Tile *tile = self.tileToFind;
    [self generateTilesAndFindTile:tile];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.frame];
    [imageView setImage:[UIImage imageNamed:@"NuSkin-Logo"]];
    [imageView setAlpha:0.2];
    [imageView setContentMode:UIViewContentModeCenter];
    [self.view addSubview:imageView];
    
    // pan gesture related
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePan:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
    // pinch gesture related
    self.pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinches:)];
    [self.view addGestureRecognizer:self.pinchGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateTilesAndFindTile:(Tile *)tile
{
    NSInteger intTagNumber  = 0;
    NSInteger intXTile;
    NSInteger intYTile;
    
    float tileWidth = self.view.bounds.size.width / kButtonColumns;
    float tileHeight = self.view.bounds.size.height / (kButtonRows + 1);
    
    int found_tile_coordinate_x = [[NSNumber numberWithChar:[tile.tile_coordinates characterAtIndex:0]]intValue];
    int found_tile_coordinate_y = [[tile.tile_coordinates substringWithRange:NSMakeRange(1, 2)]integerValue];
    
    // MASSIVE HACK!
    found_tile_coordinate_x = found_tile_coordinate_x - 65;
    
    for (int x = 0; x < kButtonColumns; x++)
    {
        for (int y = 1; y <= (kButtonRows + 1); y++)
        {
            intXTile  = x * tileWidth;
            intYTile = y * tileHeight;
            
            // create a value button, text, or image
            buttons[x][y] = [[UIButton alloc] initWithFrame:CGRectMake(intXTile, intYTile, tileWidth, tileHeight)];
            
            if (x == found_tile_coordinate_x && y == found_tile_coordinate_y)
                [buttons[x][y] setBackgroundImage:[UIImage imageNamed:@"square_red"] forState:UIControlStateNormal];
            else
                [buttons[x][y] setBackgroundImage:[UIImage imageNamed:@"square_black"] forState:UIControlStateNormal];
            
            [buttons[x][y] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            buttons[x][y].adjustsImageWhenHighlighted = NO;
            buttons[x][y].adjustsImageWhenDisabled = NO;
            buttons[x][y].tag = intTagNumber;
            buttons[x][y].enabled = NO;
            [self.view addSubview:buttons[x][y]];
            
            intTagNumber++;
        }
    }
}

- (void) handlePinches:(UIPinchGestureRecognizer *)paramSender
{
    if (paramSender.state == UIGestureRecognizerStateEnded)
    {
        self.currentScale = paramSender.scale;
    }
    else if (paramSender.state == UIGestureRecognizerStateBegan && self.currentScale != 0.0f)
    {
        paramSender.scale = self.currentScale;
    }
    if (paramSender.scale != NAN && paramSender.scale != 0.0)
    {
        paramSender.view.transform = CGAffineTransformMakeScale(paramSender.scale, paramSender.scale);
    }
}

// for Pan Gesture
- (void) handlePan:(UIPanGestureRecognizer *)paramSender
{
    if (paramSender.state != UIGestureRecognizerStateEnded &&
        paramSender.state != UIGestureRecognizerStateFailed)
    {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        paramSender.view.center = location;
    }
}
@end


















































