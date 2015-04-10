//
//  SearchVC.m
//  Test_ParseCSVtoTile
//
//  Created by Eduardo Flores on 4/8/15.
//  Copyright (c) 2015 Eduardo Flores. All rights reserved.
//

#import "SearchVC.h"
#import "Tile.h"
#import "TilesVC.h"

@interface SearchVC ()
{
    NSMutableArray *arrayOfTiles;
}
@property (weak, nonatomic) IBOutlet UITextField *textField_id;
@property (weak, nonatomic) IBOutlet UITextField *textField_name;

@end

@implementation SearchVC

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self generateTilesFromEachCSVRow:[self getRowsFromCSVFile:@"Test_CSV"]];
}

- (NSArray *) getRowsFromCSVFile:(NSString *)fileName
{
    // Read content of routes.txt into a string
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"csv"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // Then parse the string by csv
    NSArray *parsingRows = [content componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    NSMutableArray *rowsArray = [[NSMutableArray alloc]init];
    for (NSString *singleLine in parsingRows)
    {
        // check if line is empty for some reason
        if (![singleLine isEqualToString:@""])
        {
            NSArray *singleLineArray = [singleLine componentsSeparatedByString:@","];
            [rowsArray addObject:singleLineArray];
        }
    }
    return [rowsArray copy];
}

- (void) generateTilesFromEachCSVRow:(NSArray *)rows
{
    arrayOfTiles = [[NSMutableArray alloc]init];
    for (NSMutableArray *singleRow in rows)
    {
        Tile *tile = [[Tile alloc]init];

        tile.tile_coordinates = [singleRow objectAtIndex:0];
        tile.tile_personID = [singleRow objectAtIndex:1];
        tile.tile_personID_lc = [[singleRow objectAtIndex:1]lowercaseString];
        tile.tile_personName = [singleRow objectAtIndex:2];
        tile.tile_personName_lc = [[singleRow objectAtIndex:2]lowercaseString];
        
        [arrayOfTiles addObject:tile];
    }
}

- (Tile *) findTileByPersonID:(NSString *)personID
{
    for (Tile *tile in arrayOfTiles)
    {
        // currently assume the user knows the exact ID to look for
        if ([[personID lowercaseString] isEqualToString:tile.tile_personID_lc])
            return tile;
    }
    return nil;
}

// return an array of possible matches in case of partial search returning multiple results
- (NSArray *) findTileByPersonName:(NSString *)personName
{
    NSMutableArray *arrayOfPossibleResults = [[NSMutableArray alloc]init];
    for (Tile *tile in arrayOfTiles)
    {
        // allow partial search
        if ([tile.tile_personName_lc containsString:[personName lowercaseString]])
            [arrayOfPossibleResults addObject:tile];
    }
    return [arrayOfPossibleResults copy];
}

- (IBAction)button_SearchByID:(id)sender
{
    Tile *tileFound = [self findTileByPersonID:self.textField_id.text];
    [self performSegueWithIdentifier:@"segueSearchToTile" sender:tileFound];
}

- (IBAction)button_SearchByName:(id)sender
{
    NSLog(@"found = %@", [self findTileByPersonName:self.textField_name.text]);
}

- (void) dismissKeyboard
{
    [self.textField_id resignFirstResponder];
    [self.textField_name resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier]isEqualToString:@"segueSearchToTile"])
    {
        Tile *tileFound = (Tile *)sender;
        TilesVC *tvc = [segue destinationViewController];
        tvc.tileToFind = tileFound;
    }
}

@end

#pragma mark - MyView
@implementation MyView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    if (self.controller)
    {
        [self.controller dismissKeyboard];
    }
}

@end
















































