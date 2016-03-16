//
//  NSString+Categiries.h
//  HYQTextLabel
//
//  Created by __无邪_ on 3/16/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Categiries)


- (NSArray *)searchRanges:(NSString *)target;
- (NSArray *)searchNicknameRanges;//@与空格之间

@end
