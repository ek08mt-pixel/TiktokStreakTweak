#import <UIKit/UIKit.h>


// Hook vào một class chung của tin nhắn để bắt sự kiện
%hook AWEIMMessageManager 

- (void)didReceiveMessage:(id)arg1 {
    %orig;
    
    // Gửi thông báo ra log để xem nó có chạy không
    NSLog(@"TweakSystem: Đã nhận được tin nhắn!");
    
    // Ní cứ thử hàm này, nếu vẫn không được tui sẽ chỉ ní cách dump Class
}

%end

