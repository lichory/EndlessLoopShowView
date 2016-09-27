//
//  EndlessLoopShowView.h
//  EndlessLoopShowView
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EndlessLoopShowView;
@protocol EndlessLoopShowViewDelegate <NSObject>

@optional
/* 滑动到第几个位置 **/
- (void)endlessLoop:(EndlessLoopShowView*)showView scrollToIndex:(NSInteger)currentIndex;

@end

@interface EndlessLoopShowView : UIView

/* 返回图片的显示，可以传入 image ，imageName ，url ,自己可以自定义 **/
@property (nonatomic,strong) NSArray * imageDataArr;

@property (nonatomic,weak) id <EndlessLoopShowViewDelegate>delegate;

@end
