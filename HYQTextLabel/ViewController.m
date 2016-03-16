//
//  ViewController.m
//  HYQTextLabel
//
//  Created by __无邪_ on 3/16/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "ViewController.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>
#import "HYQLabel.h"


static NSString *const TextCheckingResultAttributeName = @"TextCheckingResultAttributeName";

@interface ViewController ()
@property (nonatomic,strong)HYQLabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    // 1. 创建一个属性文本
//    
//    NSString *simpleText = @"@Fqah @小明 Some Text, blabla www.google.com www.hotyq.com";
//    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:simpleText];
//    
//    // 2. 为文本设置属性
//    UIFont *font = [UIFont systemFontOfSize:17];
//    text.yy_font = font;
//    text.yy_color = [UIColor blackColor];
//    text.yy_lineSpacing = 5;
//    
//    // 嵌入 UIImage
//    NSMutableAttributedString *attachment = nil;
//    UIImage *image = [UIImage imageNamed:@"ios_super_link"];
//    attachment = [NSMutableAttributedString yy_attachmentStringWithContent:image contentMode:UIViewContentModeCenter attachmentSize:image.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
//    NSAttributedString *attachmentText = [[NSAttributedString alloc] initWithString:@"网页链接" attributes:@{}];
//    [attachment appendAttributedString:attachmentText];
////    [text appendAttributedString: attachment];
//    
//    YYTextBorder *highlightNormalBorder = [YYTextBorder borderWithFillColor:[UIColor lightGrayColor] cornerRadius:3];
//    YYTextHighlight *highlightNormal = [YYTextHighlight new];
//    [highlightNormal setColor:[UIColor blueColor]];
//    [highlightNormal setBackgroundBorder:highlightNormalBorder];
//    
//    [text yy_setTextHighlight:highlightNormal range:NSMakeRange(0, text.length)];
//    
//    
//    YYTextBorder *highlightBorder = [YYTextBorder borderWithFillColor:[UIColor lightGrayColor] cornerRadius:3];
//    YYTextHighlight *highlight = [YYTextHighlight new];
//    [highlight setColor:[UIColor whiteColor]];
//    [highlight setBackgroundBorder:highlightBorder];
//    
//    
//    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
//    attributes[NSForegroundColorAttributeName] = [UIColor redColor];
//    
//    
//    NSMutableArray *ranges = [NSMutableArray new];
//    NSDataDetector *dataDetector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink error:NULL];
//    [dataDetector enumerateMatchesInString:simpleText options:0 range:NSMakeRange(0, simpleText.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
//        attributes[TextCheckingResultAttributeName] = result;
//        NSLog(@"%@",result);
//        [ranges addObject:NSStringFromRange(result.range)];
//        [text yy_setTextHighlight:highlight range:result.range];
//    }];
//    
//    for (int i = 0; i < ranges.count; i++) {
//        NSRange range = NSRangeFromString(ranges[ranges.count - i - 1]);
//        [text replaceCharactersInRange:range withAttributedString:attachment];
//        [text yy_setTextHighlight:highlight range:NSMakeRange(range.location, 5)];
//        [text yy_setColor:[UIColor blueColor] range:NSMakeRange(range.location, 5)];
//        [text yy_setFont:font range:NSMakeRange(range.location, 5)];
//    }
//    
//    
//    
    self.label = [[HYQLabel alloc] initWithText:@"@Fqah @小明 Some Text, @老牛 blabla www.google.com ss www.hotyq.com"];
    [self.label setFrame:CGRectMake(50, 100, 300, 500)];
//    self.label.attributedText = text;
//    self.label.numberOfLines = 0;
//    self.label.lineBreakMode = NSLineBreakByCharWrapping;
//    
//    
//    self.label.highlightTapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSLog(@"tap text rangess:...%@  %@ \n%@",NSStringFromRange(range),[text yy_plainTextForRange:range],[text string]);
//    };
//    self.label.highlightLongPressAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
//        NSLog(@"long press text rangess:...%@  %@",NSStringFromRange(range),[text yy_plainTextForRange:range]);
//    };
    
    
    
    [self.view addSubview:self.label];
    self.label.tapAction = ^(id model){
        NSLog(@"%@",model);
    };
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
