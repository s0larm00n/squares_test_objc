//
//  SquareController.h
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#ifndef SquareController_h
#define SquareController_h

#import <Foundation/Foundation.h>

@interface SquareController : NSObject

@property (nonatomic, assign) CGFloat size;
@property (nonatomic, assign) CGFloat posX;
@property (nonatomic, assign) CGFloat posY;

@property (nonatomic, assign) CGFloat colorR;
@property (nonatomic, assign) CGFloat colorG;
@property (nonatomic, assign) CGFloat colorB;

- (instancetype)initWithDimensionsSize:(CGFloat)size PosX:(CGFloat)posX PosY:(CGFloat)posY;
- (BOOL)containsPointX:(CGFloat)x Y:(CGFloat)y;
-(void)moveByX: (CGFloat)x Y:(CGFloat)y;
-(void)ensureBordersWidth: (CGFloat)width Height:(CGFloat)height;

@end

#endif /* SquareController_h */
