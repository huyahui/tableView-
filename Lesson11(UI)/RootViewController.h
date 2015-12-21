//
//  RootViewController.h
//


#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;
//表视图
@property (nonatomic, retain) NSMutableArray *datasourceArray;//数据源数组




@end
