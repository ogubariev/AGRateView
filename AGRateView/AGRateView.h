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

/*
 * AGRateView.h
 *
 * Created by Alexey Gubarev on 11/18/15.
 * <gubarev.lesha@gmail.com>
 * Copyright (c) 2015, Alexey Gubarev. All rights reserved.
 *
 * v0.1
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AGRateView;

typedef void(^AGRateViewRateDidChangedBlock)(AGRateView *rateView, NSInteger rating);

@protocol AGRateViewDelegate <NSObject>

@optional
- (void)rateView:(AGRateView *)rateView didChangedRating:(NSInteger)rating;

@end

IB_DESIGNABLE
@interface AGRateView : UIView

@property (nonatomic, assign) IBInspectable NSInteger rating;

@property (nonatomic, assign) IBInspectable NSInteger countOfStars;

@property (nonatomic, assign) IBInspectable CGFloat starsBorderWidth;

@property (nonatomic, strong) IBInspectable UIColor *starsBorderColor;

@property (nonatomic, strong) IBInspectable UIColor *starsStartColor;

@property (nonatomic, strong) IBInspectable UIColor *starsFinishColor;


@property (nonatomic, weak) IBOutlet id <AGRateViewDelegate> delegate;
@property (nonatomic, copy) AGRateViewRateDidChangedBlock ratingDidChangedBlock;

@end
