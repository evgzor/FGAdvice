//
//  FGAFavouritesTableViewController.h
//  FGAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGAFavouritesService.h"

@interface FGAFavouritesTableViewController : UITableViewController

-(void) updateDataFromDB;

@end
