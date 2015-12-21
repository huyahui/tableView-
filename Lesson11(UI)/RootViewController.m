//
//  RootViewController.m
//
//

#import "RootViewController.h"

@interface RootViewController ()

@property (nonatomic, retain) NSMutableArray *indexPaths;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //数据源的提供
    self.datasourceArray = [NSMutableArray arrayWithObjects:@"11111", @"2222", @"3333", @"4444", @"55555", @"6666", @"7777", @"88888", @"9999",@"10000", nil];
    
    //创建表视图
    self.tableView = [[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain] autorelease];
    //设置表视图的属性，并指定代理对象
    self.tableView.rowHeight = 60;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //为视图控制器在导航栏上添加编辑按钮
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(handleDeleteAction:)];
    self.navigationItem.rightBarButtonItem = deleteButton;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [deleteButton release];
//    self.navigationItem.rightBarButtonItem
}

- (void)handleDeleteAction:(UIBarButtonItem *)sender{
    for (int i = 0; i < self.indexPaths.count; i++) {
        [self.datasourceArray removeObjectAtIndex:[[self.indexPaths objectAtIndex:i] row]];
    }
    
    [self.tableView deleteRowsAtIndexPaths:self.indexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self.indexPaths removeAllObjects];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    NSLog(@"编辑按钮的响应");
    NSLog(@"%@", editing ? @"进入编辑状态":@"退出编辑状态");
    self.navigationItem.rightBarButtonItem.enabled = editing;
    [self.tableView setEditing:editing animated:animated];
}

- (void)dealloc{
    [_tableView release];
    [_datasourceArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 表视图的代理方法和数据源代理方法的实现 -
//必须由代理对象提供表视图需要显示的数据的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArray.count + 1;
}

//有代理对象通过协议方法为表视图提供显示数据的单元格对象
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //1.声明静态的重用标识符
    static NSString *cellidentifer = @"CELL";
    //2.根据重用标识符在单元格的重用队列中获取可用单元格对象
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifer];
    //3.如果没有可用单元格则创建一个新的单元格对象
    if (nil == cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifer] autorelease];
    }
    //如果if语句的条件成立，说明是最后一行
    if (indexPath.row == self.datasourceArray.count) {
       cell.textLabel.text = @"添加新的一行";
    } else {
        //4.让单元格对象展示对应的数据
        cell.textLabel.text = [self.datasourceArray objectAtIndex:indexPath.row];
    }
    //5.将添加了数据的单元格对象返回给表视图，供表视图显示
    return cell;
}

//首先需要代理对象通过协议方法设置可以进行编辑的单元格
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0 || indexPath.row == self.datasourceArray.count) {
//        return YES;
//    }
    return YES;
}

//其次，需要为可以进行编辑的单元格指定编辑类型，比如删除，和插入
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == self.datasourceArray.count) {
//        //如果是最后一行，则返回插入类型
//        return UITableViewCellEditingStyleInsert;
//    } else {
//        //如果为其他行，则返回删除类型
//        return UITableViewCellEditingStyleDelete;
//    }
//    //默认返回空类型
//    return UITableViewCellEditingStyleNone;
    if (indexPath.row == self.datasourceArray.count) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleInsert | UITableViewCellEditingStyleDelete;
}

//最后，需要代理协助表视图完成编辑操作，不同的编辑类型完成不同的编辑效果（编辑的重点是先对数据源数组做操作，再对视图上的单元格做操作）
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        //如果是删除类型，则对数组做删除相应的数据操作，再删除单元格
//        //1.先删除数组中数据
//        [self.datasourceArray removeObjectAtIndex:indexPath.row];
//        //2.删除对应数据的单元格
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        //如果是插入类型，则对数组做插入数据的操作，在插入新的单元格
//        //1.先对新的数据做插入操作
//        [self.datasourceArray insertObject:@"牟向阳" atIndex:indexPath.row];
//        //2.插入新的单元格对象
//        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
//    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@", @"xxxx");
    if (self.editing) {
        if (!self.indexPaths) {
            self.indexPaths = [NSMutableArray array];
        }
        
        [self.indexPaths addObject:indexPath];
    }
}






@end
