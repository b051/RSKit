//
//  UIImage+RS.h
//
//  Created by Rex Sheng on 8/12/13.
//  Copyright (c) 2013 Rex Sheng
//


@interface UIImage (Color)

+ (UIImage *)imageFromColor:(UIColor *)color;

+ (UIImage *)imageFromSize:(CGSize)size block:(void(^)(CGContextRef context))block;

@end