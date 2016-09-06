//
//  DBManager.m
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+(instancetype)sharedManager{

    static DBManager *sharedInstance;
    if(sharedInstance == nil)
    {
        sharedInstance = [[DBManager alloc]init];
    }
    return sharedInstance;
}

-(NSString *)getDatabasePath{
    NSArray *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *databasePath = [[docDir objectAtIndex:0]stringByAppendingPathComponent:kDatabaseFullName];
    return databasePath;
}

-(void)copyDatabaseToSandbox{
    NSString *sourcePath = [[NSBundle mainBundle]pathForResource:kDatabaseName ofType:kextension];
//    NSLog(@"Source Path : %@",sourcePath);
    NSString *destinationpath = [self getDatabasePath];
    NSLog(@"Database Path :\n\n %@ \n\n",destinationpath);
    BOOL isSourcePathExist = [[NSFileManager defaultManager]fileExistsAtPath:sourcePath];
    BOOL isDestinationPathExist = [[NSFileManager defaultManager]fileExistsAtPath:destinationpath];
    if(isSourcePathExist)
    {
        if(isDestinationPathExist)
        {
            NSLog(@"File already exist at destination");
        }
        else{
            //Copy Database
            NSError *error;
            [[NSFileManager defaultManager]copyItemAtPath:sourcePath toPath:destinationpath error:&error];
            if(error)
            {
                NSLog(@"%@",error.localizedDescription);
            }
            else
            {
                NSLog(@"Successfully copied database");
            }
        }
    }
    else
        NSLog(@"Database is not in bundle");
    
}

-(BOOL)executeQuery:(NSString *)query{

    BOOL status = false;
    sqlite3_stmt *statement;
    const char *utfQuery = [query UTF8String];
    const char *utfDatabasePath = [[self getDatabasePath]UTF8String];
    if(sqlite3_open(utfDatabasePath,&myDB) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(myDB,utfQuery,-1,&statement,NULL) == SQLITE_OK) {

            if(sqlite3_step(statement) == SQLITE_DONE)
            {

                status = true;
            }
            
        }
        sqlite3_close(myDB);
    }
    return status;
}

-(BOOL)insertQuery:(Student *)student{
    NSString *insertQ = [NSString stringWithFormat:@"INSERT INTO Student (s_id,name) VALUES ('%@','%@')",student.s_id,student.name];
    if([[DBManager sharedManager]executeQuery:insertQ] == YES)
    {
        return YES;
    }else{
        return NO;
    }
}

-(NSArray *)executeSelectQuery:(NSString *)query{
    NSMutableArray *allTasks = [[NSMutableArray alloc]init];
    sqlite3_stmt *statement;
    const char *utfQuery = [query UTF8String];
    const char *utfDatabasePath = [[self getDatabasePath]UTF8String] ;
    
    if (sqlite3_open(utfDatabasePath,&myDB) == SQLITE_OK) {
        
        if (sqlite3_prepare_v2(myDB,utfQuery,-1,&statement,NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                int idFrom = sqlite3_column_bytes(statement,0);
                const unsigned char * utfID = sqlite3_column_text(statement,1);
                const unsigned char * utfName = sqlite3_column_text(statement,2);
                NSString *ID = [NSString stringWithUTF8String:(const char *)utfID];
                NSString *name = [NSString stringWithUTF8String:(const char *)utfName];
                NSLog(@"%d",idFrom);
                Student *studentModel = [[Student alloc]initWithID:idFrom Student_ID:ID Name:name];
                NSLog(@"%@ \t %@",studentModel.s_id,studentModel.name);
                [allTasks addObject:studentModel];
            }
        }
    }
    NSArray *arr = [NSArray arrayWithArray:allTasks];
    return arr;
}

-(void)deleteTask:(Student *)model{
    NSLog(@"Model ID :%@ NAme:%@",model.s_id,model.name);
    NSString *updateQuery = [NSString stringWithFormat:@"DELETE FROM Student WHERE name = '%@'",model.name];
    
    
    if ([[DBManager sharedManager]executeQuery:updateQuery] == YES) {
        NSLog(@"Success : Deleted Task %@",model);
    }
    else {
        NSLog(@"Unable to delete task.");
        
    }
    }






-(BOOL)updateTask:(Student *)model{
    NSString *updateQ = [NSString stringWithFormat:@"UPDATE Student SET name = '%@' WHERE s_id = '%@'",model.name,model.s_id];

    NSLog(@"%@  \n\n %@",model.name,model.s_id);
    if([[DBManager sharedManager]executeQuery:updateQ])
    {
        NSLog(@"%@ is updated",model.name);
        return YES;
    }
    else{
        NSLog(@"Unable to update");
        return  NO;
    }
}

@end
