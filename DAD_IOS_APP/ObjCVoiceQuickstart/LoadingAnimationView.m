//
//  LoadingAnimationView.m
//  example
//
//  
//
//

#import "LoadingAnimationView.h"
#import <QuartzCore/QuartzCore.h>


@interface LoadingAnimationView ()


@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@end

@implementation LoadingAnimationView

- (id)init
{
    NSArray *viewArray = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    
    return [viewArray objectAtIndex:0];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.backgroundColor = [[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3] CGColor];
    
}

- (void)showWithMessage:(NSString *)message inView:(UIView *)view
{
    [_indicatorView startAnimating];
    [self setFrame:CGRectMake(0,
                              0,
                              [[UIScreen mainScreen] bounds].size.width,
                              [[UIScreen mainScreen] bounds].size.height)];
   
    [view addSubview:self];
}

- (void)hide
{
     [_indicatorView stopAnimating];
    [self removeFromSuperview];
  
}

@end
