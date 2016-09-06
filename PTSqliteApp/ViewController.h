//
//  ViewController.h
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"
#import "Constants.h"
#import "DBManager.h"
#import "EditViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    NSArray *allTasks;
}
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)buttonAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;



@end

