//
//  FGAdviceTableViewCell.m
//  FGAdvice
//
//  Created by ezorin@mera.ru on 13/06/2017.
//  Copyright © 2017 Eugene Zorin. All rights reserved.
//

#import "FGAdviceTableViewCell.h"

@implementation FGAdviceTableViewCell

- (void) applyModel: (FGAModel*) modelCell {
    self.textLabel.text = modelCell.text;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
