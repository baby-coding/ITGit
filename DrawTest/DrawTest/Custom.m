//
//  Custom.m
//  DrawTest
//
//  Created by Mac on 16/3/14.
//  Copyright © 2016年 YB. All rights reserved.
//

#import "Custom.h"

@interface Custom ()

@property(nonatomic,retain)NSMutableArray *points;

@end

@implementation Custom


- (NSMutableArray *)points{
    if (!_points) {
        _points = [NSMutableArray array];
    }
    return _points;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
     CGContextRef ref = UIGraphicsGetCurrentContext();

    for (int i = 0; i<self.points.count; i++) {
        CGPoint point = [self.points[i]CGPointValue];
        if ( 0== i) {
            CGContextMoveToPoint(ref, point.x, point.y);
        }else{
            CGContextAddLineToPoint(ref, point.x, point.y);
        }

    }
    CGContextSetLineWidth(ref, 15.0);
    CGContextStrokePath(ref);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint beginPoint = [touch locationInView:touch.view];
    [self.points addObject:[NSValue valueWithCGPoint:beginPoint]];
    
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint movePoint = [touch locationInView:touch.view];
    [self.points addObject:[NSValue valueWithCGPoint:movePoint]];
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:touch.view];
    [self.points addObject:[NSValue valueWithCGPoint:endPoint]];

    [self.points replaceObjectAtIndex:2 withObject:[NSValue valueWithCGPoint:endPoint]];
    [self setNeedsDisplay];
}

@end
