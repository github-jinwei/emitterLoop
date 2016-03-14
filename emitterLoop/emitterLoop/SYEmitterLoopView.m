//
//  SYEmitterLoopView.m
//  emitterLoop
//
//  Created by Mac on 16/3/11.
//  Copyright © 2016年 shaiba. All rights reserved.
//

#import "SYEmitterLoopView.h"
typedef NS_OPTIONS(NSInteger, AnimationType){
    AnimationTypeNone = 0,
    AnimationTypeOne,
    AnimationTypeTwo,
    AnimationTypeThree,
};
#define LanPangZiDuration (5)
@interface SYEmitterLoopView ()
{
    CGPoint _centerPosition;
    AnimationType _animationType;
    UIBezierPath *headPath;
}
@end
@implementation SYEmitterLoopView

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
    self.backgroundColor = [UIColor redColor];
    _animationType = AnimationTypeOne;
//    UILabel *emitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-50, self.bounds.size.height/2-50, 100, 100)];
//    emitterLabel.layer.masksToBounds = YES;
//    emitterLabel.layer.cornerRadius = 50;
//    //    emitterLabel.text = @"bye";
//    [self addSubview:emitterLabel];
//    CAEmitterCell *explosionCell = [CAEmitterCell emitterCell];
//    explosionCell.name = @"explosion";
//    explosionCell.alphaRange = 0.20;
//    explosionCell.alphaSpeed = -1.0;
//    explosionCell.contents = (id)[UIImage imageNamed:@"Sparkle"].CGImage;
//    explosionCell.lifetime = 3;
//    explosionCell.lifetimeRange = 0.3;
//    explosionCell.birthRate = 100;
//    explosionCell.velocity = 40.00;
//    explosionCell.velocityRange = 10.00;
//    explosionCell.scale = 0.05;
//    explosionCell.scaleRange = 0.02;
//    explosionCell.emissionLatitude = 0;
//    explosionCell.emissionLongitude = -M_PI/2;
//    explosionCell.emissionRange = M_PI/8;
//    //    explosionCell.color = CGColorCreateCopy([UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5].CGColor);
//    //    explosionCell.redRange = 0.5;
//    //    explosionCell.greenRange =  0.5;
//    //    explosionCell.blueRange = 0.5;
//    CAEmitterLayer *_explosionLayer = [CAEmitterLayer layer];
//    _explosionLayer.name = @"emitterLayer";
//    _explosionLayer.emitterShape = kCAEmitterLayerCircle;
//    _explosionLayer.emitterMode = kCAEmitterLayerOutline;
//    _explosionLayer.emitterSize = CGSizeMake(100, 0);
//    _explosionLayer.emitterCells = @[explosionCell];
//    _explosionLayer.emitterPosition = CGPointMake(emitterLabel.bounds.size.width/2, emitterLabel.bounds.size.height/2);
//    _explosionLayer.renderMode = kCAEmitterLayerAdditive;
//    _explosionLayer.masksToBounds = NO;
    
//    CAGradientLayer *_graLayer = [CAGradientLayer layer];
//    _graLayer.opacity = 0.5;
//    CGRect frame = emitterLabel.frame;
//    frame.origin = CGPointZero;
//    _graLayer.frame =frame;
//    _graLayer.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blackColor].CGColor];
//    _graLayer.locations = @[@0.2,@0.3,@0.5];
//    _graLayer.startPoint = CGPointMake(0, 0);
//    _graLayer.endPoint = CGPointMake(1, 1);
//    //    _explosionLayer.birthRate = 6;
//    //    _explosionLayer.seed = 1366128504;
//    [emitterLabel.layer addSublayer:_explosionLayer];
    //    [emitterLabel.layer addSublayer:_graLayer];
    //1.获取图形上下文
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGMutablePathRef path=CGPathCreateMutable();
//    CGPathAddEllipseInRect(path, NULL, CGRectMake(self.bounds.size.width/2 -50, self.bounds.size.height/2-50, 100, 100));
//    
//    //2.b.3把圆的路径添加到图形上下文中
//    CGContextAddPath(ctx, path);
    
//    CGFloat arcCenterX = self.frame.size.width/2;
//    CGFloat arcCenterY = 80;
//    CGFloat delay = LanPangZiDuration;
    
    //线1
    CAShapeLayer *headLayer = [CAShapeLayer layer];
    headLayer.strokeColor = [UIColor purpleColor].CGColor;
    headLayer.fillColor = UIColor.clearColor.CGColor;
    headLayer.strokeEnd = 1;
    headLayer.lineWidth = 4.0;
    headLayer.lineDashPattern = @[@2,@3];
    CGFloat refreshRadius = self.frame.size.height/2 * 0.8;
    
//    ovalShapeLayer.path = UIBezierPath(ovalInRect: CGRect(
//                                                          x: frame.size.width/2 - refreshRadius,
//                                                          y: frame.size.height/2 - refreshRadius,
//                                                          width: 2 * refreshRadius,
//                                                          height: 2 * refreshRadius)
//                                       ).CGPath
    
//    layer.addSublayer(ovalShapeLayer)
    headPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width/2-refreshRadius, self.frame.size.height/2-refreshRadius, 2*refreshRadius, 2*refreshRadius) cornerRadius:refreshRadius];
    headLayer.path = headPath.CGPath;
    [self.layer addSublayer:headLayer];
    
    UIImage *image = [UIImage imageNamed:@"AirPlane"];
    CALayer *airplaneLayer = [[CALayer alloc] init];
    airplaneLayer.contents = @[image];
    airplaneLayer.frame = CGRectMake( self.frame.size.width/2 + refreshRadius, self.frame.size.height/2, image.size.width, image.size.height);
    airplaneLayer.opacity = 1;
    
    airplaneLayer.masksToBounds = NO;
    [self.layer addSublayer:airplaneLayer];
    
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.fromValue = @(-0.5);
    strokeStartAnimation.toValue = @(1.0);
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0);
    strokeEndAnimation.toValue = @(1);
    
    CAAnimationGroup *strokeAnimationGroup = [CAAnimationGroup animation];
    strokeAnimationGroup.duration = 1.5;
    strokeAnimationGroup.repeatDuration = 10000;
    strokeAnimationGroup.animations = @[strokeStartAnimation, strokeEndAnimation];
    [headLayer addAnimation:strokeAnimationGroup forKey:@"storkeGroup"];

    CAKeyframeAnimation *flightAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    flightAnimation.path = headLayer.path;
    flightAnimation.calculationMode = kCAAnimationPaced;
    
    CABasicAnimation *airplaneOrientationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    airplaneOrientationAnimation.fromValue = 0;
    airplaneOrientationAnimation.toValue = @(2*M_PI);
    CAAnimationGroup *flightAnimationGroup = [CAAnimationGroup animation];
    flightAnimationGroup.duration = 1.5;
    flightAnimationGroup.repeatDuration = 10000;
    flightAnimationGroup.animations = @[flightAnimation, airplaneOrientationAnimation];
//    airplaneLayer.anchorPoint =
    [airplaneLayer addAnimation:flightAnimationGroup forKey:@"flightGroup"];
//    [self setLayer:headLayer path:headPath delay:delay*0];
}

//}





@end
