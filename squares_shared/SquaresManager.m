//
//  SquaresManager.h
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#import "SquaresManager.h"

@interface SquaresManager ()
@property (nonatomic, strong) SquareController *focused;

- (SquareController *)detectCollisionWithX:(CGFloat)x Y:(CGFloat)y;

@end

@implementation SquaresManager

- (SquareController *)topSquare {
    if (self.squares == nil) {
        return nil;
    }
    return [self.squares lastObject];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.squares = [NSMutableArray array];
    }
    return self;
}

- (SquareController *)detectCollisionWithX:(CGFloat)x Y:(CGFloat)y {
    for (NSInteger i = self.squares.count - 1; i >= 0; i--) {
        SquareController *square = self.squares[i];
        if ([square containsPointX:x Y:y]) {
            return square;
        }
    }
    return nil;
}

- (SquareController *)getSquareByLocationWithX:(CGFloat)x Y:(CGFloat)y {
    SquareController *collisionSquare = [self detectCollisionWithX:x Y:y];

    if (collisionSquare != nil) {
        // Move the detected square to the end of the list
        [self.squares removeObject:collisionSquare];
        [self.squares addObject:collisionSquare];
    }

    return collisionSquare;
}

- (SquareController *)addSquareWithSize:(CGFloat)size X:(CGFloat)x Y:(CGFloat)y {
    SquareController *newSquare = [[SquareController alloc] initWithDimensionsSize:size PosX:x PosY:y];
    [self.squares addObject:newSquare];
    return newSquare;
}

- (void) onPointerDownX:(CGFloat)x Y:(CGFloat)y WindowWidth:(CGFloat)windowWidth WindowHeight:(CGFloat)windowHeight {
        CGFloat newSquareSize = MIN(windowWidth, windowHeight) / 10;
        SquareController *square = [self getSquareByLocationWithX:x Y:y];
        if(!square){
            square = [self addSquareWithSize:newSquareSize X:(x - newSquareSize / 2) Y:(y - newSquareSize / 2)];
        }
        [square ensureBordersWidth:windowWidth Height:windowHeight];
        self.focused = square;
}

- (void) onPointerMoveDeltaX:(CGFloat)deltaX DeltaY:(CGFloat)deltaY WindowWidth:(CGFloat)windowWidth WindowHeight:(CGFloat)windowHeight{
    [self.focused moveByX:(deltaX) Y:(deltaY)];
    [self.focused ensureBordersWidth:windowWidth Height:windowHeight];
}

- (void) onPointerUp {
    self.focused = nil;
}

@end
