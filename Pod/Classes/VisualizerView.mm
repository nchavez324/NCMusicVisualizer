//
//  VisualizerView.m
//  iPodVisualizer
//
//  Created by Xinrong Guo on 13-3-30.
//  Copyright (c) 2013 Xinrong Guo. All rights reserved.
//

#import "VisualizerView.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "MeterTable.h"
#import "NCToolBelt.h"

@implementation VisualizerView {
    CAEmitterLayer *emitterLayer;
    MeterTable meterTable;
}

+ (Class)layerClass {
    return [CAEmitterLayer class];
}

+ (UIColor *)defaultColor {
    
    return [UIColor colorWithRed:0.0f green:137.0/255.0 blue:1.0f alpha:0.8f];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    return [self initWithFrame:frame color:[VisualizerView defaultColor]];
}

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        emitterLayer = (CAEmitterLayer *)self.layer;
        
        CGFloat width = MAX(frame.size.width, frame.size.height);
        CGFloat height = MIN(frame.size.width, frame.size.height);
        emitterLayer.emitterPosition = CGPointMake(width/2, height/2);
        emitterLayer.emitterSize = CGSizeMake(width-80, 60);
        emitterLayer.emitterShape = kCAEmitterLayerRectangle;
        emitterLayer.renderMode = kCAEmitterLayerAdditive;
        
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name = @"cell";
        
        CAEmitterCell *childCell = [CAEmitterCell emitterCell];
        childCell.name = @"childCell";
        childCell.lifetime = 1.0f / 60.0f;
        childCell.birthRate = 60.0f;
        childCell.velocity = 0.0f;
        
        NSString *imagePath = [[NCToolBelt sharedInstance].internalBundle pathForResource:@"particleTexture" ofType:@"png"];
        
        UIImage *p = [UIImage imageWithContentsOfFile:imagePath];
        childCell.contents = (id)p.CGImage;
        
        cell.emitterCells = @[childCell];
        
        cell.color = [color CGColor];
        cell.redRange = 0.46f;
        cell.greenRange = 0.49f;
        cell.blueRange = 0.67f;
        cell.alphaRange = 0.55f;
        
        cell.redSpeed = 0.11f;
        cell.greenSpeed = 0.07f;
        cell.blueSpeed = -0.25f;
        cell.alphaSpeed = 0.15f;
        
        cell.scale = 0.5f;
        cell.scaleRange = 0.5f;
        
        cell.lifetime = 1.0f;
        cell.lifetimeRange = .25f;
        cell.birthRate = 80;
        
        cell.velocity = 100.0f;
        cell.velocityRange = 300.0f;
        cell.emissionRange = M_PI * 2;
        
        emitterLayer.emitterCells = @[cell];
        
        CADisplayLink *dpLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
        [dpLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)update {
    float scale = 0.5;
    if(self.dataSource && [self.dataSource visualizerViewIsPlaying:self]) {
        
        int channels = 2;
        
        float power = 0.0f;
        
        for (int i = 0; i < channels; i++) {
            float avP = [self.dataSource visualizerView:self averagePowerInDecibelsForChannel:i];
            power += avP;
        }
        
        power /= channels;
        
        float level = meterTable.ValueAt(power);
        scale = 5 * level;
    }
    
    [emitterLayer setValue:@(scale) forKeyPath:@"emitterCells.cell.emitterCells.childCell.scale"];
}

@end