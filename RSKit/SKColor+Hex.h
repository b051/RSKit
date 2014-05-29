//
//  UIColor+Hex.h
//
//  Created by Rex Sheng on 4/1/13.
//  Copyright (c) 2013 Rex Sheng

#import <SpriteKit/SpriteKit.h>

@interface SKColor (Hex)

+ (SKColor *)colorWithHexRGB:(NSUInteger)hex;
+ (SKColor *)colorWithHexWhite:(NSUInteger)hex;

+ (SKColor *)colorWithHexRGB:(NSUInteger)hex alpha:(CGFloat)alpha;
+ (SKColor *)colorWithHexWhite:(NSUInteger)hex alpha:(CGFloat)alpha;

- (NSString *)hexString;

@end
