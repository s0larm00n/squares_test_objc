//
//  NSDrawView.h
//  squares_macos
//
//  Created by Kristina Iarova on 08.11.2023.
//

#ifndef NSDrawView_h
#define NSDrawView_h

#import <Cocoa/Cocoa.h>
#import "SquaresManager.h"
#import "SquareController.h"

@interface NSDrawView : NSView

@property (nonatomic, strong) SquaresManager *squaresManager;

@end

#endif /* NSDrawView_h */
