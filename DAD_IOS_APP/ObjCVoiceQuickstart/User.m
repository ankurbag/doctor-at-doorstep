//
//  User.m
//  SIPster
//
//  Created by Abhishek Senapati on 4/15/17.
//  Copyright © 2017 NEU. All rights reserved.
//

#import "User.h"

@implementation User

static User * user;
@synthesize userName;
@synthesize password;
@synthesize location;
@synthesize age;
@synthesize firstName;
@synthesize lastName;

+(User *)getUser{
    if(!user){
        user= [[User alloc]init];
        
    }
    return user;
    
}

@end
