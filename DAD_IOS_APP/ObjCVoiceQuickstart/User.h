//
//  User.h
//  SIPster
//
//  Created by Abhishek Senapati on 4/15/17.
//  Copyright © 2017 NEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,readwrite) NSString * userId;
@property(nonatomic,readwrite)NSString * token;
@property(nonatomic,readwrite)NSString * domain;

+(User *)getUser;

@end
