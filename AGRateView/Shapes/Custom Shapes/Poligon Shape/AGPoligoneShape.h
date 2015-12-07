//
//  AGPoligoneShape.h
//  AGRateViewDemo
//
//  Created by Guillermo Saenz on 12/6/15.
//  Copyright © 2015 TIBCO JasperMobile. All rights reserved.
//

@import UIKit;
@import Foundation;

@interface AGPoligoneShape : NSObject

+ (void)drawShapeWithWidth:(CGFloat)width inFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor;

@end
