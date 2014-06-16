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

- (void)moveBackwardBy:(CGFloat)moveBy duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion
{
  SKAction *move = [SKAction moveByX:-moveBy y:0 duration:duration];
  __block CGFloat mostRight = 0;
  CGPoint anchorPoint = self.anchorPoint;
  __weak __typeof(self)weakSelf = self;
  [self.children enumerateObjectsUsingBlock:^(SKNode *node, NSUInteger idx, BOOL *stop) {
    [node removeAllActions];
    CGFloat maxX = CGRectGetMaxX(node.frame);
    if (node.position.y == 0) {
      mostRight = MAX(maxX, mostRight);
    }
    [node runAction:move completion:^{
      __strong __typeof(weakSelf)strongSelf = weakSelf;
      if (!strongSelf) return;

      if (maxX < moveBy) {
        CGPoint p = node.position;
        CGFloat offsetX = node.frame.size.width * anchorPoint.x;
        p.x = mostRight - moveBy + offsetX;
        if ([strongSelf.tile respondsToSelector:@selector(prepareForReuse:)]) {
          [strongSelf.tile prepareForReuse:node];
        }
        node.position = p;
      }
      if (idx == 0) {
        if (completion) completion();
      }
    }];
  }];
}

- (void)removeAllActions
{
  [self.children enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [obj removeAllActions];
  }];
  [super removeAllActions];
}

@end
