//
//  RSGlowFilter.h
//
//  Created by Rex Sheng on 6/11/14.
//  Copyright (c) 2014 rexsheng. All rights reserved.
//

#import <CoreImage/CoreImage.h>

@interface RSGlowFilter : CIFilter
@property (nonatomic, strong) UIColor *glowColor;
@property (nonatomic, strong) CIImage *inputImage;
@property (nonatomic, strong) NSNumber *inputRadius;
@property (nonatomic, strong) CIVector *inputCenter;
@end
