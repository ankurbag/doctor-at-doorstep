//
//  LoadingAnimationView.h
//  example
//
//
//

#import <UIKit/UIKit.h>

@interface LoadingAnimationView : UIView

- (void)showWithMessage:(NSString *)message inView:(UIView *)view;
- (void)hide;

@end
