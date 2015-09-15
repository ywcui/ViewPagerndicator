//
//  TopScrollView.m
//  网易首页
//
//  Created by City--Online on 15/9/1.
//  Copyright (c) 2015年 City--Online. All rights reserved.
//

#import "YWCTopScrollView.h"

@interface YWCTopScrollView ()
{
    UIView *lineView;
}
@end

@implementation YWCTopScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andItems:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        //        self.backgroundColor = [UIColor redColor];
        
        _selectedIndex = 0;
        int width = KWidthForLeft;
        _buttonArray = [[NSMutableArray alloc] init];
        for (int i = 0 ; i < titleArray.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:KTopButtonFont];
            if (i == _selectedIndex) {
                [button setTitleColor:KRGBCOLOR(190, 2, 1) forState:UIControlStateNormal];
            }
            else{
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            NSString *title = [titleArray objectAtIndex:i];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = KButtonTagStart+i;
            //            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:KTopButtonFont] constrainedToSize:CGSizeMake(MAXFLOAT, 30) lineBreakMode:NSLineBreakByWordWrapping];
            float titlewidth=[self width:title heightOfFatherView:30 textFont:[UIFont systemFontOfSize:KTopButtonFont]];
            
            
            button.frame = CGRectMake(width, 5, titlewidth, 30);
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [_buttonArray addObject:button];
            width += titlewidth+KJIAN_GE_HEIGHT;
            
        }
        self.contentSize = CGSizeMake(width, self.frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        
        
        CGRect rc  = [self viewWithTag:_selectedIndex+KButtonTagStart].frame;
        lineView = [[UIView alloc]initWithFrame:CGRectMake(rc.origin.x, self.frame.size.height - 2, rc.size.width, 2)];
        lineView.backgroundColor = KRGBCOLOR(190, 2, 1);
        [self addSubview:lineView];
    }
    return self;
    
    
    
}

-(void)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if (_selectedIndex != btn.tag - KButtonTagStart)
    {
        [self selectIndex:(int)(btn.tag - KButtonTagStart) withFlag:NO];
    }
    
    //    for (UIButton *button in buttonArray)
    //    {
    //        if (button.tag == btn.tag) {
    //            [button setTitleColor:KRGBCOLOR(190, 2, 1) forState:UIControlStateNormal];
    //        }
    //        else{
    //            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //        }
    //    }
    
}

-(void)selectIndex:(int)index withFlag:(BOOL)flag
{
    for (UIButton *button in _buttonArray)
    {
        if (button.tag ==index + KButtonTagStart) {
            [button setTitleColor:KRGBCOLOR(190, 2, 1) forState:UIControlStateNormal];
        }
        else{
            
//            UIButton *btn=[UIButton buttonWithType:(UIButtonType)]
            
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    if (_selectedIndex != index)
    {
        
        _selectedIndex =  index;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect lineRC  = [self viewWithTag:_selectedIndex+KButtonTagStart].frame;
        NSLog(@"%@   %@",NSStringFromCGRect(lineRC),NSStringFromCGPoint(self.contentOffset));
        lineView.frame = CGRectMake(lineRC.origin.x, self.frame.size.height - 2, lineRC.size.width, 2);
        [UIView commitAnimations];
        
        if ( _topViewDelegate!= nil && [_topViewDelegate respondsToSelector:@selector(barSelectedIndexChanged:)])
        {
            if (!flag) {
                [_topViewDelegate barSelectedIndexChanged:_selectedIndex];
            }
            
        }
        
        if (lineRC.origin.x - self.contentOffset.x > 320 * 2  / 3)
        {
            int index = _selectedIndex;
            if (_selectedIndex + 2 <= _buttonArray.count)
            {
                index = _selectedIndex + 1;
            }
            else if (_selectedIndex + 1 < _buttonArray.count)
            {
                index = _selectedIndex + 1;
            }
            CGRect rc = [self viewWithTag:index +KButtonTagStart].frame;
            rc.origin.x += KWidthForRight;
            [self scrollRectToVisible:rc animated:YES];
        }
        else if ( lineRC.origin.x - self.contentOffset.x < 320 / 3)
        {
            int index = _selectedIndex;
            if (_selectedIndex - 2 >= 0)
            {
                index = _selectedIndex - 1;
            }
            else if (_selectedIndex - 1 >= 0)
            {
                index = _selectedIndex - 1;
            }
            CGRect rc = [self viewWithTag:index +KButtonTagStart].frame;
            rc.origin.x -= KWidthForRight;
            [self scrollRectToVisible:rc animated:YES];
        }
    }
    
    
}

-(CGFloat)width:(NSString *)contentString heightOfFatherView:(CGFloat)height textFont:(UIFont *)font{
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    CGSize size = [contentString sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, height)];
    return size.width ;
#else
    NSDictionary *attributesDic = @{NSFontAttributeName:font};
    CGSize size = [contentString boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size;
    return size.width;
#endif
}


@end
