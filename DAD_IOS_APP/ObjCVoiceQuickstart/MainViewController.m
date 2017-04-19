//
//  MainViewController.m
//  SidebarDemo
//
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "User.h"
//#import "AFNetworking.h"
#define RAND_FROM_TO(min, max) (min + arc4random_uniform(max - min + 1))
@interface MainViewController ()

@end

@implementation MainViewController
static NSString * const BaseURLString =  @"https://api.twilio.com/2010-04-01/Accounts/AC4c0150c731ba109b664e62992be482c8/Calls.//json";
- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = User.getUser;
    NSLog(@"%@",user.userId);
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
    _loadingAnimationView = [LoadingAnimationView new];
}

-(IBAction)callButton:(id)sender{
    [self callNearestDoctor:@"Dr.Ankur Bag"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)randomValueBetween:(NSInteger)min and:(NSInteger)max {
    return (NSInteger)(min + arc4random_uniform(max - min + 1));
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
}

-(void) callNearestDoctor :(NSString *) doctorName{
    //NSString *twilioUrl = @"https://api.twilio.com/2010-04-01/Accounts/AC4c0150c731ba109b664e62992be482c8/Calls.// //json";
    //NSString *response = [self makeRestAPICall: twilioUrl];
    [self PostJson];
    NSString *message;
    if(!doctorName){
        message = @"Error while getting doctor name ! Please try again";
    }else{
        message=@"Calling Doctor .. ";
        message = [NSString stringWithFormat:@"%@%@", message, doctorName];

    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Information"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
-(NSString*) makeRestAPICall : (NSString*) reqURLStr
{
    NSURLRequest *Request = [NSURLRequest requestWithURL:[NSURL URLWithString: reqURLStr]];
    NSURLResponse *resp = nil;
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest: Request returningResponse: &resp error: &error];
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseString);
    return responseString;
}
-(void)PostJson {
    
    __block NSMutableDictionary *resultsDictionary;
    
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"+6172598868", @"To",@"+13476255515",@"From",@"AP685ed03ac7882286002ab1bc77a19904",@"ApplicationSid", nil];//if your json structure is something like {"title":"first title","blog_id":"1"}
    if ([NSJSONSerialization isValidJSONObject:userDictionary]) {//validate it
        NSError* error;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:userDictionary options:NSJSONWritingPrettyPrinted error: &error];
        NSURL* url = [NSURL URLWithString:@"https://api.twilio.com/2010-04-01/Accounts/AC4c0150c731ba109b664e62992be482c8/Calls.json"];
        NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
        [request setHTTPMethod:@"POST"];//use POST
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d",[jsonData length]] forHTTPHeaderField:@"Content-length"];
        [request setHTTPBody:jsonData];//set data
        __block NSError *error1 = [[NSError alloc] init];
        
        //use async way to connect network
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse* response,NSData* data,NSError* error)
        {
            if ([data length]>0 && error == nil) {
                resultsDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error1];
                NSLog(@"resultsDictionary is %@",resultsDictionary);
                
            } else if ([data length]==0 && error ==nil) {
                NSLog(@" download data is null");
            } else if( error!=nil) {
                NSLog(@" error is %@",error);
            }
        }];
    }
}

-(void) showError :(NSString *) errorMessage{
    
    if(!errorMessage){
        errorMessage = @"Error while getting meals ! Please try again";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:errorMessage
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void)callTwilioRestAPI{
    NSString *kTwilioSID=@"AP685ed03ac7882286002ab1bc77a19904";
    NSString *kTwilioSecret=@"b94a8ef33776e872d0d53f001044f0ba";
    
    NSDictionary *userDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:@"+6172598868", @"To",@"+13476255515",@"From",@"AP685ed03ac7882286002ab1bc77a19904",@"ApplicationSid", nil];//if your json
    NSString *urlString = [NSString stringWithFormat:@"https://%@:%@@api.twilio.com/2010-04-01/Accounts/%@/SMS/Messages", kTwilioSID, kTwilioSecret, kTwilioSID];
    
    NSURL *url                      = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request    = [[NSMutableURLRequest alloc] init];
    
    [request setURL:url];
    [request setHTTPMethod:@"POST"];

}

@end
