//
//   /\_/\
//   \_ _/
//    / \ not
//    \_/
//
//  Created by __无邪_ on 3/16/16.
//  Copyright © 2016 fqah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>

typedef void(^HYQTextAction)(_Nullable id object);
@interface HYQLabel : YYLabel

- (nullable instancetype)initWithText:(nullable NSString *)text;

@property (nullable, nonatomic,strong) NSString *simpleText;

@property (nullable, nonatomic, copy) HYQTextAction tapAction;
@property (nullable, nonatomic, copy) HYQTextAction longPressAction;

@end
