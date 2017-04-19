//
//  PhotoViewController.m
//  SidebarDemo
//
//  Created by Simon Ng on 10/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

#import "InviteViewController.h"
#import "SWRevealViewController.h"
//#import "ChatRequest.h"

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
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)askBotHelp:(id)sender {
    
    NSString *helpMessage = _userChatTextField.text;
    if(helpMessage){
       
       UILabel * label=[[UILabel alloc]initWithFrame:CGRectMake(10, 30*[_chatArray count], 300, 25)];//Set frame of label in your viewcontroller.
        [label setFont:[UIFont systemFontOfSize:13]];
    //    [label setBackgroundColor:[UIColor darkGrayColor]];//Set background color of label.
        [label setText:[helpMessage stringByAppendingString:[NSString stringWithFormat:@" : %@", @"User"]]];//Set text in label.
        [label setTextColor:[UIColor darkGrayColor]];//Set text color in label.
        [label setTextAlignment:NSTextAlignmentRight];//Set text alignment in label.
        [label setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];//Set line adjustment.
        [label setLineBreakMode:NSLineBreakByCharWrapping];//Set linebreaking mode..
        [label setNumberOfLines:4];//Set number of lines in label.
    //    [label.layer setCornerRadius:5.0];//Set corner radius of label to change the shape.
    //    [label.layer setBorderWidth:1.0f];//Set border width of label.
        [label setClipsToBounds:YES];//Set its to YES for Corner radius to work.
      //hkhk  [label.layer setBorderColor:[UIColor darkGrayColor].CGColor];//Set Border color.
       // [label sizeToFit];
        [_chatScrollview insertSubview:label atIndex: [_chatArray count]];
         [_chatArray addObject:helpMessage];
        [self askBotRequest:helpMessage];
        _userChatTextField.text = @"";
        
    }
}
@end
