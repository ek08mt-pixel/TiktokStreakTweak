#import <UIKit/UIKit.h>


%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if (![aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) return;

    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topVC.presentedViewController) topVC = topVC.presentedViewController;
    if (![NSStringFromClass([topVC class]) containsString:@"ChatViewController"]) return;

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // Thay vì tìm nút, ta tìm "khung soạn thảo" (InputView)
        // Sau đó kích hoạt sự kiện "nhấn nút gửi" của chính khung đó
        
        UIView *rootView = topVC.view;
        
        // Dùng lệnh "Gửi" trực tiếp thông qua hệ thống của TikTok (tên hàm giả định)
        // Ní thử dùng cách này: ép hệ thống thực thi hành động "gửi" (Send)
        [topVC performSelector:@selector(didClickSendButton:) withObject:nil afterDelay:0.1];
    });
}
%end
