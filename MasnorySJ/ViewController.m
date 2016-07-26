//
//  ViewController.m
//  MasnorySJ
//
//  Created by SJ on 16/7/14.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define scale kScreenWidth/320.00


@interface ViewController ()
{
    float width;
    float height;
}
@property(nonatomic,strong)UITextField *text1;
@property(nonatomic,strong)UITextField *text2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self createView];
    
}
-(void)createView{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 100, 45, 30)];
    label1.text = @"长";
    [self.view addSubview:label1];
    
    _text1 = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 120, 30)];
    _text1.font = [UIFont fontWithName:@"Arial" size:11];
    _text1.placeholder = @"请输入矩形的长";
    _text1.borderStyle = UITextBorderStyleRoundedRect;
    _text1.keyboardType = UIKeyboardTypeNumberPad;
    _text1.inputAccessoryView = [self addToolbar];
    [self.view addSubview:_text1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(50, 200, 45, 30)];
    label2.text = @"高";
    [self.view addSubview:label2];
    
    _text2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 120, 30)];
    _text2.font = [UIFont fontWithName:@"Arial" size:11];
    _text2.placeholder = @"请输入矩形的宽";
    _text2.borderStyle = UITextBorderStyleRoundedRect;
    _text2.keyboardType = UIKeyboardTypeNumberPad;
    _text2.inputAccessoryView = [self addToolbar];
    [self.view addSubview:_text2];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(250, 250, 50, 30)];
    [btn setTitle:@"创建" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderWidth = 2;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(getWidthHeight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: btn];
    
}
//获取用户输入的长 宽
-(void)getWidthHeight:(id)sender{
    width = [_text1.text floatValue];
    height = [_text2.text floatValue];
    NSLog(@"width:%.1f height:%.1f",width,height);
    [self createLabelWithWidth:width height:height];
    
    
}

-(void)createLabelWithWidth:(float)width height:(float)height{
    UIView *thisView = [[UIView alloc]init];
    thisView.backgroundColor = [UIColor redColor];
    [self.view addSubview:thisView];
    [thisView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    NSLog(@"%f",(kScreenHeight-20)/height);
    int x =(int)kScreenWidth/(int)(4+width);
    int count = ((int)kScreenWidth/(int)(4+width)) *((int)(kScreenHeight-20)/(int)height);
    int k = -1;
    float offset = 0;
    int y = 1;
    for(int i = 0 ; i < count; i++){
        UILabel *label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor yellowColor];
        [thisView addSubview:label];
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [label setText:str];
        label.layer.borderWidth = 1;
        if(i/x>=y){
            offset++;
            k = 0;
            y++;
        }else{
            k++;
        }
        float newHeight = offset * height;
//        NSLog(@"%f",offset*height);
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(thisView.mas_left).offset(k*width+4*k);
            make.top.equalTo(thisView.mas_top).offset(newHeight);
            make.width.equalTo(@(width));
            make.height.offset(height);
            
            
        }];
    }

}

//虚拟键盘添加完成
- (UIToolbar *)addToolbar
{
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 35)];
    toolbar.tintColor = [UIColor blueColor];
    toolbar.backgroundColor = [UIColor grayColor];
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(textFieldDone)];
    toolbar.items = @[space, bar];
    return toolbar;
}
-(void)textFieldDone{
    [_text1 resignFirstResponder];
    [_text2 resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
