//
//  AGPoligoneShape.m
//  AGRateViewDemo
//
//  Created by Guillermo Saenz on 12/6/15.
//  Copyright © 2015 TIBCO JasperMobile. All rights reserved.
//

#import "AGPoligoneShape.h"

@implementation AGPoligoneShape

+ (void)drawShapeWithWidth:(CGFloat)width inFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor{
    
    //// Subframes
    CGRect group = CGRectMake(CGRectGetMinX(frame) + floor((CGRectGetWidth(frame) - width) * 0.50000 + 0.5), CGRectGetMinY(frame) + floor((CGRectGetHeight(frame) - width) * 0.50000 + 0.5), width, width);
    
    
    //// Group
    {
        //// Polygon Drawing
        UIBezierPath* polygonPath = UIBezierPath.bezierPath;
        [polygonPath moveToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.00000 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.85355 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.14645 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 1.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.50000 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.85355 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.85355 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.50000 * CGRectGetWidth(group), CGRectGetMinY(group) + 1.00000 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.14645 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.85355 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.00000 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.50000 * CGRectGetHeight(group))];
        [polygonPath addLineToPoint: CGPointMake(CGRectGetMinX(group) + 0.14645 * CGRectGetWidth(group), CGRectGetMinY(group) + 0.14645 * CGRectGetHeight(group))];
        [polygonPath closePath];
        [fillColor setFill];
        [polygonPath fill];
        [borderColor setStroke];
        [polygonPath setLineWidth:1];
        [polygonPath stroke];
    }
    
}

@end
