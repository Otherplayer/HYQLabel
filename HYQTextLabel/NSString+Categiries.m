//
//  NSString+Categiries.m
//  HYQTextLabel
//
//  Created by __无邪_ on 3/16/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import "NSString+Categiries.h"

@implementation NSString (Categiries)
- (NSArray *)searchRanges:(NSString *)target{
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:target options:0 error:&error];
    NSAssert(regex, @"Regex failed: %@", error);
    NSArray *results = [regex matchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, self.length)];
    if (error) {
        NSLog(@"ERROR:%@",error.debugDescription);
    }
    
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    if (results) {
        for (NSTextCheckingResult *rs in results) {
            [ranges addObject:NSStringFromRange(rs.range)];
            //NSLog(@"%@",NSStringFromRange(rs.range));
        }
        return ranges;
    }
    return nil;
}

- (NSArray *)searchNicknameRanges{
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"@([^\\ ]*) " options:0 error:&error];
    NSAssert(regex, @"Regex failed: %@", error);
    
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    [regex enumerateMatchesInString:self options:0 range:NSMakeRange(0, [self length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange range = [result rangeAtIndex:1];
        [ranges addObject:NSStringFromRange(NSMakeRange(range.location - 1, range.length + 1))];
//        NSString *foundKey = [self substringWithRange:range];
//        NSLog(@"foundKey = %@", foundKey);
    }];
    return ranges;
}

@end
