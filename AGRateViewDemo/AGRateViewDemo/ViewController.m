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


#import "ViewController.h"
#import "AGRateView.h"

#import "AGStarShape.h"
#import "AGPoligoneShape.h"

@interface ViewController () <AGRateViewDelegate, AGRateViewShapeSource>
@property (weak, nonatomic) IBOutlet AGRateView *rateView;
@property (weak, nonatomic) IBOutlet AGRateView *customShapeRateView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLbl;
@property (weak, nonatomic) IBOutlet UILabel *customShapeRatingLbl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rateView.ratingDidChangedBlock = ^(AGRateView *rateView, NSInteger rating) {
        self.ratingLbl.text = [NSString stringWithFormat:@"Rating is: %zd", rating];
        NSLog(@"Rating: %zd", rating);
    };
}

#pragma mark - AGRateViewDelegate

- (void)rateView:(AGRateView *)rateView didChangedRating:(NSInteger)rating{
    self.customShapeRatingLbl.text = [NSString stringWithFormat:@"Rating is: %zd", rating];
    NSLog(@"Custom Shape Rating: %zd", rating);
}

#pragma mark - AGRateViewShapeSource

- (void)rateView:(AGRateView *)rateView drawShapeWithWidth:(CGFloat)width inFrame:(CGRect)frame borderWidth:(CGFloat)borderWidth withFillColor:(UIColor *)fillColor borderColor:(UIColor *)borderColor{
    [AGPoligoneShape drawShapeWithWidth:width inFrame:frame borderWidth:borderWidth withFillColor:fillColor borderColor:borderColor];
}

- (UIColor *)rateView:(AGRateView *)rateView fillSelectedColorForShapeAtIndex:(NSUInteger)index{
    return [UIColor redColor];
}

- (UIColor *)rateView:(AGRateView *)rateView fillNotSelectedColorForShapeAtIndex:(NSUInteger)index{
    return [UIColor yellowColor];
}

- (UIColor *)rateView:(AGRateView *)rateView borderSelectedColorForShapeAtIndex:(NSUInteger)index{
    return [UIColor greenColor];
}

- (UIColor *)rateView:(AGRateView *)rateView borderNotSelectedColorForShapeAtIndex:(NSUInteger)index{
    return [UIColor orangeColor];
}

@end
