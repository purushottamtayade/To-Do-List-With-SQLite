//
//  Student.h
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic,strong) NSString *s_id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) int ID;


-(instancetype)initWithID:(int) idFrom
                  Student_ID:(NSString *)st_id
                     Name:(NSString *)sname;

@end
