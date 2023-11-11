//
//  SquaresManager.m
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#ifndef SquaresManager_h
#define SquaresManager_h

#import "SquareController.h"

@interface SquaresManager : NSObject
@property (nonatomic, strong) NSMutableArray<SquareController *> *squares;
@property (nonatomic, strong) SquareController *topSquare;

- (instancetype)init;
- (SquareController *)getSquareByLocationWithX:(CGFloat)x Y:(CGFloat)y;
- (SquareController *)addSquareWithSize:(CGFloat)size X:(CGFloat)x Y:(CGFloat)y;
- (void) onPointerDownX:(CGFloat)x Y:(CGFloat)y WindowWidth:(CGFloat)windowWidth WindowHeight:(CGFloat)windowHeight;
- (void) onPointerMoveDeltaX:(CGFloat)deltaX DeltaY:(CGFloat)deltaY WindowWidth:(CGFloat)windowWidth WindowHeight:(CGFloat)windowHeight;
- (void) onPointerUp;

@end

#endif /* SquaresManager_h */
