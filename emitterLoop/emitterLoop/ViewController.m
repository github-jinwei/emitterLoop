//
//  ViewController.m
//  emitterLoop
//
//  Created by Mac on 16/3/10.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "ViewController.h"
#define pi 3.14159265359
#define   DEGREES_TO_RADIANS(degrees)  ((pi * degrees)/ 180)
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initEmitter];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)initEmitter
{
    UILabel *emitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2-50, self.view.bounds.size.height/2-50, 100, 100)];
//    emitterLabel.text = @"bye";
    [self.view addSubview:emitterLabel];
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.contents = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
    explosionCell.lifetime = 3;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 500;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.scale = 0.1;
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
    
//    _explosionLayer.birthRate = 6;
//    _explosionLayer.seed = 1366128504;
    [emitterLabel.layer addSublayer:_explosionLayer];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
