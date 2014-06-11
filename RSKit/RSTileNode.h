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
@property (nonatomic, strong) SKTexture *texture;
@property (nonatomic) CGSize tileSize;
@end

@interface RSTileNode : SKNode
- (instancetype)initWithTile:(id<RSTileNode>)tile;
- (void)moveBackwardBy:(CGFloat)moveBy duration:(NSTimeInterval)duration completion:(dispatch_block_t)completion;
@end
