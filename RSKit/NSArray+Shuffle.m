//
//  NSArray+Shuffle.m
//
//  Created by Rex Sheng on 4/1/13.
//  Copyright (c) 2013 Rex Sheng

#import "NSArray+Shuffle.h"

@implementation NSArray (Shuffle)

- (NSMutableArray *)shuffle
{
  NSMutableArray *array = [self mutableCopy];
  u_int32_t count = (u_int32_t)[array count];
  for (u_int32_t i = 0; i < count - 1; i++) {
    // Select a random element between i and end of array to swap with.
    u_int32_t nElements = count - i;
    NSInteger n = arc4random_uniform(nElements) + i;
    [array exchangeObjectAtIndex:i withObjectAtIndex:n];
  }
  return array;
}

@end