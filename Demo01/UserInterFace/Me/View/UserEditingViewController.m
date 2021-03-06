//
//  UserEditingViewController.m
//  Demo01
//
//  Created by Deo on 15/10/16.
//  Copyright © 2015年 deo. All rights reserved.
//

#import "UserEditingViewController.h"

#import "MeTopView.h"
#import "UIViewExt.h"
#import "Common.h"

#import "UserInterestViewController.h"
#import "MeEditListCollectionCell.h"

#import "DatePickerView.h"
#import "ToolTipView.h"
#define kEditListCollectionViewCellIdentifier @"kEdit_List_CollectionViewCell_ID"
@interface UserEditingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIAlertViewDelegate>{
    MeTopView *_topView;
    NSArray *_imgArr;
    NSArray *_titleArr;
    ToolTipView *_whiteView;
    UICollectionView *_editListCollectionView;
    DatePickerView *_datePicker;
}

@end

@implementation UserEditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
    self.view.backgroundColor=[UIColor whiteColor];
    [self _createTopView];
    [self _createSubViews];
    
    //性别选择弹窗
    [self _createWhiteView];
}

- (void)requestData{
    _imgArr=@[@"昵称2@",@"签名2@",@"生日2@",@"性别2@",@"所在地2@",@"me兴趣2@"];
    _titleArr=@[@"昵称",@"签名",@"生日",@"性别",@"所在地",@"兴趣"];
    [_editListCollectionView reloadData];
}
- (void)_createTopView{
    _topView=[[[NSBundle mainBundle] loadNibNamed:@"MeTopView" owner:self options:nil] lastObject];
    // 移除多余的控件
    [_topView.titleLabel removeFromSuperview];
    [_topView.userImgView removeFromSuperview];
    [_topView.avartImgView removeFromSuperview];
    [_topView.markLabel removeFromSuperview];
    [_topView.loadView removeFromSuperview];
    [_topView.rightButton removeFromSuperview];
    _topView.titleLabel.text=@"";
    [_topView.backButton addTarget:self
                            action:@selector(backButtonAction:)
                  forControlEvents:UIControlEventTouchUpInside];
    
    //保存按钮
    UIButton *saveButton=[UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.frame=CGRectMake(kScreenWidth-20-30, 32, 40, 20);
    [saveButton setTitle:@"保存" forState:UIControlStateNormal];
    saveButton.titleLabel.textColor=[UIColor whiteColor];
    saveButton.titleLabel.font=[UIFont systemFontOfSize:17];
    [saveButton addTarget:self
                   action:@selector(saveButtonAction:)
         forControlEvents:UIControlEventTouchUpInside];
    
    //用户头像
    [_topView.editButton setImage:[UIImage imageNamed:@"封面2@"]
                         forState:UIControlStateNormal];
    [_topView.editButton addTarget:self action:@selector(editButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_topView];
    
    UIImageView *downImgView=[[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth-74)/2, _topView.bottom-37, 74, 74)];
    downImgView.image=[UIImage imageNamed:@"下面头像外边2@"];
    [_topView addSubview:downImgView];
    
    UIImageView *userImgView=[[UIImageView alloc]initWithFrame:CGRectMake(downImgView.left+2, downImgView.top+2, 70, 70)];
    userImgView.image=[UIImage imageNamed:@"头像2@"];
    userImgView.layer.cornerRadius=userImgView.height/2;
    userImgView.clipsToBounds=YES;
    [_topView addSubview:userImgView];
    
    //更改头像按钮
    UIButton *photoButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [photoButton setImage:[UIImage imageNamed:@"更改头像2@"] forState:UIControlStateNormal];
    photoButton.frame=CGRectMake(userImgView.right-16, userImgView.bottom-15, 16, 15);
    [photoButton addTarget:self
                    action:@selector(photoButtonAction:)
          forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:photoButton];
    
    [self.view addSubview:saveButton];


}

- (void)_createSubViews{
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing=3;
    layout.minimumLineSpacing=3;
    layout.itemSize=CGSizeMake(kScreenWidth, 48);
    layout.sectionInset=UIEdgeInsetsMake(5, 0, 0, 0);
    CGRect frame=CGRectMake(0, _topView.bottom+37, kScreenWidth, kScreenHeight-_topView.height-37);
    _editListCollectionView=[[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    _editListCollectionView.backgroundColor=[UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    _editListCollectionView.delegate=self;
    _editListCollectionView.dataSource=self;
    [_editListCollectionView registerNib:[UINib nibWithNibName:@"MeEditListCollectionCell" bundle:nil] forCellWithReuseIdentifier:kEditListCollectionViewCellIdentifier];
    [self.view addSubview:_editListCollectionView];
}

//创建性别选择弹窗
- (void)_createWhiteView{
    NSArray *nameArr=@[@"男",@"女",@"取消"];
    _whiteView=[[ToolTipView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) WithArr:nameArr];
    
    [self.view insertSubview:_whiteView atIndex:self.view.subviews.count];
    _whiteView.hidden=YES;
    
    _datePicker=[[DatePickerView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_datePicker];
    _datePicker.hidden=YES;
}

#pragma mark - CollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MeEditListCollectionCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kEditListCollectionViewCellIdentifier forIndexPath:indexPath];
    cell.imgView.image=[UIImage imageNamed:_imgArr[indexPath.item]];
    cell.nameLabel.text=_titleArr[indexPath.item];
    if (indexPath.item>=2) {
        cell.contentTextField.hidden=YES;
        cell.contentLabel.hidden=NO;
    }else{
        cell.contentTextField.hidden=NO;
        cell.contentLabel.hidden=YES;
    }
    if (indexPath.item==2) {
        //出生日期
        _datePicker.block=^(NSString *value){
            cell.contentLabel.text=value;
        };
        
    }else if (indexPath.item==3) {
        //性别
        cell.contentLabel.text=@"女";
        //block的实现
        _whiteView.block=^(NSString *value){
            cell.contentLabel.text=value;
        };
    }
    return cell;
}

#pragma mark - CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item==3) {
        _whiteView.hidden=NO;
    }else if (indexPath.item==2){
        //出生日期
        _datePicker.hidden=NO;
    }
    if (indexPath.item==5) {
        //添加兴趣
        UserInterestViewController *interestVC=[[UserInterestViewController alloc]init];
        [self.navigationController pushViewController:interestVC animated:YES];
    }
}

#pragma mark - Button Action
- (void)saveButtonAction:(UIButton *)sender{
    NSLog(@"保存成功");
}

- (void)backButtonAction:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoButtonAction:(UIButton *)sender{
    
}

- (void)editButtonAction:(UIButton *)sender{
//    PersonInCenterViewController *personInCenterVC=[[PersonInCenterViewController alloc]init];
//    [self presentViewController:personInCenterVC animated:YES completion:nil];
}


@end
