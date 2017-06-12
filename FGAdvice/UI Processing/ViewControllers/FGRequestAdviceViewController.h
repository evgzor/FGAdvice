//
//  FGRequestAdviceViewController.h
//  FGAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkClient+LoadAdvice.h"
#import "FGAFavouritesService.h"

@interface FGRequestAdviceViewController : UIViewController

@property (nonatomic, strong) NetworkClient *httpClient;
@property (nonatomic, strong) FGAFavouritesService *favouritesService;

@end
