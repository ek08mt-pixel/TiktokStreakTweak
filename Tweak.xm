#import <UIKit/UIKit.h>


%hook NSNotificationCenter

// Hook vào hàm postNotification để xem app đang làm gì
- (void)postNotificationName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    
    // Lọc xem có tên nào liên quan đến "Message" hay "Chat" không
    if ([aName containsString:@"Message"] || [aName containsString:@"Chat"]) {
        // Nếu thấy, mình in ra log để biết chính xác tên nó là gì
        NSLog(@"TweakSystem: Phát hiện tin nhắn! Tên thông báo: %@", aName);
        
        // Hiện thông báo để mình chắc chắn 100% là mình đã "chạm" được vào nó
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Bắt được rồi!" 
                                                                           message:[NSString stringWithFormat:@"Tên hàm: %@", aName] 
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            [window.rootViewController presentViewController:alert animated:YES completion:nil];
        });
    }
    
    %orig;
}

%end
