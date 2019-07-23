//
//  MSHTMLLabel.m
//  HTMLImg
//
//  Created by ms on 2019/7/22.
//  Copyright © 2019 ms. All rights reserved.
//

#import "MSHTMLLabel.h"
#import "Masonry.h"
#define WeakObj(o) __weak typeof(o) o##Weak = o;
@interface MSHTMLLabel ()
@property(nonatomic,copy) NSArray *arr;
@property(nonatomic,strong) UIImageView *img;
@end

@implementation MSHTMLLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapLabel = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabel:)];
        [self addGestureRecognizer:tapLabel];
        self.numberOfLines = 0;
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)tapLabel:(UITapGestureRecognizer *)sender{
    WeakObj(self)
    [self getImageModelWithBlock:^{
        
        CGPoint point = [sender locationInView:selfWeak];
        
        NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
        
        MSHTMLImgModel *currentModel = nil;
        
        for (MSHTMLImgModel *model in selfWeak.arr) {
            
            if (CGRectContainsPoint(model.rect, point)){
                currentModel = model;
                break;
            }else {
                continue;
            }
        }
        if (currentModel) {
            // 点击查看大图,按需选择适合自己的方式
            [selfWeak lookupBigImgWithModel:currentModel];
        }

    }];

}

// 获取图片数组
- (void)getImageModelWithBlock:(void(^)(void))block{
    WeakObj(self)
    NSMutableArray *arr = [NSMutableArray array];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:(NSAttributedStringEnumerationLongestEffectiveRangeNotRequired) usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        if ([attrs objectForKey:@"NSAttachment"]) {
            MSHTMLImgModel *model = [MSHTMLImgModel new];
            NSTextAttachment *attachement = [attrs objectForKey:@"NSAttachment"];
            CGRect rect = [selfWeak boundingRectForCharacterRange:range];
            NSLog(@"===========%@",NSStringFromCGRect(rect));
            
            model.rect = rect;
            
            model.image = [UIImage imageWithData:attachement.fileWrapper.regularFileContents] ;
            
            [arr addObject:model];
        }
        if (range.location + range.length == self.attributedText.length) {
            selfWeak.arr = arr;
            block();
        }
        
    }];
}
// 获取图片相对于label的frame
- (CGRect)boundingRectForCharacterRange:(NSRange)range{
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.attributedText];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:[self bounds].size];
    
    textContainer.lineFragmentPadding = 0;
    [layoutManager addTextContainer:textContainer];
    NSRange glyphRange;
    [layoutManager characterRangeForGlyphRange:range actualGlyphRange:&glyphRange];
    
    CGRect rect = [layoutManager boundingRectForGlyphRange:glyphRange inTextContainer:textContainer];
    
    return rect;
    
}
#warning 点击查看大图，按需选择适合自己的方式
/*
- (void)lookupBigImgWithModel:(MSHTMLImgModel *)model{

    [[UIApplication sharedApplication].keyWindow addSubview:self.img];

    [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];

    self.img.image = model.image;
}

- (void)didClickImg{
    [self.img removeFromSuperview];
}
- (UIImageView *)img{
    if (!_img) {
        _img = [UIImageView new];
        _img.contentMode = UIViewContentModeScaleAspectFit;
        _img.userInteractionEnabled = YES;
        _img.backgroundColor = [UIColor blackColor];
        [_img addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickImg)]];
    }
    return _img;
}
*/

@end

@implementation MSHTMLImgModel

@end
