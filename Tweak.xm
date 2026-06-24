#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <substrate.h>

// CaptainHook headers
#import <CaptainHook/CaptainHook.h>

// Forward declarations for the classes we want to hook
@interface AWEIMStreakManager : NSObject
// Add any methods you want to hook here, example:
- (void)updateStreakWithCompletion:(id)completion;
- (void)resetStreak;
@end

@interface AWEIMMessageSender : NSObject
// Add any methods you want to hook here, example:
- (void)sendMessage:(id)message toUser:(id)user;
- (void)sendTypingIndicator:(BOOL)isTyping;
@end

// Hook implementation using CaptainHook
CHDeclareClass(AWEIMStreakManager)
CHDeclareClass(AWEIMMessageSender)

// MARK: - AWEIMStreakManager Hooks

CHOptimizedMethod(0, self, void, AWEIMStreakManager, updateStreakWithCompletion, id, completion) {
    NSLog(@"[MyAwesomeTweak] AWEIMStreakManager::updateStreakWithCompletion called");
    
    // Add your custom logic here
    
    // Call original method
    CHSuper(0, AWEIMStreakManager, updateStreakWithCompletion, completion);
}

CHOptimizedMethod(0, self, void, AWEIMStreakManager, resetStreak) {
    NSLog(@"[MyAwesomeTweak] AWEIMStreakManager::resetStreak called");
    
    // Add your custom logic here
    
    // Call original method
    CHSuper(0, AWEIMStreakManager, resetStreak);
}

// MARK: - AWEIMMessageSender Hooks

CHOptimizedMethod(0, self, void, AWEIMMessageSender, sendMessage, id, message, toUser, id, user) {
    NSLog(@"[MyAwesomeTweak] AWEIMMessageSender::sendMessage called");
    
    // Add your custom logic here
    
    // Call original method
    CHSuper(0, AWEIMMessageSender, sendMessage, message, toUser, user);
}

CHOptimizedMethod(0, self, void, AWEIMMessageSender, sendTypingIndicator, BOOL, isTyping) {
    NSLog(@"[MyAwesomeTweak] AWEIMMessageSender::sendTypingIndicator called with: %d", isTyping);
    
    // Add your custom logic here
    
    // Call original method
    CHSuper(0, AWEIMMessageSender, sendTypingIndicator, isTyping);
}

// MARK: - Constructor

CHConstructor {
    @autoreleasepool {
        NSLog(@"[MyAwesomeTweak] Loading tweak...");
        
        // Register our hooks
        CHLoadLateClass(AWEIMStreakManager);
        CHLoadLateClass(AWEIMMessageSender);
        
        // Hook AWEIMStreakManager methods
        CHHook(0, AWEIMStreakManager, updateStreakWithCompletion);
        CHHook(0, AWEIMStreakManager, resetStreak);
        
        // Hook AWEIMMessageSender methods
        CHHook(0, AWEIMMessageSender, sendMessage, toUser);
        CHHook(0, AWEIMMessageSender, sendTypingIndicator);
        
        NSLog(@"[MyAwesomeTweak] Tweak loaded successfully!");
    }
}
