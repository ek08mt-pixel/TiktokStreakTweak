#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>

%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // Dùng trực tiếp biến topVC để nó không báo lỗi "unused variable" nữa
            UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController;
            if (topVC) {
                NSLog(@"TweakSystem: Đã tìm thấy rootViewController: %@", topVC);
            }
            
        });
    }
}
%end
