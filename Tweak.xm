#import <UIKit/UIKit.h>

%hook AppDelegate

- (BOOL)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {
    // Gọi hàm gốc trước
    BOOL ret = %orig;

    // Hiển thị thông báo khi app khởi động
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tweak System"
                                                                       message:@"Tweak đã được nạp thành công!"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window.rootViewController presentViewController:alert animated:YES completion:nil];
    });
    
    return ret;
}

%end
