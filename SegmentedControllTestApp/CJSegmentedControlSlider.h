//
//  CJSegmentedControlSlider.h
//  SegmentedControllTestApp
//
//  Created by Christian Sheehan on 5/11/13.
//  Copyright (c) 2013 Christian Sheehan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJSegmentedControlSlider : UIView

@property (assign, nonatomic) int numberOfSections;
@property (strong, nonatomic) NSArray *labelTitles;

- (void)updateText;

@end
