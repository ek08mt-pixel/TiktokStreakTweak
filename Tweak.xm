#import <UIKit/UIKit.h>




%hook NSObject // Hook vào class cha để quan sát mọi thứ

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"TweakSystem: App gọi hàm lạ: %@", NSStringFromSelector(aSelector));
    %orig;
}

%end
