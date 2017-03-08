//
//  ZXPickView.h
//  ZXPickerView
//
//  Created by Rocent on 2017/3/8.
//  Copyright © 2017年 Rocent. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXPickView;
@protocol ZXPickViewDelegate <NSObject>

- (void)ZXPickView:(ZXPickView *)pickView WithDoneBtn:(UIButton *)btn andResult:(NSString *)result;

@end

@interface ZXPickView : UIView

@property(nonatomic,weak)id<ZXPickViewDelegate> delegate;
/** array */
@property (nonatomic,strong) NSArray *array;
/** title */
@property (nonatomic,strong) NSString *title;

-(instancetype)initWithFrame:(CGRect)frame andPickerDataArray:(NSArray *)array;

@end
