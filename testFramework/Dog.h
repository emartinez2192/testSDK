//
//  Dog.h
//  testFramework
//
//  Created by Eduardo Martinez on 1/10/19.
//  Copyright © 2019 Eduardo Martinez. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : RLMObject
@property NSString *name;
@property NSData * picture;
@property NSInteger age;

@end

NS_ASSUME_NONNULL_END
