//
//  RSTileNode.m
//
//  Created by Rex Sheng on 6/11/14.
//  Copyright (c) 2014 rexsheng. All rights reserved.
//

#import "RSTileNode.h"
@interface RSTileNode ()
@property (nonatomic, strong) id<RSTileNode> tile;
@end

@implementation RSTileNode

- (id)initWithTile:(id<RSTileNode>)tile
{
  if (self = [super init]) {
    _tile = tile;
    if ([tile respondsToSelector:@selector(texture)]) {
      SKTexture *texture = tile.texture;
      CGSize size = tile.tileSize;
      CGPoint anchorPoint = self.anchorPoint;
      CGFloat offsetX = texture.size.width * anchorPoint.x;
      CGFloat offsetY = texture.size.height * anchorPoint.y;
      for (int i = 0; i < size.width; i++) {
        for (int j = 0; j < size.height; j++) {
          SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture size:texture.size];
          sprite.position = CGPointMake(i * texture.size.width + offsetX, j * texture.size.height + offsetY);
          [self addChild:sprite];
        }
      }
    }
    else if ([tile respondsToSelector:@selector(nextNode)]) {
      CGSize size = tile.tileSize;
      CGPoint anchorPoint = self.anchorPoint;
      for (int i = 0; i < size.width; i++) {
        for (int j = 0; j < size.height; j++) {
          SKNode *node = [tile nextNode];
          CGFloat offsetX = node.frame.size.width * anchorPoint.x;
          CGFloat offsetY = node.frame.size.height * anchorPoint.y;
          node.position = CGPointMake(i * node.frame.size.width + offsetX, j * node.frame.size.height + offsetY);
          [self addChild:node];
        }
      }
    }
  }
  return self;
}

- (void)removeFromParent
{
  [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeAllActions];
    [obj removeFromParent];
  }];
  [super removeFromParent];
}

- (CGPoint)anchorPoint
{
  if ([_tile respondsToSelector:@selector(anchorPoint)]) {
    return [_tile anchorPoint];
  }
  return CGPointZero;
}

- (void)checkForReuse:(SKNode *)node
{
  CGFloat maxX = CGRectGetMaxX(node.frame);
  if (maxX < 0) {
    CGPoint p = node.position;
    p.x += self.tile.tileSize.width * node.frame.size.width;
    node.position = p;
    if ([self.tile respondsToSelector:@selector(prepareForReuse:)]) {
      [self.tile prepareForReuse:node];
    }
  }
}

- (void)fixPositions
{
  NSMutableDictionary *traits = [NSMutableDictionary dictionaryWithCapacity:self.children.count];
  [self.children enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
    id key = @(node.position.x);
    NSMutableArray *nodes = traits[key];
    if (!nodes) {
      nodes = [NSMutableArray arrayWithCapacity:[self.tile tileSize].height];
      traits[key] = nodes;
    }
    [nodes addObject:node];
  }];
  
  NSArray *keys = [traits.allKeys sortedArrayUsingSelector:@selector(compare:)];
  __block CGFloat x = [keys.firstObject floatValue];
  [keys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    NSArray *nodes = traits[obj];
    [nodes enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
      CGPoint p = node.position;
      if (fabsf(p.x - x) > .25) {
        p.x = x;
        node.position = p;
      }
    }];
    x += [nodes.firstObject frame].size.width;
  }];
}

- (void)moveBackwardBy:(CGFloat)moveBy duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion
{
  SKAction *move = [SKAction moveByX:-moveBy y:0 duration:duration];
  [self.children enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
    [node removeAllActions];
    [self checkForReuse:node];
    [node runAction:move completion:^{
      if (idx == 0) {
        if (completion) completion();
      }
    }];
  }];
}

@end
