//
//  SKEmitterNode+RS.m
//
//  Created by Rex Sheng on 5/22/14.
//  Copyright (c) 2014 Rex. All rights reserved.
//

#import "SKEmitterNode+RS.h"

@implementation SKEmitterNode (RS)

+ (instancetype)emitterNamed:(NSString *)name
{
  static NSMutableDictionary *cache;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    cache = [NSMutableDictionary dictionary];
	});
	SKEmitterNode *node = cache[name];
  if (!node) {
    node = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:name ofType:@"sks"]];
    cache[name] = node;
  }
  node = [node copy];
  [node resetSimulation];
  return node;
}

@end
