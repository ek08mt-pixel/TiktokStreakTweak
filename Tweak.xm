#import <UIKit/UIKit.h>

%hook AWEIMStreamManager

- (void)updateStreakWithCompletion:(id)arg1 {
    %orig;
}

%end
