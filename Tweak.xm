#import <UIKit/UIKit.h>


%hook NSNotificationCenter

// Hook vào hàm postNotificationName để bắt đúng cái tên thông báo ní vừa tìm ra
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    
    // Nếu tên thông báo khớp với cái ní vừa bắt được
    if ([aName isEqualToString:@"kAWEIMMessageRequestEntranceUnreadCount"]) {
        
        // Đợi 1-2 giây cho app xử lý tin nhắn xong rồi mình mới "phản công"
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // Ở đây sau này mình sẽ gọi hàm gửi tin nhắn (auto-reply)
            NSLog(@"TweakSystem: Đã nhận tin! Đang chuẩn bị Auto-reply...");
            
            // Tạm thời mình cho hiện thông báo để xác nhận là nó tự chạy nhé
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Auto-Reply" 
                                                                           message:@"Đang giữ streak..." 
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
        });
    }
    
    %orig;
}

%end

