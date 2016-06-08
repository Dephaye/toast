#import "Toast.h"
@interface Toast ()
{
    UILabel *_label;
    NSString *_text;
    TimeType _time;
}
@end

static Toast *_toast = nil;

@implementation Toast

+ (instancetype)makeText:(NSString *)text {
    @synchronized(self) {
        if (_toast == nil) {
            _toast = [[Toast alloc] initWithText:text];
        }
    }
    return _toast;
}

- (void)showWithType:(TimeType)type {
    if (type == LongTime) {
        _time = 3.0f;
    } else {
        _time = 1.0f;
    }
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    NSTimer *timer = [NSTimer timerWithTimeInterval:_time
                                             target:self
                                           selector:@selector(removeToast)
                                           userInfo:nil
                                            repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer
                              forMode:NSDefaultRunLoopMode];
}

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _text = [text copy];
        // Initialization code
        UIFont *font = [UIFont systemFontOfSize:16];
        CGSize textSize = [_text boundingRectWithSize:CGSizeMake(280, 60)
                                              options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                           attributes:@{NSFontAttributeName:font}
                                              context:nil].size;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, textSize.width, textSize.height)];
        _label.text = _text;
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor whiteColor];
        _label.font = font;
        _label.numberOfLines = 0;
        _label.shadowColor = [UIColor darkGrayColor];
        _label.shadowOffset = CGSizeMake(1, 1);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        
        CGRect rect;
        rect.size = CGSizeMake(textSize.width + 20, textSize.height + 10);
        rect.origin = CGPointMake(([UIScreen mainScreen].bounds.size.width - rect.size.width) / 2, [UIScreen mainScreen].bounds.size.height * 3 / 4);
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [self setFrame:rect];
        [self addSubview:_label];
    }
    return self;
}

- (void)removeToast {
    [UIView animateWithDuration:1.0f
                     animations:^{
                         if (_toast.alpha != 0.0f) {
                             _toast.alpha = 0.0f;
                         }
                     }
                     completion:^(BOOL finished) {
                         _toast.alpha = 0.0f;
                         [_toast removeFromSuperview];
                         _toast = nil;
                     }
    ];
}

@end
