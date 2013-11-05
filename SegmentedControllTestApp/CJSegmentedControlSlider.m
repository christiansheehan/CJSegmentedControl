//
//  CJSegmentedControlSlider.m
//  SegmentedControllTestApp
//
//  Created by Christian Sheehan on 5/11/13.
//  Copyright (c) 2013 Christian Sheehan. All rights reserved.
//

#import "CJSegmentedControlSlider.h"

@implementation CJSegmentedControlSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
//        [self addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"keypath %@", keyPath);
    NSLog(@"object %@", object);
    NSLog(@"change %@", change);
    NSLog(@"context %@", context);
}

- (void)updateText
{
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
