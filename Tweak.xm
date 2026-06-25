#import <UIKit/UIKit.h>


%hook NSNotificationCenter

- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    %orig;

    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            UIView *rootView = window.rootViewController.view;
            
            // 1. Khai báo biến với __block trước
            __block void (^smartFindAndClick)(UIView *);
            
            // 2. Định nghĩa nội dung của block sau
            smartFindAndClick = ^(UIView *view) {
                for (UIView *subview in view.subviews) {
                    
                    NSString *viewClass = NSStringFromClass([subview class]);
                    // Vẫn giữ bộ lọc để không bấm nhầm vào Live/Mic
                    if ([viewClass containsString:@"Live"] || [viewClass containsString:@"Microphone"] || [viewClass containsString:@"Voice"]) {
                        continue; 
                    }
                    
                    if ([subview isKindOfClass:NSClassFromString(@"UIButton")]) {
                        if (subview.frame.size.width < 80 && subview.frame.size.height < 80) {
                             [(UIButton *)subview sendActionsForControlEvents:UIControlEventTouchUpInside];
                             return; 
                        }
                    }
                    
                    if (subview.subviews.count > 0) smartFindAndClick(subview);
                }
            };
            
            smartFindAndClick(rootView);
        });
    }
}
%end
