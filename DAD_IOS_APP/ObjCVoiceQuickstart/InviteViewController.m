//
//  PhotoViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "InviteViewController.h"
#import "SWRevealViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <ApiAI/ApiAI.h>
#import "User.h"
@interface InviteViewController ()

@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color =  [UIColor colorWithRed:2.0f/255.0f
                                      green:168.0f/255.0f
                                       blue:218.0f/255.0f
                                      alpha:0.9f];
    self.navigationController.navigationBar.barTintColor = color;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
   

    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    _chatArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) askBotRequest : (NSString*) chatMessage{
    
    if(chatMessage){
       
        //initiate APIAI
        ApiAI *apiai = [ApiAI sharedApiAI];
        
        AITextRequest *request = [apiai textRequest];
        request.query = chatMessage;
        
        __weak typeof(self) selfWeak = self;
        
        [request setMappedCompletionBlockSuccess:^(AIRequest *request, AIResponse *response) {
            __strong typeof(selfWeak) selfStrong = selfWeak;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:response.status.errorType
                                                                message:response.result.fulfillment.speech
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            //[alertView show];
            UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 30*[_chatArray count], 300, 25)];//Set frame of label in your viewcontroller.
            [label setFont:[UIFont systemFontOfSize:13]];
            //    [label setBackgroundColor:[UIColor darkGrayColor]];//Set background color of label.
            [label setText:[[NSString stringWithFormat:@"SIPsterBOT :"] stringByAppendingString: response.result.fulfillment.speech ]];            [label setTextColor:[UIColor blueColor]];//Set text color in label.
            [label setTextAlignment:NSTextAlignmentLeft];//Set text alignment in label.
            [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
            [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
            [label setNumberOfLines:4];//Set number of lines in label.
            [label setClipsToBounds:YES];//Set its to YES for Corner radius to work.
            [_chatScrollview insertSubview:label atIndex: [_chatArray count]];
            [_chatArray addObject:chatMessage];

            
            [MBProgressHUD hideHUDForView:selfStrong.view animated:YES];
        } failure:^(AIRequest *request, NSError *error) {
            __strong typeof(selfWeak) selfStrong = selfWeak;
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
            [alertView show];
            
            [MBProgressHUD hideHUDForView:selfStrong.view animated:YES];
        }];
        
        [apiai enqueue:request];

        
        
        
    }
    
}


- (IBAction)askBotHelp:(id)sender {
    
    NSString *helpMessage = _userChatTextField.text;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(helpMessage){
       //GetUser
       User *user = User.getUser;
        
       UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 30*[_chatArray count], 300, 25)];//Set frame of label in your viewcontroller.
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setText:[helpMessage stringByAppendingString:[NSString stringWithFormat:@" : %@", user.firstName]]];//Set text in label.
        [label setTextColor:[UIColor darkGrayColor]];//Set text color in label.
        [label setTextAlignment:NSTextAlignmentRight];//Set text alignment in label.
        [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
        [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
        [label setNumberOfLines:4];//Set number of lines in label.
        [label setClipsToBounds:YES];//Set its to YES for Corner radius to work.
        [_chatScrollview insertSubview:label atIndex: [_chatArray count]];
         [_chatArray addObject:helpMessage];
        [self askBotRequest:helpMessage];
        _userChatTextField.text = @"";
        
    }
}
@end
