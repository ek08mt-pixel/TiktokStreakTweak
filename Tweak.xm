#import <UIKit/UIKit.h>

%hook AWEIMStreamManager

- (void)updateStreakWithCompletion:(id)arg1 {
    // Gọi hàm gốc để TikTok xử lý streak bình thường
    %orig;

    // Hiển thị thông báo để xác nhận Tweak đã load thành công
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweak System"
                                                                       message:@"Đã hook thành công hàm updateStreak!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert animated:YES completion:nil];
    });
}

%end
