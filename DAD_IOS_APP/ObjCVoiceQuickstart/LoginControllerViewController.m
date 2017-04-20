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
@synthesize userArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // _loadingAnimationView = [LoadingAnimationView new];
    userArray = [[NSMutableArray alloc] initWithCapacity:5];
    UIColor *color =  [UIColor colorWithRed:2.0f/255.0f
                                      green:168.0f/255.0f
                                       blue:218.0f/255.0f
                                      alpha:0.9f];
    self.navigationController.navigationBar.barTintColor = color;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self initUserArray];
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

-(void) initUserArray{
    User *user1 = [[User alloc] init];
    user1.userName = @"aliceuser";
    user1.password = @"123456";
    user1.firstName = @"Alice";
    user1.lastName =@"Bag";
    user1.age = [NSNumber numberWithInt:60];
    user1.location = @"Somervile";
    [userArray addObject:user1];
    
    User *user2 = [[User alloc] init];
    user2.userName = @"bobuser";
    user2.password = @"123456";
    user2.firstName = @"Bob";
    user2.lastName =@"Bag";
    user2.age = [NSNumber numberWithInt:60];
    user2.location = @"Boston";
    [userArray addObject:user2];
    
    User *user3 = [[User alloc] init];
    user3.userName = @"clarauser";
    user3.password = @"123456";
    user3.firstName = @"Clara";
    user3.lastName =@"Bag";
    user3.age = [NSNumber numberWithInt:60];
    user3.location = @"Medford";
    [userArray addObject:user3];

    
}

-(void) onValidationSuccessful{
    
    NSLog(@"%@",_twilioIdTextField.text);
    NSLog(@"%@",_authorizationNameTextfield.text);
    bool flag = NO;
    User * user = User.getUser;
    for(User *u in userArray)
    {
        if([_twilioIdTextField.text isEqualToString:u.userName] && [_authorizationNameTextfield.text isEqualToString:u.password] ){
            flag=YES;
            user.userName = u.userName;
            user.password = u.password;
            user.firstName = u.firstName;
            user.lastName = u.lastName;
            user.location = u.location;
            user.age = u.age;
            break;
        }
    }
    
    if(flag)
    {
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
