#import <UIKit/UIKit.h>

%hook AWEIMMessageService

// Thử hook vào hàm nhận tin nhắn mới (thường là tên này trong các app chat)
- (void)didReceiveMessage:(id)arg1 {
    %orig; // Cho nó chạy gốc
    
    // Hiện thông báo để test
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Bắt được tin!"
                                                                       message:@"Đã thấy tin nhắn mới qua Service!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
