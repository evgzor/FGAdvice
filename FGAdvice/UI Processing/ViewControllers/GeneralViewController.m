//
//  GeneralViewController.m
//  FGAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "GeneralViewController.h"
#import "FGAFavouritesTableViewController.h"

typedef NS_ENUM(NSUInteger, FGSegments) {
  FGSegmentsAdvice,
  FGSegmentsAdviceFavorite,
};

static const NSTimeInterval animationDuration = 0.5f;

@interface GeneralViewController ()

@property (weak, nonatomic) IBOutlet UIView* containerAdvice;
@property (weak, nonatomic) IBOutlet UIView* containerFavorite;

@end

@implementation GeneralViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.containerAdvice.alpha = 1.0;
  self.containerFavorite.alpha = 0.0;
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - user interaction

-(IBAction)showComponents:(UISegmentedControl*)sender {
  switch (sender.selectedSegmentIndex) {
    case FGSegmentsAdvice:
    {
      [UIView animateWithDuration:animationDuration animations:^{
        self.containerAdvice.alpha = 1.0;
        self.containerFavorite.alpha = 0.0;
      }];
      break;
    }
    case FGSegmentsAdviceFavorite:
    {
      [UIView animateWithDuration:animationDuration animations:^{
        self.containerAdvice.alpha = 0.0;
        self.containerFavorite.alpha = 1.0;
        
      }];
      break;
    }
    default:
      break;
  }
}



@end
