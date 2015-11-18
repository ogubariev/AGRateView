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

NSInteger const kAGRateViewCountOfStars         = 10;
NSInteger const kAGRateViewFirstStarTag         = 10;
CGFloat   const kAGRateViewStarPadding          = 5.f;
CGFloat   const kAGRateViewStarDefaultSize      = 34.f;
CGFloat   const kAGRateViewStarsBorderWidth     = 0.5f;


#define kAGRateViewStarStartColor               [UIColor redColor]
#define kAGRateViewStarsFinishColor             [UIColor greenColor]
#define kAGRateViewStarsBorderColor             [UIColor blueColor]

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
    _countOfStars       = kAGRateViewCountOfStars;
    _rating             = self.countOfStars / 2;
    _starsBorderWidth   = kAGRateViewStarsBorderWidth;
    _starsBorderColor   = kAGRateViewStarsBorderColor;
    _starsStartColor    = kAGRateViewStarStartColor;
    _starsFinishColor   = kAGRateViewStarsFinishColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGFloat cellWidth = [self getCellWidth];
    CGFloat cellHeight = CGRectGetHeight(self.bounds);
    for (NSInteger i = 0; i < self.countOfStars; i++) {
        CGRect cellRect = CGRectMake(cellWidth * i, 0, cellWidth, cellHeight);
        UIColor *fillColor = i < self.rating ? [self colorForStarAtIndex: i] : [UIColor clearColor];
        [self drawStarIn:cellRect withFillColor:fillColor];
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
    if (_countOfStars != countOfStars) {
        _countOfStars = countOfStars;
        [self setNeedsDisplay];
    }
}

- (void)setStarsBorderWidth:(CGFloat)starsBorderWidth {
    if (_starsBorderWidth != starsBorderWidth) {
        _starsBorderWidth = starsBorderWidth;
        [self setNeedsDisplay];
    }
}


- (void)setStarsBorderColor:(UIColor *)starsBorderColor {
    if (_starsBorderColor != starsBorderColor) {
        _starsBorderColor = starsBorderColor;
        [_starsBorderColor setStroke];
        [self setNeedsDisplay];
    }
}

- (void)setStarsStartColor:(UIColor *)starsStartColor {
    if (_starsStartColor != starsStartColor) {
        _starsStartColor = starsStartColor;
        [self setNeedsDisplay];
    }
}

- (void)setStarsFinishColor:(UIColor *)starsFinishColor {
    if (_starsFinishColor != starsFinishColor) {
        _starsFinishColor = starsFinishColor;
        [self setNeedsDisplay];
    }
}

- (CGFloat)getCellWidth {
    return floor(CGRectGetWidth(self.bounds) / self.countOfStars);
}

- (CGFloat)getStarWidth {
    CGFloat selfHeight = CGRectGetHeight(self.bounds);
    CGFloat cellWidth = [self getCellWidth];
    
    CGFloat starSize = MIN(selfHeight, cellWidth);
    starSize -= 2 * kAGRateViewStarPadding;
    return MIN(starSize, kAGRateViewStarDefaultSize);
}

#pragma mark - Touches
-(void) updateRatingForPoint:(CGPoint)point {
    CGFloat selfWidth = CGRectGetWidth(self.bounds);
    CGFloat locationX = point.x;
    locationX = locationX < 0 ? 0 : locationX;
    locationX = locationX > selfWidth ? selfWidth : locationX;
    
    NSInteger rating = 0;
    for (NSInteger selectedStarIndex = 0 ; selectedStarIndex < self.countOfStars; selectedStarIndex++) {
        if (locationX > (selectedStarIndex * [self getCellWidth] + ([self getCellWidth] - [self getStarWidth]) / 2)) {
            rating ++;
        }
    }
    self.rating = rating;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if (touch) {
        [self updateRatingForPoint:[touch locationInView:self]];
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
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
- (UIColor *)colorForStarAtIndex:(NSInteger)starIndex {
    CGFloat startHue, finishHue;
    [self.starsStartColor getHue:&startHue saturation:nil brightness:nil alpha:nil];
    [self.starsFinishColor getHue:&finishHue saturation:nil brightness:nil alpha:nil];
    
    NSInteger startDeegrees = ceil(startHue * 360);
    startDeegrees %= 360;
    
    NSInteger finishDeegrees = ceil(finishHue * 360);
    if ((finishDeegrees % 360) != startDeegrees) {
        finishDeegrees %= 360;
    }
    
    CGFloat delta = (finishDeegrees - startDeegrees) / self.countOfStars;
    CGFloat newValue = startDeegrees + delta * starIndex;
    return [UIColor colorWithHue:newValue / 360  saturation:1.f brightness:1.f alpha:1.f];
}

-(void)drawStarIn:(CGRect)rect withFillColor:(UIColor *)fillColor {
    CGFloat starSize = [self getStarWidth];
    
    // Create a path for star shape
    UIBezierPath *starPath = [UIBezierPath new];
    [starPath setLineWidth:self.starsBorderWidth];
    [starPath moveToPoint:CGPointMake(starSize*0.0, starSize*0.35)];
    [starPath addLineToPoint:CGPointMake(starSize*0.35, starSize*0.35)];
    [starPath addLineToPoint:CGPointMake(starSize*0.50, starSize*0.0)];
    [starPath addLineToPoint:CGPointMake(starSize*0.65, starSize*0.35)];
    [starPath addLineToPoint:CGPointMake(starSize*1.00, starSize*0.35)];
    [starPath addLineToPoint:CGPointMake(starSize*0.75, starSize*0.60)];
    [starPath addLineToPoint:CGPointMake(starSize*0.85, starSize*1.00)];
    [starPath addLineToPoint:CGPointMake(starSize*0.50, starSize*0.75)];
    [starPath addLineToPoint:CGPointMake(starSize*0.15, starSize*1.00)];
    [starPath addLineToPoint:CGPointMake(starSize*0.25, starSize*0.60)];
    [starPath addLineToPoint:CGPointMake(starSize*0.0, starSize*0.35)];
    [starPath closePath];
    
    CGPoint startPoint = CGPointMake((CGRectGetWidth(rect) - starSize) / 2, (CGRectGetHeight(rect) - starSize) / 2);
    startPoint.x += rect.origin.x;
    startPoint.y += rect.origin.y;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(startPoint.x, startPoint.y);
    [starPath applyTransform:transform];
    
    [fillColor setFill];
    [self.starsBorderColor setStroke];

    [starPath fill];
    [starPath stroke];
}

@end
