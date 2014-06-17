//
//  RSGlowFilter.m
//
//  Created by Rex Sheng on 6/11/14.
//  Copyright (c) 2014 rexsheng. All rights reserved.
//

#import "RSGlowFilter.h"

@implementation RSGlowFilter

- (id)init
{
  if (self = [super init]) {
    _glowColor = [UIColor whiteColor];
  }
  return self;
}

- (NSArray *)attributeKeys
{
  return @[@"inputRadius", @"inputCenter"];
}

- (CIImage *)outputImage
{
  CIImage *inputImage = [self valueForKey:@"inputImage"];
  if (!inputImage)
    return nil;
  
  // Monochrome
  CIFilter *monochromeFilter = [CIFilter filterWithName:@"CIColorMatrix"];
  CGFloat red = 0.0;
  CGFloat green = 0.0;
  CGFloat blue = 0.0;
  CGFloat alpha = 0.0;
  [self.glowColor getRed:&red green:&green blue:&blue alpha:&alpha];
  [monochromeFilter setDefaults];
  [monochromeFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:red] forKey:@"inputRVector"];
  [monochromeFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:green] forKey:@"inputGVector"];
  [monochromeFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:blue] forKey:@"inputBVector"];
  [monochromeFilter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:alpha] forKey:@"inputAVector"];
  [monochromeFilter setValue:inputImage forKey:@"inputImage"];
  CIImage *glowImage = [monochromeFilter valueForKey:@"outputImage"];
  
  // Scale
  float centerX = [self.inputCenter X];
  float centerY = [self.inputCenter Y];
  if (centerX > 0) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, centerX, centerY);
    transform = CGAffineTransformScale(transform, 1.2, 1.2);
    transform = CGAffineTransformTranslate(transform, -centerX, -centerY);
    
    CIFilter *affineTransformFilter = [CIFilter filterWithName:@"CIAffineTransform"];
    [affineTransformFilter setDefaults];
    [affineTransformFilter setValue:[NSValue valueWithCGAffineTransform:transform] forKey:@"inputTransform"];
    [affineTransformFilter setValue:glowImage forKey:@"inputImage"];
    glowImage = [affineTransformFilter valueForKey:@"outputImage"];
  }
  
  // Blur
  CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
  [gaussianBlurFilter setDefaults];
  [gaussianBlurFilter setValue:glowImage forKey:@"inputImage"];
  [gaussianBlurFilter setValue:self.inputRadius ?: @10.0 forKey:@"inputRadius"];
  glowImage = [gaussianBlurFilter valueForKey:@"outputImage"];
  
  // Blend
  CIFilter *blendFilter = [CIFilter filterWithName:@"CISourceOverCompositing"];
  [blendFilter setDefaults];
  [blendFilter setValue:glowImage forKey:@"inputBackgroundImage"];
  [blendFilter setValue:inputImage forKey:@"inputImage"];
  glowImage = [blendFilter valueForKey:@"outputImage"];
  
  return glowImage;
}

@end
