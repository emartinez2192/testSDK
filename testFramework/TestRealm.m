//
//  TestRealm.m
//  testFramework
//
//  Created by Eduardo Martinez on 1/10/19.
//  Copyright © 2019 Eduardo Martinez. All rights reserved.
//

#import "TestRealm.h"
#import "Dog.h"
#import "sqlite3.h"


@implementation TestRealm

+(void)testRealm {
    NSLog(@"");
    
    NSMutableData *key = [NSMutableData dataWithLength:64];
    (void)SecRandomCopyBytes(kSecRandomDefault, key.length, (uint8_t *)key.mutableBytes);
    
    
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    
    config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent]
                       URLByAppendingPathComponent:@"FAD"]
                      URLByAppendingPathExtension:@"realm"];
    config.encryptionKey = key;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    
    RLMRealm *realm = [RLMRealm realmWithConfiguration:config error:nil];
    
    
    Dog *mydog = [[Dog alloc] init];
    mydog.name = @"Rex";
    mydog.age = 1;
    mydog.picture = nil;
    
    RLMResults<Dog *> *puppies = [Dog objectsWhere:@"age < 2"];
    puppies.count;
    
    NSLog(@"%@", [NSString stringWithFormat:@"%lu",(unsigned long)puppies.count]);
    
    
    [realm transactionWithBlock:^{
        [realm addObject:mydog];
    }];
    
    
    NSLog(@"%@", [NSString stringWithFormat:@"%lu",(unsigned long)puppies.count]);
    
    
    
}


+(void)testSQLCipher{
    
    NSString *dbPath = [[NSBundle mainBundle] URLForResource:@"sqlcipher" withExtension:@"db"];
    NSString *databasePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
                              stringByAppendingPathComponent: @"sqlcipher.db"];
    
    sqlite3 *db;
    sqlite3_stmt *stmt;
    bool sqlcipher_valid = NO;
    
    if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK) {
        const char* key = [@"BIGSecret" UTF8String];
    
        sqlite3_key(db, key, (int)strlen(key));
        if (sqlite3_exec(db, (const char*) "SELECT count(*) FROM sqlite_master;", NULL, NULL, NULL) == SQLITE_OK) {
            if(sqlite3_prepare_v2(db, "PRAGMA cipher_version;", -1, &stmt, NULL) == SQLITE_OK) {
                if(sqlite3_step(stmt)== SQLITE_ROW) {
                    const unsigned char *ver = sqlite3_column_text(stmt, 0);
                    if(ver != NULL) {
                        sqlcipher_valid = YES;
                        NSLog(@"ciper_version = %s", ver);
                        // password is correct (or database initialize), and verified to be using sqlcipher
                        
                    }
                }
                sqlite3_finalize(stmt);
            }
        }
        sqlite3_close(db);
    }
}




@end



