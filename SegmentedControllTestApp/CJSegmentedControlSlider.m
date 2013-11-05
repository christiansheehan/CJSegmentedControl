//
//  CJSegmentedControlSlider.m
//  SegmentedControllTestApp
//
//  Created by Christian Sheehan on 5/11/13.
//  Copyright (c) 2013 Christian Sheehan. All rights reserved.
//

#import "CJSegmentedControlSlider.h"

@interface CJSegmentedControlSlider()

@property (strong, nonatomic) NSMutableArray *labels;

@end

@implementation CJSegmentedControlSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionOld context:nil];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setLabelTitles:(NSArray *)labelTitles
{
    _labelTitles = labelTitles;
    [self createLabels];
}

- (void)createLabels
{
    self.labels = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *text in self.labelTitles) {
        CGRect labelFrame = CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        [label setText:text];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:label];
        [self.labels addObject:label];
        i++;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath %@", keyPath);
    NSLog(@"object %@", object);
    NSLog(@"change %@", change);
    NSLog(@"context %@", context);
    
    [self updateText];
}

- (void)updateText
{
    int i = 0;
    for (UILabel *label in self.labels) {
        [label setFrame:CGRectMake(i * self.frame.size.width - self.frame.origin.x, 0, self.frame.size.width, self.frame.size.height)];
        i++;
    }
    
    //loop through all the centers of the sections
    //if a section center is real close then set text to that string, and set the opacity to equal the % close to the pos
}

- (void)drawRect:(CGRect)rect
{
    [self.tintColor setFill];
    
    //draw the rounded rect
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:4];
    [path fillWithBlendMode:kCGBlendModeNormal alpha:1.0];
}

@end
