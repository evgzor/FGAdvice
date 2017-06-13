//
//  FGRequestAdviceViewController.m
//  FGAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "FGRequestAdviceViewController.h"
#import "FGAModel.h"
#import "SchedulerFactory.h"

@interface FGRequestAdviceViewController ()

@property (weak, nonatomic) IBOutlet UILabel *adviceLabel;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (nonatomic, strong) NetworkClient *webClient;

@property (nonatomic, strong) FGAFavouritesService *favouritesService;

@property (strong, nonatomic) FGAModel *advice;
@property (strong, nonatomic) id<ServiceScheduleProtocol> scheduler;

@end

@implementation FGRequestAdviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webClient = [[NetworkClient alloc] init];
    self.favouritesService = [FGAFavouritesService sharedService];
    _scheduler = [SchedulerFactory serviceSchedulerWithUserId:@"requestAdvice" andAction:^{
    [self reload:self.reloadButton];
  }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reload:self.reloadButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scheduler stop];
    [self.webClient cancel];
}

-(void)dealloc {
  [_scheduler stop];
  [self.webClient cancel];
}

- (void)setAdvice:(FGAModel *)advice {
    _advice = advice;
    self.adviceLabel.text = advice.text;
}

- (IBAction)reload:(id)sender {
    self.reloadButton.enabled = NO;
  [_scheduler stop];
    [self.webClient loadRandomAdviceWithCompletionHandler:^(FGAModel *advice, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scheduleRefreshTimer];
            self.reloadButton.enabled = YES;
            if (error == nil) {
                self.advice = advice;
            } else {
                self.adviceLabel.text = error.description;
            }
        });
    }];
}

- (void)scheduleRefreshTimer {
    if (self.view.window) {
        // The view is visible
      [_scheduler start];
      
    }
}

- (IBAction)addToFavourites:(id)sender {
    [self.favouritesService addToFavourites:self.advice];
}

@end
