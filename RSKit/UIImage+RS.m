//
//  UIImage+RS.m
//
//  Created by Rex Sheng on 8/12/13.
//  Copyright (c) 2013 Rex Sheng
//


@implementation UIImage (Color)

+ (UIImage *)imageFromColor:(UIColor *)color
{
	return [self imageFromSize:CGSizeMake(1, 1) block:^(CGContextRef context) {
		CGRect rect = CGRectMake(0, 0, 1, 1);
		CGContextSetFillColorWithColor(context, [color CGColor]);
		CGContextFillRect(context, rect);
	}];
}

+ (UIImage *)imageFromSize:(CGSize)size block:(void(^)(CGContextRef context))block
{
	UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
	CGContextRef context = UIGraphicsGetCurrentContext();
	block(context);
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return img;
}

@end