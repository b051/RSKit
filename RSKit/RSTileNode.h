//
//  RSTileNode.h
//
//  Created by Rex Sheng on 6/11/14.
//  Copyright (c) 2014 rexsheng. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol RSTileNode <NSObject>
@optional
- (SKNode *)nextNode;
- (CGPoint)anchorPoint;
- (void)prepareForReuse:(SKNode *)node;
- (CGPoint)positionOfNodeAtIndex:(CGSize)index;
@property (nonatomic, strong) SKTexture *texture;
@property (nonatomic) CGSize tileSize;
@end

@interface RSTileNode : SKNode
- (void)fixPositions;
- (instancetype)initWithTile:(id<RSTileNode>)tile;
- (void)moveBackwardBy:(CGFloat)moveBy duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion;
@end
