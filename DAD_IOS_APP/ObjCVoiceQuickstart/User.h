//
//  User.h
//  SIPster
//
//  Created by Abhishek Senapati on 4/15/17.
//  Copyright © 2017 NEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,readwrite) NSString * userName;
@property(nonatomic,readwrite) NSString * firstName;
@property(nonatomic,readwrite) NSString * lastName;
@property(nonatomic,readwrite) NSString * location;
@property(nonatomic,readwrite) NSString * password;
@property(nonatomic,readwrite) NSNumber * age;

+(User *)getUser;

@end
