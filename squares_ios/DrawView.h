//
//  DrawController.h
//  squares_demo_objective_c
//
//  Created by Kristina Iarova on 07.11.2023.
//

#ifndef DrawController_h
#define DrawController_h

#import <UIKit/UIKit.h>
#import "SquaresManager.h"
#import "SquareController.h"

@interface DrawView : UIView

@property(nonatomic, strong) SquaresManager *squaresManager;

@end

#endif /* DrawView_h */
