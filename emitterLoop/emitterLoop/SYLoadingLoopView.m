//
//  SYLoadingLoopView.m
//  emitterLoop
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "SYLoadingLoopView.h"
@interface SYLoadingLoopView()
{
    CABasicAnimation* rotationAnimation;
}
@property (nonatomic, strong)CAEmitterLayer *airplaneLayer;
@end
@implementation SYLoadingLoopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)init
{
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}
-(void)viewInitialize
{
    //默认初始化属性值
    self.viewStyle = SYLoadingLoopViewStyleClockWise;
    self.roundDuration = 5;
}
-(void)setUp
{
    //默认初始化属性值
    self.viewStyle = SYLoadingLoopViewStyleClockWise;
    self.roundDuration = 5;
    self.isDefaultEndAnimation = YES;
    [self setImage:[UIImage imageNamed:@"index"]];
    self.backgroundColor =  [UIColor clearColor];
    self.layer.cornerRadius = self.frame.size.height/2;
    self.layer.masksToBounds = YES;
    CGFloat refreshRadius = self.frame.size.height/2 * 0.4;
    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
    explosionCell.name = @"explosion";
    explosionCell.alphaRange = 0.20;
    explosionCell.alphaSpeed = -1.0;
    explosionCell.contents = (id)[UIImage imageNamed:@"flake1"].CGImage;
    explosionCell.lifetime = 3;
    explosionCell.lifetimeRange = 0.3;
    explosionCell.birthRate = 100;
    explosionCell.velocity = 40.00;
    explosionCell.velocityRange = 10.00;
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    explosionCell.emissionLatitude = 0;
    explosionCell.emissionLongitude = -M_PI/2;
    explosionCell.emissionRange = M_PI/8;
    UIImage *image = [UIImage imageNamed:@"flake1"];
    self.airplaneLayer = [[CAEmitterLayer alloc] init];
    self.airplaneLayer.contents = @[image];
    self.airplaneLayer.frame = CGRectMake( self.frame.size.width/2 + refreshRadius, self.frame.size.height/2 -refreshRadius/2, image.size.width, image.size.height);
    self.airplaneLayer.opacity = 1;
    self.airplaneLayer.name = @"emitterLayer";
    self.airplaneLayer.emitterShape = kCAEmitterLayerCircle;
    self.airplaneLayer.emitterMode = kCAEmitterLayerOutline;
    self.airplaneLayer.emitterSize = CGSizeMake(0, 0);
    self.airplaneLayer.emitterCells = @[explosionCell];
    
    self.airplaneLayer.renderMode = kCAEmitterLayerOldestFirst;
    self.airplaneLayer.masksToBounds = NO;
    [self.layer addSublayer:self.airplaneLayer];
    
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    if (self.viewStyle == SYLoadingLoopViewStyleClockWise) {
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    }else if (self.viewStyle == SYLoadingLoopViewStyleAntiClockWise)
    {
        rotationAnimation.toValue = [NSNumber numberWithFloat: -M_PI * 2.0 ];
    }
    
    rotationAnimation.duration = self.roundDuration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [self.layer addAnimation:rotationAnimation forKey:@"self"];

//    [airplaneLayer addAnimation:rotationAnimation forKey:@"air"];
//    UIImage *layerImage = [UIImage imageNamed:@"index"];
//    self.layer.contents =@[layerImage];
//    UIBezierPath *headPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width/2-refreshRadius, self.frame.size.height/2-refreshRadius, 2*refreshRadius, 2*refreshRadius) cornerRadius:refreshRadius];
//    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    flightAnimation.path = headPath.CGPath;
//    flightAnimation.calculationMode = kCAAnimationPaced;
//    flightAnimation.duration = 10.0;
//    flightAnimation.repeatCount = 100000;
//    [airplaneLayer addAnimation:flightAnimation forKey:@"air"];
}
//- (void)animate {
//    self.airplaneLayer.beginTime = CACurrentMediaTime();
//    [self.airplaneLayer setValue:@80 forKeyPath:@"emitterCells.charge.birthRate"];
//    [self performSelector:@selector(explode) withObject:nil afterDelay:0.2];
//}

