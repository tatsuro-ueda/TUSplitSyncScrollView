//
//  TUViewController.m
//  TUSplitSyncScrollView
//
//  Created by stky on 2013/06/27.
//
//

#import "TUSplitSyncScrollViewController.h"
#import "TUSplitedScrollView.h"
#import "TUSeparateBarView.h"

@interface TUSplitSyncScrollViewController ()

@end

@implementation TUSplitSyncScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 左側の枠を作るビューのインスタンスを作成する
    UIView* leftFrameView = [[UIView alloc]
                              initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 2 / 3, self.view.frame.size.height)];
    
    // 左側のTUSplitedScrollViewのインスタンスを作成する
    TUSplitedScrollView* leftSplitedScrollView = [[TUSplitedScrollView alloc] initWithFrame:self.view.frame];
    leftSplitedScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // 画像を入れたUIImageViewを用意する
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    UIImage* image = [UIImage imageNamed:@"flower.jpg"];
    imageView.image = image;
    
    // leftSplitedScrollViewに画像をセットする
    [leftSplitedScrollView addSubview:imageView];
    leftSplitedScrollView.contentSize = imageView.bounds.size;
    
    // rightSplitedScrollViewのインスタンスを作成する
    TUSplitedScrollView* rightSplitedScrollView = [[TUSplitedScrollView alloc] initWithFrame:self.view.frame];
    rightSplitedScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // rightSplitedScrollViewに画像をセットする
    UIImageView* imageView2 = [[UIImageView alloc] initWithFrame:self.view.frame];
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    imageView2.image = image;
    [rightSplitedScrollView addSubview:imageView2];
    rightSplitedScrollView.contentSize = imageView2.bounds.size;
    
    // しきりのビューを作る
    UIView* separateBarView = [[TUSeparateBarView alloc] initWithX:self.view.frame.size.width * 2 / 3 withView:leftFrameView];
    
    // TUSplitedScrollViewなどをself.viewにaddする
    [self.view addSubview:rightSplitedScrollView];
    [self.view addSubview:leftFrameView];
    leftFrameView.clipsToBounds = YES; // 左枠でクリップする
    [leftFrameView addSubview:leftSplitedScrollView];
    [self.view addSubview:separateBarView];
    [self.view setNeedsDisplay];
    
    // leftSplitedScrollViewの設定
    leftSplitedScrollView.minimumZoomScale = 0.001;
    leftSplitedScrollView.maximumZoomScale = 1000.0;
    leftSplitedScrollView.bounces = NO;
    
    // rightSplitedScrollViewの設定
    // 拡大縮小禁止にする
    rightSplitedScrollView.minimumZoomScale = 1.0;
    rightSplitedScrollView.maximumZoomScale = 1.0;
    
    int opt = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    
    // rightSplitedScrollViewをleftSplitedScrollViewのオブザーバにする
    [leftSplitedScrollView addObserver:rightSplitedScrollView forKeyPath:@"observedPresentScale" options:opt context:NULL];
    [leftSplitedScrollView addObserver:rightSplitedScrollView forKeyPath:@"observedContentOffsetY" options:opt context:NULL];
    
    // leftSplitedScrollViewをrightSplitedScrollViewのオブザーバにする
    [rightSplitedScrollView addObserver:leftSplitedScrollView forKeyPath:@"observedContentOffsetY" options:opt context:NULL];
    //    [rightSplitedScrollView addObserver:leftSplitedScrollView forKeyPath:@"observedPresentScale" options:opt context:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
