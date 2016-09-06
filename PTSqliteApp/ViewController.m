//
//  ViewController.m
//  PTSqliteApp
//
//  Created by Student P_06 on 03/09/16.
//  Copyright © 2016 Purushottam Tayade. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    
    [self updateTaskTableView];
}

-(void)fetchAllTask {
    
    allTasks = [[DBManager sharedManager]executeSelectQuery:@"SELECT * FROM Student"];
    for (Student *s in allTasks) {
        NSLog(@"%d\t%@\t%@",s.ID,s.s_id,s.name);
    }}


-(void)updateTaskTableView {
    
    [self fetchAllTask];
    if (allTasks.count >= 0) {
        [self.tableView reloadData];
        
    }
}

-(void)insertTask:(NSString *)text {
    NSLog(@"I am in insert task");

    if(text.length > 0 && ![text isEqualToString:@""])
    {
        NSLog(@"I am in insert task");
        Student *studentTask = [[Student alloc]init];
        studentTask.name = text;
        studentTask.s_id = [text uppercaseString];
if([[DBManager sharedManager]insertQuery:studentTask])
{
    NSLog(@"Task Inserted");
    self.textField.text = @"";
}
else{
    NSLog(@"Unable to insert task");
}
    }

    }

- (IBAction)buttonAdd:(id)sender {
    NSLog(@"button method");
    NSString *text = self.textField.text;
    [self insertTask:text];
    [self updateTaskTableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return allTasks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIButton *update = [[UIButton alloc]initWithFrame:CGRectMake(50, 50, 80, 30)];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    Student *st = [allTasks objectAtIndex:indexPath.row];
    cell.textLabel.text = st.name;
    [update addTarget:self action:@selector(updateData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:update];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EditViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"EditViewController"];
    view.taskSelected = [allTasks objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:view animated:YES];
}

-(void)updateData:(NSIndexPath *)indexPath{

    Student *st = [allTasks objectAtIndex:indexPath.row];
    if([[DBManager sharedManager]updateTask:st])
    {
        [self updateTaskTableView];
    }else{
        NSLog(@"Unable to update");
    }
    
    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Student *st = [allTasks objectAtIndex:indexPath.row];
        [[DBManager sharedManager]deleteTask:st];
        }
    [self updateTaskTableView];
}

@end
