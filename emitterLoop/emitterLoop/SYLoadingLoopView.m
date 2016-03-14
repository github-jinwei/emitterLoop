//
//  SYLoadingLoopView.m
//  emitterLoop
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "SYLoadingLoopView.h"

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
-(void)setUp
{
    [self setImage:[UIImage imageNamed:@"index"]];
    self.backgroundColor =  [UIColor blueColor];
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
    CAEmitterLayer *airplaneLayer = [[CAEmitterLayer alloc] init];
    airplaneLayer.contents = @[image];
    airplaneLayer.frame = CGRectMake( self.frame.size.width/2 + refreshRadius, self.frame.size.height/2 -refreshRadius/2, image.size.width, image.size.height);
    airplaneLayer.opacity = 1;
    airplaneLayer.name = @"emitterLayer";
    airplaneLayer.emitterShape = kCAEmitterLayerCircle;
    airplaneLayer.emitterMode = kCAEmitterLayerOutline;
    airplaneLayer.emitterSize = CGSizeMake(0, 0);
    airplaneLayer.emitterCells = @[explosionCell];
    //    airplaneLayer.emitterPosition = CGPointMake(self.frame.size.width/2 + self.frame.size.height/2 * 0.8, self.frame.size.height/2);
    airplaneLayer.renderMode = kCAEmitterLayerOldestFirst;
    airplaneLayer.masksToBounds = NO;
    [self.layer addSublayer:airplaneLayer];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 10.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 100000;
    [self.layer addAnimation:rotationAnimation forKey:@"self"];

//    [airplaneLayer addAnimation:rotationAnimation forKey:@"air"];
//    UIImage *layerImage = [UIImage imageNamed:@"index"];
//    self.layer.contents =@[layerImage];
    UIBezierPath *headPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width/2-refreshRadius, self.frame.size.height/2-refreshRadius, 2*refreshRadius, 2*refreshRadius) cornerRadius:refreshRadius];
    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.path = headPath.CGPath;
    flightAnimation.calculationMode = kCAAnimationPaced;
    flightAnimation.duration = 10.0;
    flightAnimation.repeatCount = 100000;
//    [airplaneLayer addAnimation:flightAnimation forKey:@"air"];
}
@end
