#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if (![aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) return;

    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) topVC = topVC.presentedViewController;
    if (![NSStringFromClass([topVC class]) containsString:@"ChatViewController"]) return;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *rootView = topVC.view;

        // KHAI BÁO __block ĐÚNG CÁCH ĐỂ TRÁNH LỖI BUILD
        __block void (^findAndSend)(UIView *);
        
        // ĐỊNH NGHĨA HÀM
        findAndSend = ^(UIView *view) {
            for (UIView *subview in view.subviews) {
                NSString *className = NSStringFromClass([subview class]);
                
                if ([subview isKindOfClass:NSClassFromString(@"UIButton")] || [className containsString:@"Send"]) {
                    CGRect frame = subview.frame;
                    if (frame.origin.x > (rootView.frame.size.width * 0.7) && frame.origin.y > (rootView.frame.size.height * 0.7)) {
                         [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                         return; 
                    }
                }
                if (subview.subviews.count > 0) findAndSend(subview);
            }
        };
        
        // GỌI HÀM
        findAndSend(rootView);
    });
}
%end
