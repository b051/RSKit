//
//  SKNode+ChildrenClean.m
//  Pods
//
//  Created by jason.huang on 7/15/14.
//
//

#import "SKNode+ChildrenClean.h"

@implementation SKNode (ChildrenClean)

- (void)cleanUpChildrenAndRemove
{
  for (SKNode *child in self.children) {
    [child cleanUpChildrenAndRemove];
  }
  [self removeAllActions];
  [self removeFromParent];
}

@end
