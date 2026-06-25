#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    // 1. CHỈ XỬ LÝ KHI CÓ TIN NHẮN MỚI
    if (![aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        %orig;
        return;
    }

    // 2. LẤY MÀN HÌNH ĐANG HIỂN THỊ
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) topVC = topVC.presentedViewController;

    // 3. ĐIỀU KIỆN SỐNG CÒN: PHẢI LÀ MÀN HÌNH CHAT
    // Tên class chat của TikTok thường chứa "ChatViewController"
    if (![NSStringFromClass([topVC class]) containsString:@"ChatViewController"]) {
        %orig;
        return; 
    }

    // Nếu đã ở màn hình chat, thì mới chạy tiếp
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIView *rootView = topVC.view;
        
        // 4. HÀM TÌM NÚT GỬI (GẮT GAO HƠN)
        void (^findAndSend)(UIView *) = ^(UIView *view) {
            for (UIView *subview in view.subviews) {
                // Chỉ tìm các UIButton
                if ([subview isKindOfClass:NSClassFromString(@"UIButton")]) {
                    // LỌC THEO VỊ TRÍ: Nút gửi luôn nằm ở 1/3 cuối màn hình
                    if (subview.frame.origin.y > (rootView.frame.size.height * 0.7)) {
                        // LỌC THEO KÍCH THƯỚC: Nút gửi thường là nút nhỏ
                        if (subview.frame.size.width < 60 && subview.frame.size.height < 60) {
                             [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                             return; 
                        }
                    }
                }
                if (subview.subviews.count > 0) findAndSend(subview);
            }
        };
        findAndSend(rootView);
    });

    %orig;
}
%end
