//
//  NSDrawView.m
//  squares_macos
//
//  Created by Kristina Iarova on 08.11.2023.
//

#import "NSDrawView.h"

@implementation NSDrawView

- (SquaresManager *)squaresManager {
    if (!_squaresManager) {
        _squaresManager = [[SquaresManager alloc] init];
    }
    return _squaresManager;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    CGContextClearRect(context, dirtyRect);
    
    NSRect windowRect = self.window.frame;
    CGFloat windowWidth = windowRect.size.width;
    CGFloat windowHeight = windowRect.size.height;
    
    for (NSInteger index = 0; index < self.squaresManager.squares.count; index++) {
        SquareController *square = self.squaresManager.squares[index];
        [square ensureBordersWidth:windowWidth Height:windowHeight];
        NSRect squareRect = NSMakeRect(square.posX, square.posY, square.width, square.height);
        NSColor *squareColor = [NSColor colorWithCalibratedRed:square.colorR green:square.colorG blue:square.colorB alpha:1.0];
        [squareColor setFill];
        NSRectFill(squareRect);
        
        if (self.squaresManager.topSquare == square) {
            CGContextSetLineWidth(context, 5.0);
            CGContextSetStrokeColorWithColor(context, [NSColor whiteColor].CGColor);
            
            NSBezierPath *borderPath = [NSBezierPath bezierPathWithRect:squareRect];
            [borderPath setLineWidth:5.0];
            [[NSColor whiteColor] setStroke];
            [borderPath stroke];
        }
    }
}


- (void)mouseDown:(NSEvent *)event {
    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
    NSLog(@"Mouse down at x:%f, y:%f", location.x, location.y);
    
    NSRect windowRect = self.window.frame;
    CGFloat windowWidth = windowRect.size.width;
    CGFloat windowHeight = windowRect.size.height;
    CGFloat newSquareSize = MIN(windowWidth, windowHeight) / 10;
    
    SquareController *square = [self.squaresManager getSquareByLocationWithX:location.x Y:location.y];
    if(!square){
        square = [self.squaresManager addSquareWidth:newSquareSize Height:newSquareSize X:(location.x - newSquareSize / 2) Y:(location.y - newSquareSize / 2)];
    }
    [square ensureBordersWidth:windowWidth Height:windowHeight];
    self.lastTapped = square;
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
    NSPoint location = [self convertPoint:[event locationInWindow] fromView:nil];
    //NSPoint previousLocation = [self convertPoint:[event previousLocationInWindow] fromView:nil];
    CGFloat deltaX = [event deltaX];
    CGFloat deltaY = [event deltaY];
    NSLog(@"Mouse moved at x:%f, y:%f", location.x, location.y);
    [self.lastTapped moveByX:(deltaX) Y:(-deltaY)];
    
    NSRect windowRect = self.window.frame;
    CGFloat windowWidth = windowRect.size.width;
    CGFloat windowHeight = windowRect.size.height;
    
    [self.lastTapped ensureBordersWidth:windowWidth Height:windowHeight];
    [self setNeedsDisplay:YES];
    
}

- (void)mouseUp:(NSEvent *)event {
    NSLog(@"Mouse up");
    self.lastTapped = nil;
}

@end
