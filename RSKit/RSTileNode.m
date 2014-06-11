//
//  RSTileNode.m
//
//  Created by Rex Sheng on 6/11/14.
//  Copyright (c) 2014 rexsheng. All rights reserved.
//

#import "RSTileNode.h"

@implementation RSTileNode

- (id)initWithTile:(id<RSTileNode>)tile
{
  if (self = [super init]) {
    if ([tile respondsToSelector:@selector(texture)]) {
      SKTexture *texture = tile.texture;
      CGSize size = tile.tileSize;
      for (int i = 0; i < size.width; i++) {
        for (int j = 0; j < size.height; j++) {
          SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:texture size:texture.size];
          sprite.anchorPoint = CGPointZero;
          sprite.position = CGPointMake(i * texture.size.width, j * texture.size.height);
          [self addChild:sprite];
        }
      }
    }
  }
  return self;
}

- (void)moveBackwardBy:(CGFloat)moveBy duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion
{
  SKAction *move = [SKAction moveByX:-moveBy y:0 duration:duration];
  __block CGFloat mostRight = 0;
  [self.children enumerateObjectsUsingBlock:^(SKSpriteNode *stars, NSUInteger idx, BOOL *stop) {
    [stars removeAllActions];
    CGFloat maxX = stars.position.x + stars.size.width;
    if (stars.position.y == 0) {
      mostRight = MAX(maxX, mostRight);
    }
    [stars runAction:move completion:^{
      if (maxX < moveBy) {
        CGPoint p = stars.position;
        p.x = mostRight - moveBy;
        stars.position = p;
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
