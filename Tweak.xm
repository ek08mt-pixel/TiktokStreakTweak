#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    // 1. Chỉ lọc thông báo tin nhắn
    if (![aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) return;

    // 2. Kiểm tra có đang ở màn hình Chat không
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) topVC = topVC.presentedViewController;
    if (![NSStringFromClass([topVC class]) containsString:@"ChatViewController"]) return;

    // 3. Đợi khung chat load xong rồi quét
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *rootView = topVC.view;
        
        // Hàm tìm và nhấn nút
        void (^findAndSend)(UIView *) = ^(UIView *view) {
            for (UIView *subview in view.subviews) {
                NSString *className = NSStringFromClass([subview class]);
                
                // Điều kiện nhấn: Là nút Gửi, nằm góc dưới phải màn hình
                if ([subview isKindOfClass:NSClassFromString(@"UIButton")] || [className containsString:@"Send"]) {
                    CGRect frame = subview.frame;
                    if (frame.origin.x > (rootView.frame.size.width * 0.7) && frame.origin.y > (rootView.frame.size.height * 0.7)) {
                         
                         // Nhấn nút
                         [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                         
                         // Cú chạm bồi thêm (đề phòng app chặn lệnh nhấn)
                         [[UIApplication sharedApplication] sendAction:@selector(sendActionsForControlEvents:) to:subview from:nil forEvent:nil];
                         return; 
                    }
                }
                if (subview.subviews.count > 0) findAndSend(subview);
            }
        };
        findAndSend(rootView);
    });
}
%end
