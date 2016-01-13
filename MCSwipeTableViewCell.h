//
//  MCSwipeTableViewCell.h
//  MCSwipeTableViewCell
//
//  Created by Ali Karagoz on 24/02/13.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MCSwipeTableViewCell;

/** Describes the state that has been triggered by the user. */
typedef NS_OPTIONS(NSUInteger, MCSwipeTableViewCellState) {

    /** No state has been triggered. */
    MCSwipeTableViewCellStateNone = 0,
    
    /** 1st state triggered during a Left -> Right swipe. */
    MCSwipeTableViewCellState1 = (1 << 0),
    
    /** 2nd state triggered during a Left -> Right swipe. */
    MCSwipeTableViewCellState2 = (1 << 1),

    /** 1st state triggered during a Right -> Left swipe. */
    MCSwipeTableViewCellState3 = (1 << 2),
    
    /** 2nd state triggered during a Right -> Left swipe. */
    MCSwipeTableViewCellState4 = (1 << 3),
    
    /** 3nd state triggered during a Right -> Right swipe. */
    MCSwipeTableViewCellState5 = (1 << 4)
};

/** Describes the mode used during a swipe */
typedef NS_ENUM(NSUInteger, MCSwipeTableViewCellMode) {
    /** Disabled swipe.  */
    MCSwipeTableViewCellModeNone = 0,

    /** Upon swipe the cell if exited from the view. Useful for destructive actions. */
    MCSwipeTableViewCellModeExit,

    /** Upon swipe the cell if automatically swiped back to it's initial position. */
    MCSwipeTableViewCellModeSwitch
};

/**
 *  `MCSwipeCompletionBlock`
 *
 *  @param cell  Currently swiped `MCSwipeTableViewCell`.
 *  @param state `MCSwipeTableViewCellState` which has been triggered.
 *  @param mode  `MCSwipeTableViewCellMode` used for for swiping.
 *
 *  @return No return value.
 */
typedef void (^MCSwipeCompletionBlock)(MCSwipeTableViewCell *cell, MCSwipeTableViewCellState state, MCSwipeTableViewCellMode mode);

@protocol MCSwipeTableViewCellDelegate;

@interface MCSwipeTableViewCell : UITableViewCell

