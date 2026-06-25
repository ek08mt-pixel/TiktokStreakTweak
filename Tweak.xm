#import <UIKit/UIKit.h>

%hook AWEIMMessageManager

- (void)messageDidReceive:(id)arg1 {
    %orig; // Vẫn để app chạy bình thường
    
    // Hiện thông báo khi có tin nhắn mới tới
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweak System"
                                                                       message:@"Đã bắt được tin nhắn mới!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
