//
//  ViewController.m
//  HBMotionManager
//
//  Created by Mac on 2020/11/16.
//  Copyright © 2020 yanruyu. All rights reserved.
//

#import "ViewController.h"
//添加重力头文件
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()
@property (nonatomic ,strong)UIImageView *qianBottomImg;//动画image
@property (nonatomic,strong) CMMotionManager *mManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.qianBottomImg];
    [self setAnchorPoint:CGPointMake(0, 0) forView:self.qianBottomImg];
    //添加重力效果
    [self addCMMotionManagerAner];
}
#pragma mark ==========添加重力效果==========
-(void)addCMMotionManagerAner{
    self.mManager = [[CMMotionManager alloc]init];
    if (!self.mManager.accelerometerAvailable) {
        // fail code // 检查传感器到底在设备上是否可用
    }
    self.mManager.accelerometerUpdateInterval = 0.01; // 告诉manager，更新频率是100Hz
    
    /* 加速度传感器开始采样，每次采样结果在block中处理 */
    // 开始更新，后台线程开始运行。
    [self.mManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error)
     {
         // 获取系统在X、Y、Z轴上的加速度数据
         CMAccelerometerData *newestAccel = self.mManager.accelerometerData;
         double accelerationX = newestAccel.acceleration.x;
         double accelerationY = newestAccel.acceleration.y;
//        double accelerationZ = newestAccel.acceleration.z;
         
         double ra = atan2(-accelerationY, accelerationX); // 返回值的单位为弧度，atan2(x,y)返回的是点(x,y)与x轴的夹角
//         ra += ;
//         double degree = ra * 360 / M_PI;
//         NSLog(@"----- %f ----", degree);
         //平移
         [UIView animateWithDuration:0.4 animations:^{
             self.qianBottomImg.transform = CGAffineTransformMakeRotation(ra);
         }];
         
         
     }];
}
/**
 设置缩放或旋转围绕的点
 
 @param anchorPoint 围绕的点
 @param view 设置的视图
 */
- (void)setAnchorPoint:(CGPoint)anchorPoint forView:(UIView *)view {
    CGPoint oldOrigin = view.frame.origin;
    view.layer.anchorPoint = anchorPoint;
    CGPoint newOrigin = view.frame.origin;
    
    CGPoint transition;
    transition.x = newOrigin.x - oldOrigin.x;
    transition.y = newOrigin.y - oldOrigin.y;
    
    view.center = CGPointMake (view.center.x - transition.x, view.center.y - transition.y);
}

-(UIImageView *)qianBottomImg{
    if (!_qianBottomImg) {
        _qianBottomImg = ({
            UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(200, 200, 54, 57)];
            //添加图片
            imgView.image = [UIImage imageNamed:@"reading_signNotdone"];
            imgView.contentMode = UIViewContentModeScaleAspectFit;
            imgView ;
        }) ;
    }
    return _qianBottomImg ;
}
@end
