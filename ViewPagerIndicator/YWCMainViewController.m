//
//  YWCMainViewController.m
//  网易首页
//
//  Created by City--Online on 15/9/1.
//  Copyright (c) 2015年 City--Online. All rights reserved.
//

#import "YWCMainViewController.h"
#import "YWCTopScrollView.h"
#import "YWCBottomScrollView.h"

@interface YWCMainViewController ()<TopScrollViewDelegate>

@property(nonatomic,strong) YWCTopScrollView *topScrollView;
@property(nonatomic,strong) YWCBottomScrollView *bottomScrollView;
@property(nonatomic,strong) NSMutableArray *titleArray;
@property(nonatomic,strong) NSMutableArray *viewControllerArray;
@end

@implementation YWCMainViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        _titleVcModelArray=[[NSMutableArray alloc]init];
        _titleArray=[[NSMutableArray alloc]init];
        _viewControllerArray=[[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) )
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = NO;
        self.navigationController.navigationBar.translucent =NO ;
        self.automaticallyAdjustsScrollViewInsets= YES;
    }
//    _titleArray=[[NSMutableArray alloc]init];
//    _viewControllerArray=[[NSMutableArray alloc]init];
    for (YWCTitleVCModel *model in _titleVcModelArray) {
        [_titleArray addObject:model.title];
        [_viewControllerArray addObject:model.viewController];
        [self addChildViewController:model.viewController];
    }
    
    _topScrollView=[[YWCTopScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40) andItems:_titleArray];
    _topScrollView.selectedIndex = 0;
    _topScrollView.topViewDelegate=self;
     [self.view addSubview:_topScrollView];
   
    __weak YWCMainViewController *weakSelf = self;
    _bottomScrollView=[[YWCBottomScrollView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.frame.size.height-40) andItems:_viewControllerArray];
    _bottomScrollView.pageChangedBlock=^(int index)
    {
        NSLog(@"cccc%d",index);
        [weakSelf.topScrollView selectIndex:index withFlag:YES];
    };
    [self.view addSubview:_bottomScrollView];
    
    
    
}
-(void)barSelectedIndexChanged:(int)newIndex
{
    NSLog(@"aaaa%ld",newIndex);
    [_bottomScrollView setShowPageWithIndex:newIndex];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
