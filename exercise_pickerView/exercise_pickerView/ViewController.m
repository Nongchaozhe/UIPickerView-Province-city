//
//  ViewController.m
//  exercise_pickerView
//
//  Created by 弄潮者 on 15/8/4.
//  Copyright (c) 2015年 弄潮者. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSMutableArray *_dataArray;
    NSMutableArray *_citiesArray;
    UIPickerView *_pickView;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
    _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
    _pickView.dataSource = self;
    _pickView.delegate = self;
    [self.view addSubview:_pickView];
    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - loadData
- (void)loadData {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"city" ofType:@"plist"];
    _dataArray = [NSMutableArray arrayWithContentsOfFile:path];
    
    _citiesArray = _dataArray[0][@"cities"];
}

#pragma mark - dataSource
//注意这里是几列的意思。我刚刚开始学得时候也在这里出错，没理解
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _dataArray.count;
    }else {
        return _citiesArray.count;
    }
}

#pragma mark - delegate
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 150;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 60;
}

//返回每行显示的内容
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [NSString stringWithFormat:@"%@",_dataArray[row][@"state"]];
    }else {
        return [NSString stringWithFormat:@"%@",_citiesArray[row]];
    }
}

//当改变省份时，重新加载第2列的数据，部分加载
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        _citiesArray = _dataArray[row][@"cities"];
        [_pickView reloadComponent:1];
    }
}

//补充说明~有时候我们需要显示的是view，若实现了一下方法，那么        @selector(pickerView:attributedTitleForRow:forComponent:)就不会调用了，因此如果选择器既有文字又有图片，可以选择文字区域返回UILabel。（我的解决方案~可能有更好的~）
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
