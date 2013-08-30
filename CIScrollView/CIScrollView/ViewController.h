//
//  ViewController.h
//  CIScrollView
//
//  Created by 工业设计中意（湖南） on 13-8-30.
//  Copyright (c) 2013年 工业设计中意（湖南）. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIScrollViewDelegate>
{
    UIScrollView* uiScrollView;
    UIPageControl *pageControl;
    NSMutableDictionary *muDistionary;
    BOOL pageControlBeingUsed;
}

@property (strong, nonatomic) IBOutlet UIScrollView *uiScrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

- (IBAction)changPage:(id)sender;

@end
