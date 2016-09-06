//
//  Student.m
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "Student.h"

@implementation Student
@synthesize ID;
@synthesize name;
@synthesize s_id;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"";
    }
    return self;
}

-(instancetype)initWithID:(int) idFrom
                  Student_ID:(NSString *)st_id Name:(NSString *)sname{
    
    Student *studentModel = [[Student alloc]init];
    studentModel.s_id = st_id;
    studentModel.ID = idFrom;
    studentModel.name= sname;
    return studentModel;
}


@end
