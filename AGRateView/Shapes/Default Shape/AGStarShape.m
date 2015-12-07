//
//  AGStarShape.m
//  AGRateViewDemo
//
//  Created by Guillermo Saenz on 12/6/15.
//  Copyright © 2015 TIBCO JasperMobile. All rights reserved.
//

#import "AGStarShape.h"

@implementation AGStarShape

+ (void)drawShapeWithWidth:(CGFloat)width inFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor{
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - width) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - width) * 0.50000) + 0.5, width, width);
    
    
    //// Group
    {
        //// Star Drawing
        UIBezierPath* starPath = UIBezierPath.bezierPath;
        [starPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.61164 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.34634 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.97553 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.34549 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.68064 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.55869 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.79389 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.90451 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.68994 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.20611 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.90451 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.31936 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.55869 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.02447 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.34549 * CGRectGetHeight(group))];
        [starPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.38836 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.34634 * CGRectGetHeight(group))];
        [starPath closePath];
        [fillColor setFill];
        [starPath fill];
        [borderColor setStroke];
        starPath.lineWidth = borderWidth;
        [starPath stroke];
    }
}

@end
