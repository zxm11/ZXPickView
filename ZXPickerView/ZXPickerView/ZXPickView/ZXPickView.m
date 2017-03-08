//
//  ZXPickView.m
//  ZXPickerView
//
//  Created by Rocent on 2017/3/8.
//  Copyright © 2017年 Rocent. All rights reserved.
//

#define ZXRect(x, y, w, h)  CGRectMake([UIScreen mainScreen].bounds.size.width * x, [UIScreen mainScreen].bounds.size.height * y, [UIScreen mainScreen].bounds.size.width * w,  [UIScreen mainScreen].bounds.size.height * h)
#define font(f) [UIFont systemFontOfSize:[UIScreen mainScreen].bounds.size.width * f / 375]
#define ZXMainBackColor [UIColor colorWithRed:240/255.0 green:239/255.0 blue:245/255.0 alpha:1]

#import "ZXPickView.h"

@interface ZXPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
/** view */
@property (nonatomic,strong) UIButton *topView;
/** button */
@property (nonatomic,strong) UIButton *doneBtn;
/** button */
@property (nonatomic,strong) UIButton *cancelBtn;
/** pickerView */
@property (nonatomic,strong) UIPickerView *pickerView;
/** srting */
@property (nonatomic,strong) NSString *result;

@property (nonatomic,strong) UIView *bgView;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZXPickView
-(instancetype)initWithFrame:(CGRect)frame andPickerDataArray:(NSArray *)array
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.array = array;
        [self createLocationPickViewUI];
        
    }
    return self;
}

-(void)createLocationPickViewUI
{
    self.topView = [[UIButton alloc] initWithFrame:ZXRect(0, 0, 1, 417/667)];
    [self.topView addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    self.topView.backgroundColor = [UIColor blackColor];
    self.topView.alpha = 0.3;
    [self addSubview:self.topView];
    
    self.bgView = [[UIView alloc] initWithFrame:ZXRect(0, 417/667, 1, 250/667)];
    [self addSubview:_bgView];
//    _bgView.frame = CGRectMake(0, screenHeight * 417/667, screenWidth, screenHeight * 250/667);
    self.backgroundColor = [UIColor clearColor];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:ZXRect(50/375, 0, 275/375, 50/667)];
    self.titleLabel.userInteractionEnabled = YES;
    [self.bgView addSubview:self.titleLabel];
    self.titleLabel.backgroundColor = [UIColor blueColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.text = @"请选择位置";
    self.titleLabel.font = font(18);
    

    self.doneBtn = [[UIButton alloc] init];
    [self.doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.doneBtn.titleLabel.font = font(18);
    [self.doneBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.doneBtn.backgroundColor = [UIColor blueColor];
    [self.bgView addSubview:self.doneBtn];
    [self.doneBtn setFrame:ZXRect(324/375, 0/667, 51/375, 50/667)];
    [self.doneBtn addTarget:self action:@selector(doneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
   
    self.cancelBtn = [[UIButton alloc] init];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = font(18);
    [self.cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = [UIColor blueColor];
    [self.bgView addSubview:self.cancelBtn];
    [self.cancelBtn setFrame:ZXRect(0, 0/667, 50/375, 50/667)];
    [self.cancelBtn addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    
    self.pickerView = [[UIPickerView alloc]init];
    [self.bgView addSubview:self.pickerView];
    [self.pickerView setFrame:ZXRect(0, 50/667, 1, 200/667)];
    [self.pickerView setBackgroundColor:ZXMainBackColor];
    [self.pickerView setDelegate:self];
    [self.pickerView setDataSource:self];
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
    
}


- (void)doneBtnClick:(UIButton *)button{
    //当没有选择直接点击完成按钮的情况下:默认选择第0个
    if (!self.result) {
        self.result = self.array[0];
    }
    if ([self.delegate respondsToSelector:@selector(ZXPickView:WithDoneBtn:andResult:)]){
        [self.delegate ZXPickView:self WithDoneBtn:button andResult:self.result];
    }
    [self quit];
    
}

-(void)quit
{
    [self removeFromSuperview];
}


// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component.
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.array count];
}

#pragma mark - 代理
// 返回第component列第row行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.array[row];
}

// 选中第component第row的时候调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.result = self.array[row];
}
//重置pickerView的字体大小
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        // Setup label properties - frame, font, colors etc
        //adjustsFontSizeToFitWidth property to YES
        pickerLabel.minimumScaleFactor = 0.7;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont systemFontOfSize:17]];
    }
    // Fill the label text here
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
