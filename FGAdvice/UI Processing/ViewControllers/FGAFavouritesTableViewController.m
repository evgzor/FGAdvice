//
//  FGAFavouritesTableViewController.m
//  FGAdvice
//
//  Created by Eugene Zorin on 07/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "FGAFavouritesTableViewController.h"
#import "ActivityIndicator.h"
#import "FGAdviceTableViewCell.h"

@interface FGAFavouritesTableViewController ()

@property (strong, nonatomic) NSMutableArray<FGAModel*> *advices;

@property (nonatomic, strong) FGAFavouritesService *favouritesService;

@end

static NSString* const kCellIdentifier = @"adviceCell";

@implementation FGAFavouritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.favouritesService = [FGAFavouritesService sharedService];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDataFromDB) name:@"updateData" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateDataFromDB];
  
}

-(void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setAdvices:(NSMutableArray<FGAModel *> *)advices {
    _advices = advices;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)self.advices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FGAdviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    FGAModel *advice = self.advices[(NSUInteger)indexPath.row];
    [cell applyModel:advice];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        FGAModel *advice = self.advices[(NSUInteger)indexPath.row];
        [self.favouritesService removeFromFavourites:advice];
        [self.advices removeObjectAtIndex: (NSUInteger)indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - update data from db function

-(void) updateDataFromDB {
  [[ActivityIndicator sharedIndicator] startIndication];
  __weak typeof(self) weakSelf = self;
  [self.favouritesService loadFavouritesWithCompletionHandler:^(NSArray<FGAModel *> *advices) {
    dispatch_async(dispatch_get_main_queue(), ^{
      weakSelf.advices = [advices mutableCopy];
      [[ActivityIndicator sharedIndicator] stopIndication];
    });
  }];
}

@end
