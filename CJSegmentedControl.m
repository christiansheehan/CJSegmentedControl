//
//  CJSegmentedControl.m
//  SegmentedControllTestApp
//
//  Created by Christian Sheehan on 5/11/13.
//  Copyright (c) 2013 Christian Sheehan. All rights reserved.
//

#import "CJSegmentedControl.h"

#import "CJSegmentedControlSlider.h"

@interface CJSegmentedControl()

@property (assign, nonatomic) int numberOfSections;
@property(strong, nonatomic) CJSegmentedControlSlider *slider;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) NSArray *labels;
@end

@implementation CJSegmentedControl

- (void)awakeFromNib
{
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    
    self.numberOfSections = 3;
    
    self.labels = @[@"First", @"Second", @"Third"];
    
    self.slider = [self createSliderWithNumberOfSections:self.numberOfSections withLabels:self.labels];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.slider addGestureRecognizer:pan];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];

    
    [self addSnapToPosition:1 of:self.numberOfSections];
    
    [self drawLabels:self.labels];
}

- (void)drawLabels:(NSArray *)labels
{
    int i = 0;
    CGFloat widthOfSlider = self.frame.size.width / self.numberOfSections;
    for (NSString *text in labels) {
        
        CGRect labelFrame = CGRectMake(i * widthOfSlider, 0, widthOfSlider, self.frame.size.height);
        
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        [label setTextColor:self.tintColor];
        [label setText:text];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:label];
        i++;
    }
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    [self.animator removeAllBehaviors];
    CGPoint translation = [gesture translationInView:self];
    CGPoint sliderPosition = self.slider.center;
    sliderPosition.x += translation.x;
    
    self.slider.center = sliderPosition;
    [gesture setTranslation:CGPointZero inView:self];
    
    if ([gesture state] == UIGestureRecognizerStateCancelled || [gesture state] == UIGestureRecognizerStateFailed || [gesture state] == UIGestureRecognizerStateEnded) {
        int pos = (int)floor(((self.slider.frame.origin.x + self.slider.frame.size.width/2) / self.frame.size.width) * self.numberOfSections);
        
        if (pos < 0) pos = 0;
        if (pos >= self.numberOfSections) pos = self.numberOfSections - 1;
        
        [self addSnapToPosition:pos of:self.numberOfSections];
    }
}

- (void)tap:(UITapGestureRecognizer *)gesture
{
    [self.animator removeAllBehaviors];

    CGPoint touchPos = [gesture locationInView:self];
    
    int pos = (int)floor((touchPos.x / self.frame.size.width) * self.numberOfSections);
    
    if (pos < 0) pos = 0;
    if (pos >= self.numberOfSections) pos = self.numberOfSections - 1;
    
    [self addSnapToPosition:pos of:self.numberOfSections];
}

- (CJSegmentedControlSlider *)createSliderWithNumberOfSections:(int)numberOfSections withLabels:(NSArray *)labels
{
    CJSegmentedControlSlider *slider = [CJSegmentedControlSlider new];
    
    CGRect sliderFrame = CGRectMake(0, 0, self.frame.size.width/numberOfSections, self.frame.size.height);
    
    [slider setFrame:sliderFrame];
    [slider setNumberOfSections:numberOfSections];
    [slider setLabels:labels];
    
    [self addSubview:slider];
    return slider;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat lineWidth = 1;
    CGRect newRect = CGRectInset(rect, lineWidth/2.0, lineWidth/2.0);

    [self.tintColor setStroke];
    
    //draw the rounded rect
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:newRect cornerRadius:4];
    [path setLineWidth:lineWidth];
    [path stroke];
}

- (void)addSnapToPosition:(int)position of:(int)numberOfPostions
{
    CGFloat widthOfSlider = (self.frame.size.width / numberOfPostions);
    CGPoint centerOfSection = CGPointMake(widthOfSlider/2 + position * widthOfSlider, self.frame.size.height/2);
    
    UISnapBehavior *snapBehaviour = [[UISnapBehavior alloc] initWithItem:self.slider snapToPoint:centerOfSection];
    snapBehaviour.damping = 0.5f;
    [self.animator addBehavior:snapBehaviour];
    
    snapBehaviour.action = ^{
        [self.slider updateText];
    };
    
    UIDynamicItemBehavior *dynamicItem = [[UIDynamicItemBehavior alloc] initWithItems:@[self.slider]];
    dynamicItem.allowsRotation = NO;
    [self.animator addBehavior:dynamicItem];

}

@end
