//
//  DrawController.m
//  squares_demo_objective_c iOS
//
//  Created by Kristina Iarova on 07.11.2023.
//

#import "DrawView.h"

@implementation DrawView

- (SquaresManager *)squaresManager {
    if (!_squaresManager) {
        _squaresManager = [[SquaresManager alloc] init];
    }
    return _squaresManager;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    UIWindow *window = self.window;
    CGSize windowSize = window.frame.size;
    CGFloat windowWidth = windowSize.width;
    CGFloat windowHeight = windowSize.height;
    
    for (NSInteger index = 0; index < self.squaresManager.squares.count; index++) {
        SquareController *square = self.squaresManager.squares[index];
        [square ensureBordersWidth:windowWidth Height:windowHeight];
        CGRect squareRect = CGRectMake(square.posX, square.posY, square.size, square.size);
        UIColor *squareColor = [UIColor colorWithRed:square.colorR green:square.colorG blue:square.colorB alpha:1.0];
        CGContextSetFillColorWithColor(context, squareColor.CGColor);
        CGContextFillRect(context, squareRect);
        
        if(self.squaresManager.topSquare == square){
            CGContextSetLineWidth(context, 5.0);
            CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
            CGContextAddRect(context, squareRect);
            CGContextStrokePath(context);
        }
        
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];

    UIWindow *window = self.window;
    CGSize windowSize = window.frame.size;
    CGFloat windowWidth = windowSize.width;
    CGFloat windowHeight = windowSize.height;
    
    [self.squaresManager onPointerDownX:touchLocation.x Y:touchLocation.y WindowWidth:windowWidth WindowHeight:windowHeight];
    
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGFloat deltaX = touchLocation.x - previousLocation.x;
    CGFloat deltaY = touchLocation.y - previousLocation.y;
    
    UIWindow *window = self.window;
    CGSize windowSize = window.frame.size;
    CGFloat windowWidth = windowSize.width;
    CGFloat windowHeight = windowSize.height;
  
    [self.squaresManager onPointerMoveDeltaX:(deltaX) DeltaY:(deltaY) WindowWidth:(windowWidth) WindowHeight:(windowHeight)];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.squaresManager onPointerUp];
}

@end
