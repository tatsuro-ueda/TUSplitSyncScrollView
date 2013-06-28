//
//  TUSplitedScrollView.h
//  TUSplitSyncScrollView
//
//  Created by stky on 2013/06/27.
//
//

#import <UIKit/UIKit.h>

@interface TUSplitedScrollView : UIScrollView <UIScrollViewDelegate>
{
    CGFloat _zoomStartScale;
}

@property (nonatomic, assign) CGFloat observedPresentScale;
@property (nonatomic, assign) CGFloat observedContentOffsetY;

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context;

@end
