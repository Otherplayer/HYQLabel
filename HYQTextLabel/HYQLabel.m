//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 3/16/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "HYQLabel.h"
#import "NSString+Categiries.h"

#define WS(weakSelf)          __weak __typeof(&*self)weakSelf = self;

@interface HYQLabel ()
@property (nonatomic,strong) NSString *simpleText;
@property (nonatomic,strong) NSMutableArray *textCheckingResults;
@property (nonatomic,strong) NSMutableArray *nickNameResults;
@end

@implementation HYQLabel

- (instancetype)initWithText:(NSString *)text{
    self = [super init];
    if (self) {
        
        NSString *replaceText = @"网页链接";
        UIColor *highlightNormalColor = [UIColor blueColor];//需要高亮显示的颜色
        UIColor *highlightColor = [UIColor whiteColor];//点击高亮显示的颜色
        UIColor *color = [UIColor blackColor];//普通文本颜色
        UIFont *font = [UIFont systemFontOfSize:17];//文本字体大小
        
        self.simpleText = text;
        self.textCheckingResults = [[NSMutableArray alloc] init];
        self.nickNameResults = [[NSMutableArray alloc] init];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:self.simpleText];
        
        
        // 2. 为文本设置属性
        attributedText.yy_font = font;
        attributedText.yy_color = color;
        //attributedText.yy_lineSpacing = 5;
        
        // 嵌入 UIImage
        NSMutableAttributedString *attachment = nil;
        UIImage *image = [UIImage imageNamed:@"ios_super_link"];
        attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        NSAttributedString *attachmentText = [[NSAttributedString alloc] initWithString:replaceText attributes:@{}];
        [attachment appendAttributedString:attachmentText];
        
        // 设置普通文本点击高亮效果
        YYTextBorder *highlightNormalBorder = [YYTextBorder borderWithFillColor:[UIColor lightGrayColor] cornerRadius:3];
        YYTextHighlight *highlightNormal = [YYTextHighlight new];
        [highlightNormal setColor:color];
        [highlightNormal setBackgroundBorder:highlightNormalBorder];
        [attributedText yy_setTextHighlight:highlightNormal range:NSMakeRange(0, attributedText.length)];
        
        // 设置高亮显示的文本（名字、链接）
        YYTextBorder *highlightBorder = [YYTextBorder borderWithFillColor:[UIColor lightGrayColor] cornerRadius:3];
        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setColor:highlightColor];
        [highlight setBackgroundBorder:highlightBorder];
        
        
        NSMutableArray *linkRanges = [NSMutableArray new];
        [self.textCheckingResults removeAllObjects];
        NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
        [dataDetector enumerateMatchesInString:text options:0 range:NSMakeRange(0, text.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
            [self.textCheckingResults addObject:result];
            [linkRanges addObject:NSStringFromRange(result.range)];
            [attributedText yy_setTextHighlight:highlight range:result.range];
        }];
        
        @autoreleasepool {
            //检索链接
            for (int i = 0; i < linkRanges.count; i++) {
                NSRange range = NSRangeFromString(linkRanges[linkRanges.count - i - 1]);
                [attributedText replaceCharactersInRange:range withAttributedString:attachment];
                [attributedText yy_setTextHighlight:highlight range:NSMakeRange(range.location, 5)];
                [attributedText yy_setColor:highlightNormalColor range:NSMakeRange(range.location, 5)];
                [attributedText yy_setFont:font range:NSMakeRange(range.location, 5)];
            }
            
            //检索名字
            NSArray *rangesNickname = [self.simpleText searchNicknameRanges];
            for (NSString *rangeString in rangesNickname) {
                NSRange range = NSRangeFromString(rangeString);
                [attributedText yy_setTextHighlight:highlight range:range];
                [attributedText yy_setColor:highlightNormalColor range:range];
                [attributedText yy_setFont:font range:range];
                [self.nickNameResults addObject:[self.simpleText substringWithRange:NSMakeRange(range.location + 1, range.length - 1)]];
            }
        }
        
        // 去掉第一个@符号
        [attributedText replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        
        // 设置文本
        self.attributedText = attributedText;
        self.numberOfLines = 0;
        self.lineBreakMode = NSLineBreakByCharWrapping;
        
        
        
        // 配置点击事件
        WS(weakSelf);
        
        self.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            //NSLog(@"tap text rangess:...%@  %@ ",NSStringFromRange(range),[text yy_plainTextForRange:range]);
            
            //点击的是链接还是名字
            NSString *target = [text yy_plainTextForRange:range];
            if (target.length == (replaceText.length + 1) && [target hasSuffix:replaceText]) {
                //检测点击的是第几个链接
                NSInteger index = 0;
                if (weakSelf.textCheckingResults.count > 1) {
                    NSArray *ranges = [[text string] searchRanges:replaceText];
                    NSRange resultRange = NSMakeRange(range.location + 1, range.length - 1);
                    index = [ranges indexOfObject:NSStringFromRange(resultRange)];
                }
                NSTextCheckingResult *result = weakSelf.textCheckingResults[index];
                if (weakSelf.tapAction) {
                    weakSelf.tapAction(result.URL);
                }
            }else{
                //点击的文本
                if ([target hasPrefix:@"@"]) {
                    target = [target stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
                }
                if (weakSelf.tapAction) {
                    if ([weakSelf.nickNameResults containsObject:target]) {
                        weakSelf.tapAction(target);
                    }else{
                        weakSelf.tapAction(nil);
                    }
                }
            }
        };
        self.highlightLongPressAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            NSLog(@"long press text rangess:...%@  %@",NSStringFromRange(range),[text yy_plainTextForRange:range]);
            if (weakSelf.longPressAction) {
                weakSelf.longPressAction(nil);
            }
        };
        
    }
    return self;
}


@end
