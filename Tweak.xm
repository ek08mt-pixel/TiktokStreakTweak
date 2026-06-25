#import <UIKit/UIKit.h>

%hook AWEIMMessageManager

- (void)insertMessages:(id)arg1 {
    %orig;
    
    // Đưa vào hàng đợi chính để đảm bảo không bị crash khi hiện UI
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Đã bắt được tin!" 
                                                                       message:@"Tin nhắn mới đã vào hệ thống" 
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        // Dùng UIWindow để hiện thông báo bất kể ní đang ở đâu
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}
%end
