//
//  LoginControllerViewController.m
//  Mealpass
//
//  Created by Sabrish Ramamoorthy on 12/12/16.
//  Copyright © 2016 Sabrish Ramamoorthy. All rights reserved.
//

#import "LoginControllerViewController.h"
#import "User.h"

@interface LoginControllerViewController ()

@end

@implementation LoginControllerViewController
NSString *const TWILIO_API_ID = @"a";
NSString *const TWILIO_API_TOKEN = @"b";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // _loadingAnimationView = [LoadingAnimationView new];
    UIColor *color =  [UIColor colorWithRed:2.0f/255.0f
                                      green:168.0f/255.0f
                                       blue:218.0f/255.0f
                                      alpha:0.9f];
    self.navigationController.navigationBar.barTintColor = color;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) textFieldShouldReturn: (UITextField *) textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)signIn:(id)sender {
    [self onValidationSuccessful];
   
}

-(void) onValidationSuccessful{
    
    NSLog(@"%@",_twilioIdTextField.text);
    NSLog(@"%@",_authorizationNameTextfield.text);

    if([_twilioIdTextField.text isEqualToString:TWILIO_API_ID] && [_authorizationNameTextfield.text isEqualToString:TWILIO_API_TOKEN] )
    {
        User * user= User.getUser;
        user.userId=_twilioIdTextField.text;
        user.token=_authorizationNameTextfield.text;
        user.domain=_domainTextfield.text;
                [self performSegueWithIdentifier:@"home" sender:self];
    }else{
        [_loadingAnimationView hide];
        [self showError:@"Error while Login ! Please try again"];

    }
    [_loadingAnimationView showWithMessage:@"Loading" inView:self.view];

}

-(void) showError :(NSString *) errorMessage{
    
    if(!errorMessage){
        errorMessage = @"Error while Login ! Please try again";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:errorMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
@end
