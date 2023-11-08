//
//  SquaresManager.h
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#import "SquaresManager.h"

@interface SquaresManager ()

- (SquareController *)detectCollisionWithX:(CGFloat)x Y:(CGFloat)y;

@end

@implementation SquaresManager

- (SquareController *)topSquare {
    if(self.squares == nil) {
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

@end
