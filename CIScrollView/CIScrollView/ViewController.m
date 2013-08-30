//
//  ViewController.m
//  CIScrollView
//
//  Created by 工业设计中意（湖南） on 13-8-30.
//  Copyright (c) 2013年 工业设计中意（湖南）. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
    
@end

@implementation ViewController

@synthesize uiScrollView, pageControl;

const int PAGE_NUM = 100;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControlBeingUsed = NO;
    
    //NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    muDistionary = [NSMutableDictionary dictionaryWithCapacity:3];
    
    NSBundle *bundle = [NSBundle mainBundle];
    for (int i = 0; i < 3; i++)
    {
        CGRect frame;
        frame.origin.x = self.uiScrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.uiScrollView.frame.size;
        
        UIView* subview = [[bundle loadNibNamed:@"ViewModel_iPad" owner:self options:nil] lastObject];
        subview.frame = frame;
        [self.uiScrollView addSubview:subview];
        [muDistionary setObject:subview forKey:[NSNumber  numberWithInt:i]];
        //[subview removeFromSuperview];
    }
    
    self.uiScrollView.contentSize = CGSizeMake(self.uiScrollView.frame.size.width * PAGE_NUM, self.uiScrollView.frame.size.height);
    
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = PAGE_NUM;
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"beigin...");
    if (!pageControlBeingUsed)
    {
        CGFloat pageWidth = self.uiScrollView.frame.size.width;
        int page = floor((self.uiScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        NSLog(@"%i",page);
        self.pageControl.currentPage = page;
        
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"beigin. Drag..");
    pageControlBeingUsed = NO;
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"beigin.. Uesd.");
    pageControlBeingUsed = NO;
}

- (IBAction)changePage:(id)sender
{
    NSLog(@"change page...");
    CGRect frame;
    frame.origin.x = self.uiScrollView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.uiScrollView.frame.size;
    [self.uiScrollView scrollRectToVisible:frame animated:YES];
    pageControlBeingUsed = YES;
}

- (IBAction)changPage:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
