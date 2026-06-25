#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Tìm kiếm các nút (Button) trên màn hình hiện tại
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *rootView = window.rootViewController.view;
            
            // Hàm tìm và nhấn nút Gửi (Thường là tên chứa chữ "Send")
            void (^findAndClickSend)(UIView *) = ^(UIView *view) {
                for (UIView *subview in view.subviews) {
                    if ([subview isKindOfClass:NSClassFromString(@"UIButton")] || [NSStringFromClass([subview class]) containsString:@"Send"]) {
                        // Giả lập thao tác nhấn nút
                        [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                    }
                    // Đệ quy để tìm trong các lớp sâu hơn
                    if (subview.subviews.count > 0) findAndClickSend(subview);
                }
            };
            
            findAndClickSend(rootView);
        });
    }
}
%end
