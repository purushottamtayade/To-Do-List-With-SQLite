//
//  EditViewController.m
//  PTSqliteApp
//
//  Created by Student P_06 on 04/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "EditViewController.h"

@interface EditViewController ()

@end

@implementation EditViewController

- (void)viewDidLoad {
    [self initScreen];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initScreen{
    selectedTask = self.taskSelected;
    self.textFieldEdit.text = selectedTask.name;
    self.textFieldEdit.enabled = NO;
    self.updateButton.enabled = NO;
    self.deleteButton.enabled = NO;
//    previousText = selectedTask.name;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//-(void)checkText:(NSString *)previousString current:(NSString *)currentText {
//if([currentText isEqualToString:previousString])
//{
//    self.updateButton.enabled = NO;
//}else{
//    self.updateButton.enabled = YES;
//}
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}



- (IBAction)editButtonTapped:(id)sender {
    UIButton *button = sender;
    if([button.titleLabel.text isEqualToString:@"Edit"])
    {
        [button setTitle:@"Reset" forState:UIControlStateNormal];
        self.textFieldEdit.enabled = YES;
        self.updateButton.enabled = YES;
        self.deleteButton.enabled = YES;
    }
    else if([button.titleLabel.text isEqualToString:@"Reset"])
    {
        [button setTitle:@"Edit" forState:UIControlStateNormal];
        self.textFieldEdit.enabled = NO;
        self.updateButton.enabled = NO;
        self.deleteButton.enabled = NO;
        self.textFieldEdit.text = previousText;
    }
}

- (IBAction)deleteButtonTapped:(id)sender {
  
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:@"Once deleted, you will be unable to retrieve it back." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[DBManager sharedManager]deleteTask:selectedTask];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}


- (IBAction)updateButtonTapped:(id)sender {
    if(![self.textFieldEdit.text isEqualToString:@""])
        selectedTask.name = self.textFieldEdit.text;
    if([[DBManager sharedManager]updateTask:selectedTask])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Unable to update" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        }
}
@end
