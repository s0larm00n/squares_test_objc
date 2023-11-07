//
//  SquareController.m
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#import "SquareController.h"

@implementation SquareController

- (instancetype)initWithDimensionsWidth:(CGFloat)width Height:(CGFloat)height PosX:(CGFloat)posX PosY:(CGFloat)posY {
    self = [super init];
    if (self) {
        self.width = width;
        self.height = height;
        self.posX = posX;
        self.posY = posY;
        
        self.colorR =(CGFloat)arc4random_uniform(256) / 255.0;
        self.colorG =(CGFloat)arc4random_uniform(256) / 255.0;
        self.colorB =(CGFloat)arc4random_uniform(256) / 255.0;
    }
    return self;
}

- (BOOL)containsPointX:(CGFloat)x Y:(CGFloat)y {
    return (x >= self.posX && x <= self.posX + self.width &&
            y >= self.posY && y <= self.posY + self.height);
}

-(void)moveByX: (CGFloat)x Y:(CGFloat)y {
    self.posX = self.posX + x;
    self.posY = self.posY + y;
}

// Assuming window corner is (0,0)
-(void)ensureBordersWidth: (CGFloat)width Height:(CGFloat)height {
    if(self.posX < 0){
        self.posX = 0;
    }
    if(self.posX + self.width > width){
        self.posX = width - self.width;
    }
    if(self.posY < 0){
        self.posY = 0;
    }
    if(self.posY + self.height > height){
        self.posY = height - self.height;
    }
}

@end
