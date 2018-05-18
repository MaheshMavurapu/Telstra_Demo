//
//  ListTableViewCell.h
//  Telestra_Demo
//
//  Created by Wipro on 17/05/18.
//  Copyright © 2018 Mahesh Mavurapu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemListModel.h"
#import "ItemListViewModel.h"

@interface ListTableViewCell : UITableViewCell <ImageProtocol>

@property(nonatomic, strong) UIImageView *itemImageView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *descriptionLabel;

-(void)setDetails:(ItemListModel *)item;
-(void)setImageFromURL:(NSURL*)imageURL;

@end
