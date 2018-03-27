//
//  UIWebViewController.m
//  IOSDemo
//
//  Created by 刘梦桦 on 2018/3/23.
//  Copyright © 2018年 lmh. All rights reserved.
//



#import "UIWebViewController.h"
#import <Masonry.h>
#import "NSObject+Argument.h"

@interface UIWebViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) UIToolbar * toolBar;
@property (nonatomic, strong) UIBarButtonItem * forwardButtonItem;
@property (nonatomic, strong) UIBarButtonItem * backwardButtonItem;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUI];
    
    // 1. 加载请求
//    [self loadRequestFromWebView:_webView withURL:@"http://www.jianshu.com"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"]]];
    
    // 2. 加载HTML页面
//    [self.webView loadHTMLString:@"<html><body>加载html页面</body></html>" baseURL:nil];
    // 3. 
//    [self.webView loadData:<#(nonnull NSData *)#> MIMEType:<#(nonnull NSString *)#> textEncodingName:<#(nonnull NSString *)#> baseURL:<#(nonnull NSURL *)#>]
    

//    // 方法签名 - 对方法的描述
//    NSMethodSignature * signature = [UIWebViewController instanceMethodSignatureForSelector:@selector(goToWebsite:)];
//    
//    //利用 NSInvocation 对象包装一次方法调用（方法调用者、方法名、方法参数、犯法返回值）
//    NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
//    invocation.target = self; // 调用者
//    invocation.selector = @selector(goToWebsite:); // 调用的方法
//    
//    // 设置参数
//    BOOL open = YES;
//    [invocation setArgument:&open atIndex:2]; // 第0个位置已经被占了
//    
//    // 调用方法
//    [invocation invoke];
    
    // 先检查再调用
    if ([self respondsToSelector:@selector(goToWebsite:andID:)]) {
        [self performSelector:@selector(goToWebsite:andID:) withObjects:@[@YES,@12123]];
    }
    
}

- (void)loadUI{
    
    _webView = [[UIWebView alloc]init];
    _webView.backgroundColor = [UIColor whiteColor];
    _webView.delegate = self;
    _webView.scalesPageToFit = YES;// 网页内容会缩小到适配整个设备屏幕
    _webView.dataDetectorTypes = UIDataDetectorTypeAll; // 检测各种特殊的字符串，比如网站、电话等
    [self.view addSubview:_webView];
    
    _toolBar = [[UIToolbar alloc]init];
    _toolBar.backgroundColor = [UIColor redColor];
    [self.view addSubview:_toolBar];
    
    _forwardButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"前进" style:UIBarButtonItemStylePlain target:self action:@selector(forward:)];
    _backwardButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"后退" style:UIBarButtonItemStylePlain target:self action:@selector(backward:)];
    UIBarButtonItem * spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem * reloadButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reload:)];
    _toolBar.items = @[_forwardButtonItem, _backwardButtonItem,spaceButtonItem,reloadButtonItem];
}

- (void)forward:(UIBarButtonItem *)item{
    [_webView goForward];
}

- (void)backward:(UIBarButtonItem *)item{
    [_webView goBack];
}

- (void)reload:(UIBarButtonItem *)item{
    [_webView reload];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];

    // 为何使用约束不行？
//    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self.view);
//    }];
//
//    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.top.mas_equalTo(self.view);
//        make.bottom.mas_equalTo(self.view.mas_top);
//    }];

    _webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44);
    //由于webView内部是scrollView，所以可以进行scrollView的操作
    _webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _toolBar.frame = CGRectMake(0, CGRectGetMaxY(_webView.frame), self.view.frame.size.width, 44);
    
}

#pragma mark - 加载网页
- (void)loadRequestFromWebView:(UIWebView *)webView withURL:(NSString *)url{
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
}

#pragma mark - UIWebViewDelegate

// 开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    NSLog(@"%s", __func__);
}

// 加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSLog(@"%s", __func__);
    
    self.forwardButtonItem.enabled = webView.canGoForward;
    self.backwardButtonItem.enabled = webView.canGoBack;
    
    // 执行JS代码
//    [webView stringByEvaluatingJavaScriptFromString:@"alert(100);"];
    
    // JS获取当前网页标题 返回值为获取的内容
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
}

// 加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"%s", __func__);
    
    self.forwardButtonItem.enabled = webView.canGoForward;
    self.backwardButtonItem.enabled = webView.canGoBack;
}

//代理方法如果有返回值一般是告诉它可以做什么不能做什么
/**
 * 每当webView即将发送请求之前，都会调用这个方法。 <1>可以在这里面实现一些拦截操作 <2>实现与JS的交互
 * @return 是否允许加载这个请求
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSLog(@"url = %@", request.URL);
    
    NSString * url = request.URL.absoluteString;
    
    if ([url hasPrefix:@"stzen://goToWebsite"]) {
        
        // 拦截操作
        
        // JS调用OC的方法
        // 先解析 解析需要自定义协议
        
        // 参数
        NSString * scheme = @"stzen://goToWebsite";
        NSString * subPath = [url substringFromIndex:scheme.length];
        NSArray * subPaths = [subPath componentsSeparatedByString:@":"];
        NSMutableArray * dSubPaths = [NSMutableArray arrayWithArray:subPaths];
        [dSubPaths removeObjectAtIndex:0];
        
        [self performSelector:@selector(goToWebsite:andID:) withObjects:dSubPaths];
        [self performSelector:@selector(goToWebsite:andID:) withObject:nil];

        return NO;
    }
    
    return YES;
}

#pragma mark - 函数
// 调用本地浏览器打开地址
- (void)goToWebsite:(NSString *)open andID:(NSString *)ID{
    
    NSLog(@"open = %@  ID = %@", open, ID);
    
    if (open) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.stzen.xyz"]];
    }else{
        NSLog(@"禁止打开");
    }
    
}


@end
