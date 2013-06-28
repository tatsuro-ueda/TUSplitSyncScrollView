//
//  TUSplitedScrollView.m
//  TUSplitSyncScrollView
//
//  Created by stky on 2013/06/27.
//
//

#import "TUSplitedScrollView.h"

@implementation TUSplitedScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.delegate = self;
        _zoomStartScale = 1.0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UIImageView class]]) {
            return subview;
        }
    }
    return nil;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    _zoomStartScale = self.observedPresentScale;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    // プロパティzoomScaleをプロパティscaleにセットすることでzoomScaleの変化を監視できるようにする
    self.observedPresentScale = _zoomStartScale * self.zoomScale;
    //    printf("%f\n", self.observedPresentScale);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // プロパティを監視できるようにする
    self.observedContentOffsetY = self.contentOffset.y;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;
{
    if (keyPath == @"observedPresentScale") {
        // 自身のzoomScaleに監視しているobservedPresentScaleの値を代入する
        // まず拡大縮小可能にする
        self.maximumZoomScale = 1000.0;
        self.minimumZoomScale = 0.001;
        self.zoomScale = [change[@"new"] floatValue];
        // ここで拡大縮小禁止にする
        self.maximumZoomScale = self.zoomScale;
        self.minimumZoomScale = self.zoomScale;
        printf("zoomScale = %f\n", self.zoomScale);
    }
    else if (keyPath == @"observedContentOffsetY") {
        self.contentOffset = CGPointMake(self.contentOffset.x, [change[@"new"] floatValue]);
    }
}

@end
