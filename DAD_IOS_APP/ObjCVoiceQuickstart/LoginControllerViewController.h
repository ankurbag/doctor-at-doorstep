//
//  LoginControllerViewController.h
//  Mealpass
//
//  Created by Sabrish Ramamoorthy on 12/12/16.
//  Copyright © 2016 Sabrish Ramamoorthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingAnimationView.h"

@interface LoginControllerViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *twilioIdTextField;
@property (weak, nonatomic) IBOutlet UITextField *authorizationNameTextfield;
@property (weak, nonatomic) IBOutlet UITextField *domainTextfield;

@property  LoadingAnimationView *loadingAnimationView;
- (IBAction)signIn:(id)sender;

@end
