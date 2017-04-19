//
//  MainViewController.h
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingAnimationView.h"

@interface MainViewController : UIViewController

@property  LoadingAnimationView *loadingAnimationView;
@property (weak, nonatomic) IBOutlet UITableView *mealTableVIew;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIView *orderedMealView;
- (IBAction)callButton:(id)sender;
- (IBAction)deleteMeal:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *mealNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *orderMealViewHeight;
@end
