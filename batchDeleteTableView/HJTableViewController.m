//
//  HJTableViewController.m
//  batchDeleteTableView
//
//  Created by MrHuang on 17/9/1.
//  Copyright © 2017年 Mrhuang. All rights reserved.
//

#import "HJTableViewController.h"
#import "HJTableViewCell.h"

@interface HJTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,strong)NSMutableArray *sourceArray;

@end

@implementation HJTableViewController


- (NSMutableArray *)sourceArray{
    
    if (_sourceArray == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"deals.plist" ofType:nil];
        
        NSArray *file = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *dicArray = [NSMutableArray array];
        
        for (NSDictionary *dic in file) {
            SourceModel *sources = [SourceModel dealWithDict:dic];
            [dicArray addObject:sources];
        }
        
        _sourceArray = dicArray;
    }
    return _sourceArray;
}


// 批量删除数据
- (IBAction)removeSources:(id)sender {
    
    //建立一个临时数组来存储需要被选中的删除数据
    NSMutableArray * tempArray = [NSMutableArray array];
    
    for (SourceModel *sources in self.sourceArray) {
        
        if (sources.checked) {
        
            [tempArray addObject:sources];
            
        }
    }
    
    // 删除模型数组里的被选中的数组
    [self.sourceArray removeObjectsInArray:tempArray];
    
    [self.tableView reloadData];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    
    return self.sourceArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HJTableViewCell *cell = [HJTableViewCell cellWithTableView:tableView];
    cell.sourceModel = self.sourceArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选中某一行
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 模型的打钩属性取反
    SourceModel *sourceModel = self.sourceArray[indexPath.row];
    
    sourceModel.checked = !sourceModel.isChecked;
    
    [tableView reloadData];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
 }
@end
