//
//  MSHTMLLabel.h
//  HTMLImg
//
//  Created by ms on 2019/7/22.
//  Copyright © 2019 ms. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface MSHTMLLabel : UILabel
@end

@interface MSHTMLImgModel :NSObject;
@property(nonatomic,assign) CGRect rect;
@property(nonatomic,strong) UIImage *image;
@end

NS_ASSUME_NONNULL_END
