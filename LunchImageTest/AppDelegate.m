//
//  AppDelegate.m
//  LunchImageTest
//
//  Created by ckl@pmm on 2017/12/28.
//  Copyright © 2017年 pronetway. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kWidth  [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kBounds [UIScreen mainScreen].bounds
#define newKwith (kWidth/375)
#define newKhight (kHeight/667)
#define kTabBarH        49.0f
#define kStatusBarH     20.0f
#define kNavigationBarH 44.0f
#define kNavBarHAndStaBarH 64.0f
#define kdefaultcellH 44*newKhight
@interface AppDelegate ()<CAAnimationDelegate>

{
    
    UILabel *myTest1;
    CABasicAnimation *animation;
    UIImageView *logoimageV;
}


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self customLaunchImageView];

    return YES;
}

- (void)customLaunchImageView
{
    UIImageView *launchImageView = [[UIImageView alloc] initWithFrame:self.window.bounds];
    launchImageView.image = [self getLaunchImage];;
    
    [self.window addSubview:launchImageView];
    [self.window bringSubviewToFront:launchImageView];
    
    myTest1 = [[UILabel alloc]initWithFrame:CGRectMake(5,kHeight-250, 50, 50)];
    myTest1.backgroundColor = [UIColor whiteColor];
    myTest1.textAlignment = NSTextAlignmentCenter;
    myTest1.text = @"程昆仑";
    myTest1.layer.masksToBounds = YES;
    myTest1.layer.cornerRadius = 25;
    myTest1.textColor = [UIColor whiteColor];
    [launchImageView addSubview:myTest1];
    
    logoimageV = [[UIImageView alloc]initWithFrame:CGRectMake((kWidth-300)/2, (kHeight-150)/2, 300, 150)];
    logoimageV.image = [UIImage imageNamed:@"splash_logo"];
    logoimageV.alpha  = 0;
    [launchImageView addSubview:logoimageV];
    
    //路径动画。
    CGMutablePathRef myPah = CGPathCreateMutable();
    //CGPathGetCurrentPoint(myPah);
    // CGPathMoveToPoint(myPah, nil,kWidth/2, kHeight/2);
    CGPathMoveToPoint(myPah, nil,30, kHeight-250);//最后的点的位置
    CGPathAddLineToPoint(myPah, nil, kWidth/6, kHeight-100);
    CGPathAddLineToPoint(myPah, nil, kWidth/3, kHeight-200);
    CGPathAddLineToPoint(myPah, nil, kWidth/2, kHeight-100);
    CGPathAddLineToPoint(myPah, nil, kWidth/2, kHeight/2);
    // CGPathRelease(myPah);
    //CGPathCloseSubpath(myPah);

    [myTest1.layer addAnimation:[self keyframeAnimation:myPah durTimes:1.4f Rep:MAXFLOAT] forKey:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        myTest1.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            logoimageV.alpha = 1;

        } completion:^(BOOL finished) {
            
        }];
        
        [UIView animateWithDuration:0.8 animations:^{
            launchImageView.alpha = 0.0;
            logoimageV.alpha = 1;
            launchImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            [launchImageView removeFromSuperview];
        }];
    });
}

- (UIImage *)getLaunchImage
{
    UIImage *lauchImage = nil;
    NSString *viewOrientation = nil;
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
        
        viewOrientation = @"Landscape";
        
    } else {
        
        viewOrientation = @"Portrait";
    }
    
    NSArray *imagesDictionary = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDictionary) {
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            
            lauchImage = [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return lauchImage;
}


-(void)addlat {
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = 1.5f;
    opacityAnimation.autoreverses= NO;
    // opacityAnimation.delegate = self;
    opacityAnimation.repeatCount = 1;
    //    opacityAnimation.speed = 1.0f;
    
    CABasicAnimation * animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = [NSNumber numberWithDouble:0.9];
    animation2.toValue = [NSNumber numberWithDouble:10];
    animation2.duration= 1.5;
    animation2.autoreverses= NO;
    animation2.repeatCount= 1;  //"forever"
    //    animation2.removedOnCompletion= YES;
    [myTest1.layer addAnimation:animation2 forKey:@"scale"];
    [myTest1.layer addAnimation:animation2 forKey:@"scale"];
    [myTest1.layer addAnimation:opacityAnimation forKey:nil];
    [myTest1.layer addAnimation:opacityAnimation forKey:nil];
    
}

#pragma mark =====路径动画-=============
-(CAKeyframeAnimation *)keyframeAnimation:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    ///animation.autoreverses = NO;//是否原路返回
    animation.duration = time;
    animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = 1;
    //CGPathCloseSubpath(path);
    // CGPathRelease(path);
    //CGPathCloseSubpath(path);
    return animation;
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"动画结束了");
    // myTest1.alpha = 0;
    // myTest2.alpha = 1;
    [self addlat];
    
    
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