/** Delegate of `MCSwipeTableViewCell` */
@property (nonatomic, assign) id <MCSwipeTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageFlag;
@property (strong, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *number;
@property (weak, nonatomic) IBOutlet UILabel *booking;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UIButton *opened;
@property (weak, nonatomic) IBOutlet UILabel *yearopened;
@property (weak, nonatomic) IBOutlet UILabel *manufacturer;
@property (weak, nonatomic) IBOutlet UILabel *tunneltype;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberstyle;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberdiameter;
@property (weak, nonatomic) IBOutlet UILabel *flightchamberheight;
@property (weak, nonatomic) IBOutlet UILabel *topwindspeed;
@property (weak, nonatomic) IBOutlet UILabel *offpeakpricing;
@property (weak, nonatomic) IBOutlet UILabel *onpeakpricing;
@property (weak, nonatomic) IBOutlet UILabel *hours;
@property (weak, nonatomic) IBOutlet UILabel *websiteurl;
@property (weak, nonatomic) IBOutlet UILabel *imagetunnel;
@property (weak, nonatomic) IBOutlet UILabel *flag;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

/** 
 * Damping of the physical spring animation. Expressed in percent.
 * 
 * @discussion Only applied for version of iOS > 7.
 */
@property (nonatomic, assign, readwrite) CGFloat damping;

/**
 * Velocity of the spring animation. Expressed in points per second (pts/s).
 *
 * @discussion Only applied for version of iOS > 7.
 */
@property (nonatomic, assign, readwrite) CGFloat velocity;

/** Duration of the animations. */
@property (nonatomic, assign, readwrite) NSTimeInterval animationDuration;


/** Color for background, when no state has been triggered. */
@property (nonatomic, strong, readwrite) UIColor *defaultColor;


/** 1st color of the state triggered during a Left -> Right swipe. */
@property (nonatomic, strong, readwrite) UIColor *color1;

/** 2nd color of the state triggered during a Left -> Right swipe. */
@property (nonatomic, strong, readwrite) UIColor *color2;

/** 1st color of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIColor *color3;

/** 2nd color of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIColor *color4;

/** 2nd color of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIColor *color5;


/** 1st view of the state triggered during a Left -> Right swipe. */
@property (nonatomic, strong, readwrite) UIView *view1;

/** 2nd view of the state triggered during a Left -> Right swipe. */
@property (nonatomic, strong, readwrite) UIView *view2;

/** 1st view of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIView *view3;

/** 2nd view of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIView *view4;

/** 2nd view of the state triggered during a Right -> Left swipe. */
@property (nonatomic, strong, readwrite) UIView *view5;


/** 1st Block of the state triggered during a Left -> Right swipe. */
@property (nonatomic, copy, readwrite) MCSwipeCompletionBlock completionBlock1;

/** 2nd Block of the state triggered during a Left -> Right swipe. */
@property (nonatomic, copy, readwrite) MCSwipeCompletionBlock completionBlock2;

/** 1st Block of the state triggered during a Right -> Left swipe. */
@property (nonatomic, copy, readwrite) MCSwipeCompletionBlock completionBlock3;

/** 2nd Block of the state triggered during a Right -> Left swipe. */
@property (nonatomic, copy, readwrite) MCSwipeCompletionBlock completionBlock4;

/** 2nd Block of the state triggered during a Right -> Left swipe. */
@property (nonatomic, copy, readwrite) MCSwipeCompletionBlock completionBlock5;


// Percentage of when the first and second action are activated, respectively

/** Percentage value to trigger the 1st state of a swipe gesture. */
@property (nonatomic, assign, readwrite) CGFloat firstTrigger;

/** Percentage value to trigger the 2nd state of a swipe gesture. */
@property (nonatomic, assign, readwrite) CGFloat secondTrigger;


/** 1st `MCSwipeTableViewCellMode` of the state triggered during a Left -> Right swipe. */
@property (nonatomic, assign, readwrite) MCSwipeTableViewCellMode modeForState1;

/** 2nd `MCSwipeTableViewCellMode` of the state triggered during a Left -> Right swipe. */
@property (nonatomic, assign, readwrite) MCSwipeTableViewCellMode modeForState2;

/** 1st `MCSwipeTableViewCellMode` of the state triggered during a Right -> Left swipe. */
@property (nonatomic, assign, readwrite) MCSwipeTableViewCellMode modeForState3;

/** 2nd `MCSwipeTableViewCellMode` of the state triggered during a Right -> Left swipe. */
@property (nonatomic, assign, readwrite) MCSwipeTableViewCellMode modeForState4;

/** 3nd `MCSwipeTableViewCellMode` of the state triggered during a Right -> Left swipe. */
@property (nonatomic, assign, readwrite) MCSwipeTableViewCellMode modeForState5;


/** Boolean indicator to know if the cell is currently dragged. */
@property (nonatomic, assign, readonly, getter=isDragging) BOOL dragging;

/** Boolean to enable/disable the dragging ability of a cell. */
@property (nonatomic, assign, readwrite) BOOL shouldDrag;

/** Boolean to enable/disable the animation of the view during the swipe.  */
@property (nonatomic, assign, readwrite) BOOL shouldAnimateIcons;

@property (strong,nonatomic) IBOutlet UIButton *monButtonKM;

/**
 *  Configures the properties of a cell.
 *
 *  @param view            view of the state triggered during a swipe.
 *  @param color           Color of the state triggered during a swipe.
 *  @param mode            `MCSwipeTableViewCellMode` used by the cell during a swipe.
 *  @param state           `MCSwipeTableViewCellState` on which the properties are applied.
 *  @param completionBlock Block of the state triggered during a swipe.
 */
- (void)setSwipeGestureWithView:(UIView *)view
                          color:(UIColor *)color
                           mode:(MCSwipeTableViewCellMode)mode
                          state:(MCSwipeTableViewCellState)state
                completionBlock:(MCSwipeCompletionBlock)completionBlock;


/**
 *  Swiped back the cell to it's original position
 *
 *  @param completion Callback block executed at the end of the animation.
 */
- (void)swipeToOriginWithCompletion:(void(^)(void))completion;

@end


@protocol MCSwipeTableViewCellDelegate <NSObject>

@optional

/**
 *  Called when the user starts swiping the cell.
 *
 *  @param cell `MCSwipeTableViewCell` currently swiped.
 */
- (void)swipeTableViewCellDidStartSwiping:(MCSwipeTableViewCell *)cell;

/**
 *  Called when the user ends swiping the cell.
 *
 *  @param cell `MCSwipeTableViewCell` currently swiped.
 */
- (void)swipeTableViewCellDidEndSwiping:(MCSwipeTableViewCell *)cell;

/**
 *  Called during a swipe.
 *
 *  @param cell         Cell that is currently swiped.
 *  @param percentage   Current percentage of the swipe movement. Percentage is calculated from the
 *                      left of the table view.
 */
- (void)swipeTableViewCell:(MCSwipeTableViewCell *)cell didSwipeWithPercentage:(CGFloat)percentage;

@end
