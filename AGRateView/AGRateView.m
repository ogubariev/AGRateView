/*
 Copyright (c) 2015, Alexey Gubarev
 All rights reserved.
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */


#import "AGRateView.h"

#import "AGStarShape.h"

NSInteger const kAGRateViewCountOfShapes        = 10;
NSInteger const kAGRateViewFirstShapesTag       = 10;
CGFloat   const kAGRateViewShapesPadding        = 5.f;
CGFloat   const kAGRateViewShapesDefaultSize    = 34.f;
CGFloat   const kAGRateViewShapesBorderWidth    = 0.5f;


#define kAGRateViewShapesStartColor              [UIColor redColor]
#define kAGRateViewShapesFinishColor             [UIColor greenColor]
#define kAGRateViewShapesBorderColor             [UIColor blueColor]

@implementation AGRateView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setDefaults];
    }
    return self;
}

- (void)setDefaults {
    _countOfShapes      = kAGRateViewCountOfShapes;
    _rating             = self.countOfShapes / 2;
    _shapesBorderWidth   = kAGRateViewShapesBorderWidth;
    _shapesBorderColor   = kAGRateViewShapesBorderColor;
    _shapesStartColor    = kAGRateViewShapesStartColor;
    _shapesFinishColor   = kAGRateViewShapesFinishColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat cellWidth = [self getCellWidth];
    CGFloat cellHeight = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < self.countOfShapes; i++) {
        CGRect cellRect = CGRectMake(cellWidth * i, 0, cellWidth, cellHeight);
        UIColor *fillColor = i < self.rating ? [self fillColorForShapeAtIndex:i] : [UIColor clearColor];
        [self drawShapeWithWidth:[self getShapeWidth] inFrame:cellRect borderWidth:self.shapesBorderWidth withFillColor:fillColor borderColor:[self borderColorForShapeAtIndex:i]];
    }
}

#pragma mark - Custom Accessories
- (void)setRating:(NSInteger)rating {
    if (_rating != rating) {
        _rating = rating;
        [self setNeedsDisplay];
    }
}

- (void)setCountOfStars:(NSInteger)countOfStars {
    if (_countOfShapes != countOfStars) {
        _countOfShapes = countOfStars;
        [self setNeedsDisplay];
    }
}

- (void)setStarsBorderWidth:(CGFloat)starsBorderWidth {
    if (_shapesBorderWidth != starsBorderWidth) {
        _shapesBorderWidth = starsBorderWidth;
        [self setNeedsDisplay];
    }
}


- (void)setStarsBorderColor:(UIColor *)starsBorderColor {
    if (_shapesBorderColor != starsBorderColor) {
        _shapesBorderColor = starsBorderColor;
        [_shapesBorderColor setStroke];
        [self setNeedsDisplay];
    }
}

- (void)setStarsStartColor:(UIColor *)starsStartColor {
    if (_shapesStartColor != starsStartColor) {
        _shapesStartColor = starsStartColor;
        [self setNeedsDisplay];
    }
}

- (void)setStarsFinishColor:(UIColor *)starsFinishColor {
    if (_shapesFinishColor != starsFinishColor) {
        _shapesFinishColor = starsFinishColor;
        [self setNeedsDisplay];
    }
}

- (CGFloat)getCellWidth {
    return floor(CGRectGetWidth(self.bounds) / self.countOfShapes);
}

- (CGFloat)getShapeWidth {
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    CGFloat cellWidth = [self getCellWidth];
    
    CGFloat starSize = MIN(selfHeight, cellWidth);
    starSize -= 2 * kAGRateViewShapesPadding;
    return MIN(starSize, kAGRateViewShapesDefaultSize);
}

#pragma mark - Touches
- (void) updateRatingForPoint:(CGPoint)point {
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat locationX = point.x;
    locationX = locationX < 0 ? 0 : locationX;
    locationX = locationX > selfWidth ? selfWidth : locationX;
    
    NSInteger rating = 0;
    for (NSInteger selectedStarIndex = 0 ; selectedStarIndex < self.countOfShapes; selectedStarIndex++) {
        if (locationX > (selectedStarIndex * [self getCellWidth] + ([self getCellWidth] - [self getShapeWidth]) / 2)) {
            rating ++;
        }
    }
    self.rating = rating;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch) {
        [self updateRatingForPoint:[touch locationInView:self]];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch) {
        [self updateRatingForPoint:[touch locationInView:self]];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self.delegate respondsToSelector:@selector(rateView:didChangedRating:)]) {
        [self.delegate rateView:self didChangedRating:self.rating];
    }
    if (self.ratingDidChangedBlock) {
        self.ratingDidChangedBlock(self, self.rating);
    }
}

#pragma mark - Private Api
- (UIColor *)borderColorForShapeAtIndex:(NSInteger)shapeIndex{
    if ([self.shapeSource respondsToSelector:@selector(rateView:borderColorForShapeAtIndex:)]) {
        return [self.shapeSource rateView:self borderColorForShapeAtIndex:shapeIndex];
    }else{
        return self.shapesBorderColor;
    }
}

- (UIColor *)fillColorForShapeAtIndex:(NSInteger)shapeIndex {
    if ([self.shapeSource respondsToSelector:@selector(rateView:fillColorForShapeAtIndex:)]) {
        return [self.shapeSource rateView:self fillColorForShapeAtIndex:shapeIndex];
    }else{
        CGFloat startHue, finishHue;
        [self.shapesStartColor getHue:&startHue saturation:nil brightness:nil alpha:nil];
        [self.shapesFinishColor getHue:&finishHue saturation:nil brightness:nil alpha:nil];
        
        NSInteger startDeegrees = ceil(startHue * 360);
        startDeegrees %= 360;
        
        NSInteger finishDeegrees = ceil(finishHue * 360);
        if ((finishDeegrees % 360) != startDeegrees) {
            finishDeegrees %= 360;
        }
        
        CGFloat delta = (finishDeegrees - startDeegrees) / self.countOfShapes;
        CGFloat newValue = startDeegrees + delta * shapeIndex;
        return [UIColor colorWithHue:newValue / 360  saturation:1.f brightness:1.f alpha:1.f];
    }
}

- (void)drawShapeWithWidth:(CGFloat)width inFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor{
    
    if ([self.shapeSource respondsToSelector:@selector(rateView:drawShapeWithWidth:inFrame:borderWidth:withFillColor:borderColor:)]){
        [self.shapeSource rateView:self drawShapeWithWidth:width inFrame:frame borderWidth:borderWidth withFillColor:fillColor borderColor:borderColor];
    }else{
        [AGStarShape drawShapeWithWidth:width inFrame:frame borderWidth:borderWidth withFillColor:fillColor borderColor:borderColor];
    }
}

@end
