//
//  localActivityTableView.m
//  Demo01
//
//  Created by Deo on 15/10/28.
//  Copyright © 2015年 deo. All rights reserved.
//

#import "localActivityTableView.h"
#import "ActivityTableViewCell.h"
#define kActivityTableViewCellIdentifier @"k_Activity_TableView_Cell_ID"

@implementation localActivityTableView

- (instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:kActivityTableViewCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor=[UIColor clearColor];
    return cell;
}

#pragma mark - TableView Delagate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 72;
}

@end
