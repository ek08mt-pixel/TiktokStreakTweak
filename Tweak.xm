#import <UIKit/UIKit.h>


%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        // Delay 2 giây để app load xong tin nhắn
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Tìm cái Controller chứa khung chat hiện tại
            UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            // (Thao tác này sẽ cần ní tìm thêm Class của nút "Gửi" sau, 
            // nhưng bước này tui đang cài sẵn "hộp điều khiển" cho ní)
            NSLog(@"TweakSystem: Đã nhận tin! Đang kích hoạt chế độ Auto-reply...");
            
            // Tạm thời để log, lát tui chỉ ní cách "bấm" nút gửi
        });
    }
}
%end
