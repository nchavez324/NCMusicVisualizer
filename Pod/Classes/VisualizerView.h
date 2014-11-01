//
//  VisualizerView.h
//  iPodVisualizer
//
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class JBAudioManager, VisualizerView;

@protocol VisualizerViewDataSource <NSObject>

- (BOOL)visualizerViewIsPlaying:(VisualizerView *)v;

- (float)visualizerView:(VisualizerView *)v averagePowerInDecibelsForChannel:(NSUInteger)channelNumber;

@end

@interface VisualizerView : UIView

- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color;

@property (weak, nonatomic) id<VisualizerViewDataSource> dataSource;

@end
