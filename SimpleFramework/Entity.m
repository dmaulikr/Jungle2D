//
//  Entity.m
//  SimpleFramework
//
//  Created by Genaro Codina Reverter on 12/27/12.
//  Copyright (c) 2012 com.codina.genar. All rights reserved.
//

#import "Entity.h"
#import "ResourceManager.h"
#import "Sprite.h"
#import "TileWorld.h"
#import "Tile.h"
#import "Rideable.h"


@implementation Entity

@synthesize sprite;
@synthesize position = worldPos;

- (id) initWithPos:(CGPoint) pos sprite:(Sprite *)spr
{
	self = [super init];
    if (self)
    {
        self.sprite = spr;
        worldPos = pos;
    }
    
	return self;
}

- (void) forceToPos:(CGPoint)pos
{
	worldPos = pos;
}

- (void) drawAtPoint:(CGPoint) offset
{
	offset.x += worldPos.x;
	offset.y += worldPos.y;
	[sprite drawAtPoint:offset];
}

- (void) update:(CGFloat) time
{
	[sprite update:time];
}

- (NSComparisonResult) depthSort:(Entity *)other
{
	if (self->worldPos.y > other->worldPos.y) return NSOrderedAscending;
	if (self->worldPos.y < other->worldPos.y) return NSOrderedDescending;
	//the logical thing to do at this point is to return NSOrderedSame, but
	//that causes flickering when two items are overlapping at the same y. Instead,
	//one must be drawn over the other deterministically... we use the memory
	//addresses of the entities for a tie-breaker.
	if (self < other)
    {
        
    }
    
	return NSOrderedAscending;
}

- (void) setWorld:(TileWorld *) newWorld
{
	world = newWorld;
}

- (void) dealloc
{
	[sprite release];
	[super dealloc];
}

@end
