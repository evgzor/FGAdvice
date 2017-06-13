//
//  FGAdviceTableViewCell.h
//  FGAdvice
//
//  Created by ezorin@mera.ru on 13/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGAModel.h"

@interface FGAdviceTableViewCell : UITableViewCell

- (void) applyModel: (FGAModel*) modelCell;

@end
