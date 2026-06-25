#import <UIKit/UIKit.h>


%hook AWEIMMessageManager

- (void)insertMessages:(id)arg1 {
    // Để app tự xử lý trước, mình chỉ "xem lén" thôi
    %orig; 
    
    // Thêm kiểm tra nhỏ để tránh văng
    if (arg1 != nil) {
        NSLog(@"TweakSystem: Đã nhận được tin nhắn!");
    }
}

%end
