//
//  ViewController.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "tokenModel.h"
#import "tweetlistModel.h"
#import "NSString+Height.h"
#import "CoustomTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

{
    NSArray *titleArray;
    NSMutableArray *dataArray;
    UIScrollView *_scrollView;
}

@property(nonatomic,strong)NSString *code;

@property(nonatomic,strong)tokenModel *tokenModel;

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    titleArray = @[@"最新动弹",@"热门动弹",@"我的动弹"];
    dataArray = [[NSMutableArray alloc] init];
    [self setSelf];
    [self addContentView];
    WebViewController *webVC = [[WebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    webVC.getCodeBlock = ^(NSString *code){
        _code = code;
    };
}

-(void)viewWillAppear:(BOOL)animated{
    if (_code != nil) {
        [self completeResgin];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelf{
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    //设置清除nav对继承于scrollView的影响
    self.automaticallyAdjustsScrollViewInsets = NO;
    //nav的相关设置
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.title = @"动弹";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:20.0]};
}

-(void)addContentView{
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(kScreenSize.width/3 * i, 64, kScreenSize.width/3, 30);
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:15.0];
        if(i == 0){
            button.selected = YES;
        }
        button.tag = 11+i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 94, kScreenSize.width, kScreenSize.height - 94)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.contentSize = CGSizeMake(kScreenSize.width * 3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, kScreenSize.height - 94) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getData)];
    [footer setTitle:@"上拉可以加载更多数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"松开即可加载更多数据" forState:MJRefreshStatePulling];
    [footer setTitle:@"加载数据中..." forState:MJRefreshStateRefreshing];
    _tableView.mj_footer = footer;
    MJRefreshNormalHeader *headr = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dataArray = [[NSMutableArray alloc] init];
        [self getData];
    }];
    _tableView.mj_header = headr;
    [_scrollView addSubview:_tableView];
}

-(void)completeResgin{
    MyTool *tool = [[MyTool alloc] init];
    tool.completeRequest = ^(NSURLSessionDataTask *task, id responseObject){
        _tokenModel = [tokenModel mj_objectWithKeyValues:responseObject];
        [self getData];
    };
    [tool getTaskWithString:[NSString stringWithFormat:@"action/openapi/token?client_id=1A87yEJMQXxomZgspow4&client_secret=oI1zFXTdnhCBzX3xZEmE9qYRXH1fMVhN&grant_type=authorization_code&redirect_uri=.&code=%@&dataType=json&refresh_token=&callback=",_code]];
}

-(void)getData{
    int page = (int)dataArray.count/20;
    MyTool *tool = [[MyTool alloc] init];
    tool.completeRequest = ^(NSURLSessionDataTask *task, id responseObject){
        NSArray *dic = [responseObject objectForKey:@"tweetlist"];
        NSMutableArray *mutable = [tweetlistModel mj_objectArrayWithKeyValuesArray:dic];
        for (tweetlistModel *model in mutable) {
            [dataArray addObject:model];
        }
        [_tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    };
    [tool getTaskWithString:[NSString stringWithFormat:@"action/openapi/tweet_list?access_token=%@&pageSize=20&page=%d&dataType=json",_tokenModel.access_token,page + 1]];
}

#pragma 事件监听
-(void)buttonClick:(UIButton *)btn{
    if (!btn.selected) {
        for (int i = 0; i < 3; i++) {
            UIButton *button = (UIButton *)[self.view viewWithTag:11+i];
            button.selected = NO;
        }
        btn.selected = YES;
        [_scrollView setContentOffset:CGPointMake((btn.tag - 11) * kScreenSize.width, 0) animated:YES];
    }
}

#pragma tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"cell";
    CoustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[CoustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.model = dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //动态改变高度
    tweetlistModel *detail = dataArray[indexPath.row];
    float h = [NSString getHeightOfString:detail.body withFont:[UIFont systemFontOfSize:14.0]];
    return 60 + h;
}

#pragma scrollView代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        NSInteger index = _scrollView.contentOffset.x/kScreenSize.width;
        UIButton *btn = [self.view viewWithTag:11 + index];
        [self buttonClick:btn];
    }
}

@end
