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

        // Vét cạn tìm cái nút Gửi dựa trên kích thước nhỏ
        void (^findAndClick)(UIView *) = ^(UIView *view) {
            for (UIView *subview in view.subviews) {
                // Điều kiện: Là UIButton, kích thước nhỏ (cỡ nút gửi)
                if ([subview isKindOfClass:NSClassFromString(@"UIButton")] && 
                    subview.frame.size.width < 100 && subview.frame.size.height < 100) {
                    
                    // Kiểm tra vị trí: Nút Gửi nằm góc dưới phải
                    if (subview.frame.origin.x > (rootView.frame.size.width * 0.7) && 
                        subview.frame.origin.y > (rootView.frame.size.height * 0.7)) {
                        
                        // TẠO CÚ CHẠM ẢO (CÁCH NÀY KHÔNG GỌI HÀM NÊN KHÔNG BỊ LỖI)
                        CGPoint center = subview.center;
                        [subview touchesBegan:[NSSet setWithObject:[UITouch new]] withEvent:nil];
                        [subview touchesEnded:[NSSet setWithObject:[UITouch new]] withEvent:nil];
                        
                        return;
                    }
                }
                if (subview.subviews.count > 0) findAndClick(subview);
            }
        };
        findAndClick(rootView);
    });
}
%end
