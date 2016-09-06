//
//  EditViewController.h
//  PTSqliteApp
//
//  Created by Student P_06 on 04/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "Student.h"
#import "DBManager.h"
#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController <UITextFieldDelegate>
{
    Student *selectedTask;
    NSString *previousText;
    NSString *changedText;
}

@property (nonatomic, retain) Student *taskSelected;

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editButton;

@property (weak, nonatomic) IBOutlet UIButton *updateButton;

- (IBAction)editButtonTapped:(id)sender;
- (IBAction)deleteButtonTapped:(id)sender;


- (IBAction)updateButtonTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textFieldEdit;





@end
