//
//  DBManager.h
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import <sqlite3.h>
#import "Constants.h"
#import "Student.h"
#import <Foundation/Foundation.h>

@interface DBManager : NSObject
{
    sqlite3 *myDB;
}
+(instancetype)sharedManager;
-(NSString *)getDatabasePath;
-(void)copyDatabaseToSandbox;
-(BOOL)executeQuery:(NSString *)query;
-(NSArray *)executeSelectQuery:(NSString *)query;

-(BOOL)insertQuery:(Student *)student;
-(void)deleteTask:(Student *)model;
-(BOOL)updateTask:(Student *)model;
@end
