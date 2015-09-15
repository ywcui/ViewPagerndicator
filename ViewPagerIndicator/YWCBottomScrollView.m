//
//  YWCBottomScrollView.m
//  网易首页
//
//  Created by City--Online on 15/9/1.
//  Copyright (c) 2015年 City--Online. All rights reserved.
//

#import "YWCBottomScrollView.h"

@interface YWCBottomScrollView ()
@property (nonatomic,strong) NSArray *viewControllorArray;

@end
@implementation YWCBottomScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)viewControllorArray
{
    self=[self initWithFrame:frame];
    if (self) {
        _viewControllorArray=viewControllorArray;
        self.contentSize=CGSizeMake(frame.size.width*viewControllorArray.count, frame.size.height);
        self.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
        self.directionalLockEnabled=YES;
        //控制控件遇到边框是否反弹
        self.bounces=NO;
        //控制垂直方向遇到边框是否反弹
        self.alwaysBounceVertical=NO;
        //控制水平方向遇到边框是否反弹
        self.alwaysBounceHorizontal=NO;
        //控制控件是否整页翻动
        self.pagingEnabled=YES;
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.delegate=self;
        for (int i=0; i<viewControllorArray.count; i++) {
            if (i==0) {
                UIViewController *vc=[viewControllorArray objectAtIndex:i];
                vc.view.frame=CGRectMake(frame.size.width*i, 0, frame.size.width, frame.size.height);
                [self addSubview:vc.view];
            }
        }
    }
    
    return self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger offsetx=scrollView.contentOffset.x;
//    NSLog(@"bbbb%ld",offsetx/self.frame.size.width);
    int index=offsetx/self.frame.size.width;
    _pageChangedBlock(index);
    [self initScrollViewWithIndex:index];
    //    [self setShowPageWithIndex:offsetx/_width withFlag:YES];
    
}
-(void)setShowPageWithIndex:(int)index
{
    [self scrollRectToVisible:CGRectMake(self.frame.size.width*index, 0, self.frame.size.width, self.frame.size.height) animated:NO];
    [self initScrollViewWithIndex:index];
}
-(void)initScrollViewWithIndex:(int)index
{
    for (int i=0; i<_viewControllorArray.count; i++) {
        UIViewController *vc=[_viewControllorArray objectAtIndex:i];
        if (i==index&&[vc.view superview]!=self) {
            
            vc.view.frame=CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height);
            [self addSubview:vc.view];
        }
        //        else
        //        {
        //            if ([vc.view superview] ==self) {
        //                [vc.view removeFromSuperview];
        //            }
        //
        //        }
        
    }
}



@end
