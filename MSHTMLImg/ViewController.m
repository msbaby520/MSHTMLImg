//
//  ViewController.m
//  HTMLImg
//
//  Created by ms on 2019/7/22.
//  Copyright © 2019 ms. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "MSHTMLLabel.h"
#define WeakObj(o) __weak typeof(o) o##Weak = o;

@interface ViewController ()
@property(nonatomic,strong) MSHTMLLabel *label;
@property(nonatomic,copy) NSArray *arr;
@property(nonatomic,strong) UIImageView *img;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label = [MSHTMLLabel new];
    [self.view addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(20);
        make.top.mas_equalTo(self.view).offset(100);
    }];
    
    
    NSString *str = @"<p>这是第一张图片</p><p><img src=\"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563783041237&di=d0ed16a2df722fce876f82a4d5a45ce1&imgtype=0&src=http%3A%2F%2Fwww.pptbz.com%2Fupfile%2Fpptpic%2F201407%2F2014072815340215.jpg\" width=\"300\"  ></p><p>这是第二张图片这是第二张图片这是第二张图片这是第二张图片这是第二张图片这是第二张图片这是第二张图片</p><p><img src=\"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1563787705041&di=7708747caf3ee9da672ce4ce0848a60c&imgtype=0&src=http%3A%2F%2Fpic41.nipic.com%2F20140508%2F18609517_112216473140_2.jpg\" width=\"300\" ></p>";
    
    NSMutableAttributedString *htmlStr = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    
    [htmlStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, htmlStr.length)];
    
    self.label.attributedText = htmlStr;
}

@end
