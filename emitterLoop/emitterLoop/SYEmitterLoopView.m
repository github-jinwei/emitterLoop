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
    _animationType = AnimationTypeOne;
    UILabel *emitterLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-50, self.bounds.size.height/2-50, 100, 100)];
    emitterLabel.layer.masksToBounds = YES;
    emitterLabel.layer.cornerRadius = 50;
    //    emitterLabel.text = @"bye";
    [self addSubview:emitterLabel];
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
    explosionCell.scale = 0.05;
    explosionCell.scaleRange = 0.02;
    explosionCell.emissionLatitude = M_PI;
    explosionCell.emissionLongitude = 0;
    explosionCell.emissionRange = M_PI/4;
    //    explosionCell.color = CGColorCreateCopy([UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:.5].CGColor);
    //    explosionCell.redRange = 0.5;
    //    explosionCell.greenRange =  0.5;
    //    explosionCell.blueRange = 0.5;
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
    CGPathAddEllipseInRect(path, NULL, CGRectMake(self.bounds.size.width/2 -50, self.bounds.size.height/2-50, 100, 100));
    
    //2.b.3把圆的路径添加到图形上下文中
    CGContextAddPath(ctx, path);
    
//    CGFloat arcCenterX = self.frame.size.width/2;
//    CGFloat arcCenterY = 80;
    CGFloat delay = LanPangZiDuration;
    
    //头
    CAShapeLayer *headLayer = [CAShapeLayer layer];
    headPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.frame.size.width/2-80, 0, 160, 160) cornerRadius:80];
    [self setLayer:headLayer path:headPath delay:delay*0];
}
- (void)setLayerColor:(CAShapeLayer *)layer color:(UIColor *)color delay:(CFTimeInterval)delay
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        layer.fillColor = color.CGColor;
    });
}

- (void)setLayer:(CAShapeLayer *)layer path:(UIBezierPath *)path delay:(CFTimeInterval)delay
{
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor purpleColor].CGColor;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.layer addSublayer:layer];
        [weakSelf addAnimation:layer duration:LanPangZiDuration];
    });
}

//- (void)showHello
//{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width/2+90, 0, 70, 30)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor colorWithRed:21/255.0 green:159/255.0 blue:237/255.0 alpha:1];
//    label.text = @"Hello";
//    label.font = [UIFont fontWithName:@"Chalkduster" size:20];
//    [self addSubview:label];
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    animation.fromValue = @(0);
//    animation.toValue = @(1);
//    animation.duration = 0.5f;
//    [label.layer addAnimation:animation forKey:nil];
//}



- (void)addAnimation:(CAShapeLayer *)layer duration:(CFTimeInterval)duration
{
    switch (_animationType) {
        case AnimationTypeNone:
            break;
            
        case AnimationTypeOne:
            [self addAnimationOneOnLayer:layer duration:duration];
            break;
            
        case AnimationTypeTwo:
            [self addAnimationTwoOnLayer:layer duration:duration];
            break;
            
        case AnimationTypeThree:
            [self addAnimationThreeOnLayer:layer duration:duration];
            break;
        default:
            break;
    }
}

#pragma mark - 利用layer的 strokeEnd、strokeStart和lineWidth 属性添加CA动画
- (void)addAnimationOneOnLayer:(CAShapeLayer *)layer duration:(CFTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.duration = duration;
    CAKeyframeAnimation *animation2 = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation2.path = headPath.CGPath;
    animation2.rotationMode = kCAAnimationRotateAuto;
    animation2.duration = duration;
    [layer addAnimation:animation forKey:nil];
    [layer addAnimation:animation2 forKey:nil];
}

- (void)addAnimationTwoOnLayer:(CAShapeLayer *)layer duration:(CFTimeInterval)duration
{
    //    layer.strokeStart = 0.5;
    //    layer.strokeEnd = 0.5;
    
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    animation1.fromValue = @(0.5);
    animation1.toValue = @(0);
    animation1.duration = duration;
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation2.fromValue = @(0.5);
    animation2.toValue = @(1);
    animation2.duration = duration;
    
    [layer addAnimation:animation1 forKey:nil];
    [layer addAnimation:animation2 forKey:nil];
}

- (void)addAnimationThreeOnLayer:(CAShapeLayer *)layer duration:(CFTimeInterval)duration
{
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation1.fromValue = @(0);
    animation1.toValue = @(1);
    animation1.duration = duration;
    
    [layer addAnimation:animation1 forKey:nil];
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
    animation2.fromValue = @(1);
    animation2.toValue = @(8);
    animation2.duration = duration;
    
    [layer addAnimation:animation1 forKey:nil];
    [layer addAnimation:animation2 forKey:nil];
}

- (void)clearDisplayView
{
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
}


@end
