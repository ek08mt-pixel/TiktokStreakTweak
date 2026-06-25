#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *rootView = window.rootViewController.view;
            
            // Khai báo __block để cho phép Block sử dụng đệ quy
            __block void (^findAndClickSend)(UIView *);
            findAndClickSend = ^(UIView *view) {
                for (UIView *subview in view.subviews) {
                    // Tìm UIButton hoặc các view có chứa chữ "Send"
                    if ([subview isKindOfClass:NSClassFromString(@"UIButton")] || [NSStringFromClass([subview class]) containsString:@"Send"]) {
                        [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                    }
                    if (subview.subviews.count > 0) findAndClickSend(subview);
                }
            };
            
            findAndClickSend(rootView);
        });
    }
}
%end