-(void)endAnimation
{
    
    rotationAnimation.duration = 0;
    rotationAnimation.repeatCount = 0;
    if (self.isDefaultEndAnimation) {
        [self defaultEndAnimation];
    }
    if ([self.delegate respondsToSelector:@selector(endLoadingLoopViewAnimate)]) {
        [_delegate endLoadingLoopViewAnimate];
    }
}
-(void)defaultEndAnimation
{
    if (self.superview) {
        CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
        emitterCell.contents = (id)[UIImage imageNamed:@"snowflake1"].CGImage;
        
        emitterCell.birthRate = 150;
        emitterCell.lifetime = 3.5;
        
        emitterCell.yAcceleration = 70.0;
        emitterCell.xAcceleration = 10.0;
        emitterCell.velocity = 20.0;
        emitterCell.emissionLongitude = -M_PI;
        emitterCell.velocityRange = 200.0;
        emitterCell.emissionRange = M_PI_2;
        emitterCell.color = [UIColor colorWithRed:0.9 green: 1.0 blue: 1.0 alpha: 1.0].CGColor;
        emitterCell.redRange   = 0.1;
        emitterCell.greenRange = 0.1;
        emitterCell.blueRange  = 0.1;
        emitterCell.scale = 0.8;
        emitterCell.scaleRange = 0.8;
        emitterCell.scaleSpeed = -0.15;
        emitterCell.alphaRange = 0.75;
        emitterCell.alphaSpeed = -0.15;
        emitterCell.lifetimeRange = 1.0;
        
        CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
        explosionCell.name = @"fullScreen";
        
        explosionCell.birthRate = 50;
        explosionCell.lifetime = 2.5;
        explosionCell.lifetimeRange = 1.0;
        explosionCell.yAcceleration = 50;
        explosionCell.xAcceleration = 50;
        explosionCell.velocity = 80;
        explosionCell.emissionLongitude =M_PI;
        explosionCell.velocityRange = 20;
        explosionCell.emissionRange =M_PI_4;
        explosionCell.scale = 0.8;
        explosionCell.scaleRange = 0.2;
        explosionCell.scaleSpeed = -0.1;
        explosionCell.alphaRange = 0.35;
        explosionCell.alphaSpeed = -0.15;
        explosionCell.spin =M_PI;
        explosionCell.spinRange =M_PI;
        explosionCell.contents = (id)[UIImage imageNamed:@"flake2"].CGImage;
        //cell #3
        CAEmitterCell *cell3 = [CAEmitterCell emitterCell];
        cell3.contents = (id)[UIImage imageNamed:@"flake3"].CGImage;
        cell3.birthRate = 20;
        cell3.lifetime = 7.5;
        cell3.lifetimeRange = 1.0;
        cell3.yAcceleration = 20;
        cell3.xAcceleration = 10;
        cell3.velocity = 40;
        cell3.emissionLongitude = M_PI;
        cell3.velocityRange = 50;
        cell3.emissionRange = M_PI_4;
        cell3.scale = 0.8;
        cell3.scaleRange = 0.2;
        cell3.scaleSpeed = -0.05;
        cell3.alphaRange = 0.5;
        cell3.alphaSpeed = -0.05;
        
        UIImage *image = [UIImage imageNamed:@"flake1"];
        CAEmitterLayer *fullScreenLayer = [[CAEmitterLayer alloc] init];
        fullScreenLayer.contents = @[image];
        CGRect frame = CGRectMake(0, -70, self.superview.bounds.size.width, 50);
        fullScreenLayer.frame = frame;
        NSLog(@"self.superview.frame%@",@(self.superview.frame.size.height));
//        fullScreenLayer.opacity = 1;
        fullScreenLayer.name = @"fullScreenEmitterLayer";
        fullScreenLayer.emitterShape = kCAEmitterLayerRectangle;
        fullScreenLayer.emitterPosition = CGPointMake(frame.size.width/2, frame.size.height/2);
        fullScreenLayer.emitterSize = frame.size;
//        fullScreenLayer.emitterMode = kCAEmitterLayerSurface;
//        fullScreenLayer.emitterSize = CGSizeMake(25, 0);
        fullScreenLayer.emitterCells = @[emitterCell,explosionCell,cell3];
        
        fullScreenLayer.renderMode = kCAEmitterLayerOldestFirst;
        fullScreenLayer.masksToBounds = NO;
        [self.superview.layer addSublayer:fullScreenLayer];
    }
}
@end
