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
        CGRect squareRect = CGRectMake(square.posX, square.posY, square.width, square.height);
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
    NSLog(@"Touch began at x:%f, y:%f", touchLocation.x, touchLocation.y);
    
    UIWindow *window = self.window;
    CGSize windowSize = window.frame.size;
    CGFloat windowWidth = windowSize.width;
    CGFloat windowHeight = windowSize.height;
    CGFloat newSquareSize = MIN(windowWidth, windowHeight) / 10;
    
    SquareController *square = [self.squaresManager getSquareByLocationWithX:touchLocation.x Y:touchLocation.y];
    if(!square){
        square = [self.squaresManager addSquareWidth:newSquareSize Height:newSquareSize X:(touchLocation.x - newSquareSize / 2) Y:(touchLocation.y - newSquareSize / 2)];
    }
    [square ensureBordersWidth:windowWidth Height:windowHeight];
    self.lastTapped = square;
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self];
    CGPoint previousLocation = [touch previousLocationInView:self];
    NSLog(@"Touch moved at x:%f, y:%f", touchLocation.x, touchLocation.y);
    [self.lastTapped moveByX:(touchLocation.x - previousLocation.x) Y:(touchLocation.y - previousLocation.y)];
    
    UIWindow *window = self.window;
    CGSize windowSize = window.frame.size;
    CGFloat windowWidth = windowSize.width;
    CGFloat windowHeight = windowSize.height;
    [self.lastTapped ensureBordersWidth:windowWidth Height:windowHeight];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch Ended");
    self.lastTapped = nil;
}

@end
