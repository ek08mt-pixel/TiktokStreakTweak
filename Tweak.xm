#import <UIKit/UIKit.h>


%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Tìm tất cả các cửa sổ hiện tại
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            
            // Tìm khung chat dựa trên Class đặc trưng của TikTok (thường là AWEIMView)
            // Nếu không tìm thấy, mình sẽ quét giới hạn trong subview của rootViewController
            UIView *rootView = window.rootViewController.view;
            
            void (^smartFindAndClick)(UIView *) = ^(UIView *view) {
                for (UIView *subview in view.subviews) {
                    
                    // BỘ LỌC CHẶN: Nếu là nút Live hoặc Micro, bỏ qua ngay!
                    NSString *viewClass = NSStringFromClass([subview class]);
                    if ([viewClass containsString:@"Live"] || [viewClass containsString:@"Microphone"] || [viewClass containsString:@"Voice"]) {
                        continue; 
                    }
                    
                    // CHỈ NHẤN nếu đó là UIButton VÀ nằm ở khu vực tin nhắn
                    // (Thông thường các nút Gửi tin nhắn nằm trong một container view riêng)
                    if ([subview isKindOfClass:NSClassFromString(@"UIButton")]) {
                        // Thêm điều kiện: Phải là nút có icon "mũi tên gửi" hoặc chữ "Gửi"
                        // Ở đây tui giới hạn kích thước nút nhỏ hơn 80px để tránh bấm nhầm các nút lớn của app
                        if (subview.frame.size.width < 80 && subview.frame.size.height < 80) {
                             [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                             return; // Tìm thấy 1 nút gửi là đủ, thoát ngay
                        }
                    }
                    
                    // Đệ quy
                    if (subview.subviews.count > 0) smartFindAndClick(subview);
                }
            };
            
            smartFindAndClick(rootView);
        });
    }
}
%end
