//
//  ViewController.m
//  ZXPickerView
//
//  Created by Rocent on 2017/3/8.
//  Copyright © 2017年 Rocent. All rights reserved.
//
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#import "ViewController.h"
#import "ZXPickView.h"

@interface ViewController ()<ZXPickViewDelegate>

@property(nonatomic,copy)NSArray * nameArray;

@property (weak, nonatomic) IBOutlet UILabel *labelOfTitle;

@end

@implementation ViewController

- (NSArray *)nameArray
{
    if (!_nameArray){
        _nameArray = [NSArray arrayWithObjects:@"测试测试",@"部件类型",@"部件代码部件代码部件代码部件代码部件代码部件代码",@"部件状态",@"材质",@"规格",@"主管部门",@"权属部门",@"养护部门",@"哦哦哦哦哦哦哦哦哦", nil];
    }
    return _nameArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)show:(UIButton *)sender {
    NSArray * nameArr = [NSArray arrayWithObjects:@"测试测试",@"部件类型",@"部件代码部件代码部件代码部件代码部件代码部件代码",@"部件状态",@"材质",@"规格",@"主管部门",@"权属部门",@"养护部门",@"哦哦哦哦哦哦哦哦哦", nil];
    [self createPickViewWithAray:nameArr];
}

//创建LocationPickView
- (void)createPickViewWithAray:(NSArray *)arr{
    ZXPickView * locaPick = [[ZXPickView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) andPickerDataArray:arr];
    locaPick.delegate = self;
    [self.view addSubview:locaPick];
}

#pragma mark - ZXPickViewDelegate代理

- (void)ZXPickView:(ZXPickView *)pickView WithDoneBtn:(UIButton *)btn andResult:(NSString *)result
{
    self.labelOfTitle.text = result;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
