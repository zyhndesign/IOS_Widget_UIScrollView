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

const int PAGE_NUM = 1000;

int currentPage = 0;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    pageControlBeingUsed = NO;
    
    //NSArray *colors = [NSArray arrayWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor blueColor], nil];
    
    muDistionary = [NSMutableDictionary dictionaryWithCapacity:3];
    
    NSBundle *bundle = [NSBundle mainBundle];
    for (int i = 0; i < 2; i++)
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
        currentPage = floor((self.uiScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        NSLog(@"%i",currentPage);
        self.pageControl.currentPage = currentPage;
        [self addNewModelInScrollView:currentPage];
    }
}

- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"beigin. Drag..");
    pageControlBeingUsed = NO;
    
}

-(void) addNewModelInScrollView:(int) pageNum
{
    if (nil != uiScrollView)
    {
        NSLog(@"currentPage : %i",currentPage);
        
        NSBundle *bundle = [NSBundle mainBundle];
                
        UIView* subview1 = [muDistionary objectForKey:[NSNumber numberWithInt:(pageNum + 2)]];
        if (nil != subview1 && (pageNum + 2) <= PAGE_NUM)
        {
            NSLog(@"remove view with ID: %i",(pageNum + 2));
            [subview1 removeFromSuperview];
            [muDistionary removeObjectForKey:[NSNumber numberWithInt:(pageNum + 2)]];
        }
        
        UIView* subview2 = [muDistionary objectForKey:[NSNumber numberWithInt:(pageNum - 2)]];
        if (nil != subview2 && (pageNum - 2 >= 0))
        {
            NSLog(@"remove view with ID: %i",(pageNum - 2));
            [subview2 removeFromSuperview];
            [muDistionary removeObjectForKey:[NSNumber numberWithInt:(pageNum - 2)]];
        }
        
        UIView* subview3 = [muDistionary objectForKey:[NSNumber numberWithInt:(pageNum + 1)]];
        if (nil == subview3 && (pageNum + 1 <= PAGE_NUM))
        {
            CGRect frame;
            frame.origin.x = self.uiScrollView.frame.size.width * (pageNum + 1);
            frame.origin.y = 0;
            frame.size = self.uiScrollView.frame.size;
            
            subview3 = [[bundle loadNibNamed:@"ViewModel_iPad" owner:self options:nil] lastObject];
            subview3.frame = frame;
            [self.uiScrollView addSubview:subview3];
            
            NSLog(@"add view with ID: %i",(pageNum + 1));
            
            [muDistionary setObject:subview3 forKey:[NSNumber  numberWithInt:(pageNum + 1)]];
        }
        
        UIView* subview4 = [muDistionary objectForKey:[NSNumber numberWithInt:(pageNum - 1)]];
        if (nil == subview4 && (pageNum - 1 >= 0))
        {
            CGRect frame;
            frame.origin.x = self.uiScrollView.frame.size.width * (pageNum - 1);
            frame.origin.y = 0;
            frame.size = self.uiScrollView.frame.size;
            
            subview4 = [[bundle loadNibNamed:@"ViewModel_iPad" owner:self options:nil] lastObject];
            subview4.frame = frame;
            [self.uiScrollView addSubview:subview4];
            
            NSLog(@"add view with ID: %i",(pageNum - 1));
            
            [muDistionary setObject:subview4 forKey:[NSNumber  numberWithInt:(pageNum - 1)]];
        }
        
        
    }
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
