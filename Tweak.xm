#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        
        // 1. Dùng __block cho biến, và KHÔNG khởi tạo nó ngay tại đây
        __block void (^findAndSend)(UIView *);
        
        // 2. Định nghĩa block sau
        findAndSend = ^(UIView *view) {
            for (UIView *subview in view.subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"UIButton")]) {
                    // Logic lọc nút gửi
                    if (subview.frame.origin.y > 0 && subview.frame.size.width < 60 && subview.frame.size.height < 60) {
                         [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                         return;
                    }
                }
                if (subview.subviews.count > 0) findAndSend(subview);
            }
        };

        UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (topVC.presentedViewController) topVC = topVC.presentedViewController;

        if ([NSStringFromClass([topVC class]) containsString:@"ChatViewController"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                findAndSend(topVC.view);
            });
        }
    }
}
%end
