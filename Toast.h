#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TimeType) {
    ShortTime,// 1.0s
    LongTime// 3.0s
};

@interface Toast : UIView

+ (instancetype)makeText:(NSString *)text;
- (void)showWithType:(TimeType)type;
//C0
//C1
//C2
@end
