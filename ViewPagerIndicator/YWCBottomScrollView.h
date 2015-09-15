//
//  YWCBottomScrollView.h
//  网易首页
//
//  Created by City--Online on 15/9/1.
//  Copyright (c) 2015年 City--Online. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^PageChangedBlock)(int index);

@interface YWCBottomScrollView : UIScrollView<UIScrollViewDelegate>

@property (nonatomic,copy) PageChangedBlock pageChangedBlock;
-(instancetype)initWithFrame:(CGRect)frame andItems:(NSArray*)viewControllorArray;
-(void)setShowPageWithIndex:(int)index;

@end
