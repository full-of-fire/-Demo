//
//  ViewController.m
//  大文件下载Demo
//
//  Created by yangjie on 15/12/24.
//  Copyright © 2015年 yangjie. All rights reserved.
//

#import "ViewController.h"
#import "NSString+YJPathString.h"
@interface ViewController ()<NSURLConnectionDataDelegate>

// 文件句柄对象
@property (nonatomic,strong) NSFileHandle *fileHandle;

@property (nonatomic,assign) long long totalFileLength;

@property (nonatomic,assign) long long currentFileLength;

@property (nonatomic,strong) NSURLConnection *connection;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)downAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        //下载
        
        NSString *urlString = @"http://photocdn.sohu.com/20151224/Img432492345.jpeg";
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        NSLog(@"%@",request.allHTTPHeaderFields);
        
        //设置请求头下载范围从哪里开始
        NSString *range = [NSString stringWithFormat:@"bytes=%lld",self.currentFileLength];
        
        
        [request setValue:range forHTTPHeaderField:@"Range"];
        
        // 发起异步下载请求
      self.connection =  [[NSURLConnection alloc] initWithRequest:request delegate:self];
    }
    else {
    
        //取消下载
        
        [self.connection cancel];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    NSString *urlString = @"";
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    // 发起异步下载请求
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {

    // 错误的时候调用
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    
    NSLog(@"什么鬼？？？");
    
    NSHTTPURLResponse *rep = (NSHTTPURLResponse*)response;
    
    NSLog(@"%@",rep);
    
    if (self.currentFileLength) {
        
        return;
    }
   // 开始响应
    //1、首先获取文件的长度
    self.totalFileLength = response.expectedContentLength;
    
    // 创建一个空的文件
    
    NSString *filePath = [[NSString stringOfCaches] stringByAppendingString:@"video.png"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    
    // 创建一个文件句柄
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // 接受数据
    self.currentFileLength+=data.length;
    float progress = (double)self.currentFileLength/self.totalFileLength;
    
    
    NSLog(@"%f",progress);
    //文件最后面
    [self.fileHandle seekToEndOfFile];
    
    // 把数据拼接到文件最后面
    [self.fileHandle writeData:data];
    
    
    
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

    // 下载完成
    
    self.currentFileLength = 0;
    self.totalFileLength = 0;
    
    // 一定要关闭
    [self.fileHandle closeFile];
    
    self.fileHandle = nil;
    
}

@end
