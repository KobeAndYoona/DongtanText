//
//  WebViewController.m
//  DongtanText
//
//  Created by 王恒 on 16/9/9.
//  Copyright © 2016年 wangheng. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

{
    UIWebView *_webView;
}

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSelf];
    [self addContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setSelf{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"获取授权";
}

-(void)addContentView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, kScreenSize.width, kScreenSize.height-64)];
    NSURL *url = [NSURL URLWithString:[kURLStr stringByAppendingString:@"action/oauth2/authorize?client_id=1A87yEJMQXxomZgspow4&response_type=code&redirect_uri=.&state=x"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [self.view addSubview:_webView];
}

#pragma 代理
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    if(![webView.request.URL.absoluteString isEqualToString:@"https://www.oschina.net/action/oauth2/authorize?client_id=1A87yEJMQXxomZgspow4&response_type=code&redirect_uri=.&state=x"]){
        NSArray *urlA = [webView.request.URL.absoluteString componentsSeparatedByString:@"?"];
        NSString *code;
        if (urlA.count != 1) {
            NSArray *pramerA = [urlA[1] componentsSeparatedByString:@"&"];
            NSArray *codeA = [pramerA[0] componentsSeparatedByString:@"="];
            code = codeA[1];
        }
        self.getCodeBlock(code);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
