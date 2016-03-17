//
//  ViewController.m
//  emitterLoop
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "ViewController.h"
#import "SYEmitterLoopView.h"
#import "EmitterSampleVC.h"
#import "SYLoadingLoopView.h"
#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOtherEmitter];
    [self initEmitter];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initOtherEmitter
{
    SYEmitterLoopView *loopView = [[SYEmitterLoopView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2-50, 100, 100)];
    [self.view addSubview:loopView];
    
    SYLoadingLoopView *loadingLoopView = [[SYLoadingLoopView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, 64, 100, 100)];
    [self.view addSubview:loadingLoopView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [loadingLoopView endAnimation];
    });
}
-(void)initEmitter
{
    self.view.backgroundColor = [UIColor redColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 80, 40, 300);
    [btn setTitle:@"下一个" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *emitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2+150, 100, 100)];
    emitterLabel.layer.masksToBounds = YES;
    emitterLabel.layer.cornerRadius = 50;
//    emitterLabel.text = @"bye";
    [self.view addSubview:emitterLabel];
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.contents = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    explosionCell.lifetime = 3;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 500;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    explosionCell.emissionLatitude = M_PI;
    explosionCell.emissionLongitude = 0;
    explosionCell.emissionRange = M_PI/4;
    explosionCell.color = CGColorCreateCopy([UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5].CGColor);
    explosionCell.redRange = 0.5;
    explosionCell.greenRange =  0.5;
    explosionCell.blueRange = 0.5;
    CAEmitterLayer *_explosionLayer = [CAEmitterLayer layer];
    _explosionLayer.name = @"emitterLayer";
    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
    _explosionLayer.emitterSize = CGSizeMake(100, 0);
    _explosionLayer.emitterCells = @[explosionCell];
    _explosionLayer.emitterPosition = CGPointMake(emitterLabel.bounds.size.width/2, emitterLabel.bounds.size.height/2);
    _explosionLayer.renderMode = kCAEmitterLayerAdditive;
    _explosionLayer.masksToBounds = NO;
    
    CAGradientLayer *_graLayer = [CAGradientLayer layer];
    _graLayer.opacity = 0.5;
    CGRect frame = emitterLabel.frame;
    frame.origin = CGPointZero;
    _graLayer.frame =frame;
    _graLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blackColor].CGColor];
    _graLayer.locations = @[@0.2,@0.3,@0.5];
    _graLayer.startPoint = CGPointMake(0, 0);
    _graLayer.endPoint = CGPointMake(1, 1);
//    _explosionLayer.birthRate = 6;
//    _explosionLayer.seed = 1366128504;
    [emitterLabel.layer addSublayer:_explosionLayer];
//    [emitterLabel.layer addSublayer:_graLayer];
    //1.获取图形上下文
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGMutablePathRef path=CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(self.view.bounds.size.width/2 -50, self.view.bounds.size.height/2-50, 100, 100));
   
       //2.b.3把圆的路径添加到图形上下文中
    CGContextAddPath(ctx, path);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    
//    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
//    
//    CGRect rectangle = CGRectMake(60,170,200,80);
//    
//    CGContextAddEllipseInRect(context, rectangle);
//    
//    CGContextStrokePath(context);
//    UIBezierPath* aPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 150)
//                                                         radius:75
//                                                     startAngle:0
//                                                       endAngle:DEGREES_TO_RADIANS(135)
//                                                      clockwise:YES];
//    
//    aPath.lineWidth = 20.0;
//    aPath.lineCapStyle = kCGLineCapRound;  //线条拐角
//    aPath.lineJoinStyle = kCGLineCapRound;  //终点处理
    
//    [aPath stroke];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path;
    animation.rotationMode = kCAAnimationRotateAutoReverse;
    animation.duration = 20;
    animation.speed = 10;
    animation.fillMode=kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [emitterLabel.layer addAnimation:rotationAnimation forKey:@"circle"];
    CFRelease(path);
//    CFRelease(ctx);

}
-(void)nextClicked:(UIButton *)btn
{
    EmitterSampleVC  *emitterSampleVC = [[EmitterSampleVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:emitterSampleVC];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
