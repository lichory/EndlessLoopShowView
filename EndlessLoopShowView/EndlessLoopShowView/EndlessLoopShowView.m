//
//  EndlessLoopShowView.m
//  EndlessLoopShowView
//
//  Created by apple on 16/9/26.
//  Copyright © 2016年 李重阳. All rights reserved.
//

#import "EndlessLoopShowView.h"

/*无限循环的视图 **/
@interface EndlessLoopShowView ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView * scrollView;

@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *centerImageView;
@property (nonatomic,strong) UIImageView *rightImageView;

@property (nonatomic,assign) NSInteger currentIndex;/* 当前滑动到了哪个位置**/
@property (nonatomic,assign) NSInteger imageCount;/* 图片的总个数 **/


//http://www.cnblogs.com/kenshincui/p/3913885.html#ImageViewer
@end

@implementation EndlessLoopShowView

#pragma mark - 生命周期

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupView];
    }
    return self;
}

- (void)setupView {
    
    _currentIndex = -1;
    [self addSubview:self.scrollView];
    //添加图片控件
    [self addImageViews];
}


- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.scrollView.frame = self.bounds;
    CGFloat imageW = CGRectGetWidth(self.scrollView.bounds);
    CGFloat imageH = CGRectGetHeight(self.scrollView.bounds);
    self.leftImageView.frame   = CGRectMake(imageW*0, 0, imageW, imageH);
    self.centerImageView.frame = CGRectMake(imageW*1, 0, imageW, imageH);
    self.rightImageView.frame  = CGRectMake(imageW*2, 0, imageW, imageH);
    self.scrollView.contentSize= CGSizeMake(imageW*3, 0);
    self.currentIndex = 0;
    [self setScrollViewContentOffsetCenter];
}


#pragma mark - 私有方法

#pragma mark - get/set方法
- (UIScrollView *)scrollView {
    
    if (_scrollView == nil) {
        
        _scrollView=[[UIScrollView alloc]init];
        //设置代理
        _scrollView.delegate=self;
        //设置分页
        _scrollView.pagingEnabled=YES;
        //去掉滚动条
        _scrollView.showsHorizontalScrollIndicator=NO;
    }
    return _scrollView;
}

/* 重写 setCurrent 方法 并且赋值 **/
- (void)setCurrentIndex:(NSInteger)currentIndex {
    
    if (_currentIndex != currentIndex) {
        
        _currentIndex = currentIndex;
        
        NSInteger leftImageIndex = (currentIndex+_imageCount-1)%_imageCount;
        NSInteger rightImageIndex= (currentIndex+1)%_imageCount;
        _centerImageView.image =[UIImage imageNamed:self.imageDataArr[currentIndex]];
        _leftImageView.image   =[UIImage imageNamed:self.imageDataArr[leftImageIndex]];
        _rightImageView.image  =[UIImage imageNamed:self.imageDataArr[rightImageIndex]];
        
        [self setScrollViewContentOffsetCenter];
        
        if ([self.delegate respondsToSelector:@selector(endlessLoop:scrollToIndex:)]) {
            
            [self.delegate endlessLoop:self scrollToIndex:currentIndex];
        }
        
    }
}

#pragma mark 添加图片三个控件
-(void)addImageViews {
    
    _leftImageView=[[UIImageView alloc]init];
    _leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_leftImageView];
    
    _centerImageView=[[UIImageView alloc]init];
    _centerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_centerImageView];
    
    _rightImageView=[[UIImageView alloc]init];
    _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_rightImageView];
}


/* 把scrollView 偏移到中心位置 **/
- (void)setScrollViewContentOffsetCenter {
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.bounds), 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint offset=[_scrollView contentOffset];
    if (offset.x>CGRectGetWidth(scrollView.frame)) { //向右滑动
        self.currentIndex=(self.currentIndex+1)%_imageCount;
    }else if(offset.x<CGRectGetWidth(scrollView.frame)){ //向左滑动
        self.currentIndex=(self.currentIndex+_imageCount-1)%_imageCount;
    }
}


#pragma mark - 公共方法
- (void)setImageDataArr:(NSArray *)imageDataArr {
    
    _imageDataArr = imageDataArr;
    self.imageCount = imageDataArr.count;
    self.currentIndex = 0;
}

@end
