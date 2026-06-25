#import <UIKit/UIKit.h>


// Hook thẳng vào Manager xử lý tin nhắn chính
%hook AWEIMMessageManager

- (void)insertMessages:(id)arg1 {
    %orig; // Cho nó chạy code gốc của app
    
    // Gửi thông báo ngay khi có tin nhắn chèn vào danh sách tin nhắn
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweak System"
                                                                       message:@"Đã có tin nhắn mới vào hệ thống!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
