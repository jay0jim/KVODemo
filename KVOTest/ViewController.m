//
//  ViewController.m
//  KVOTest
//
//  Created by Tony on 15/8/2.
//  Copyright (c) 2015年 Tony. All rights reserved.
//

#import "ViewController.h"
#import "StockData.h"

@interface ViewController ()

@property (strong, nonatomic) StockData *stock01;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *changeButton;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _stock01 = [[StockData alloc] init];
    //利用KVO设置属性的值
    [_stock01 setValue:@"FirstStock" forKey:@"name"];
    [_stock01 setValue:@"10.0" forKey:@"price"];
    [_stock01 addObserver:self forKeyPath:@"price" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
//    NSLog(@"%@---%f", _stock01.name, _stock01.price);
    //初始化UI信息
    _priceLabel.text = [NSString stringWithFormat:@"%.2f", [_stock01 price]];
    
    [_countTextField addTarget:self action:@selector(updateUI) forControlEvents:UIControlEventEditingChanged];
    
}

- (IBAction)changeButtonPressed:(id)sender {
    float newPrice;
    int sign = arc4random() % 2;
    if (sign == 0) {
        newPrice = random() % 400 / 100.0;
    } else {
        newPrice = random() % 400 / 100.0 * (-1);
    }
    newPrice += _stock01.price;
    
    [_stock01 setValue:[NSString stringWithFormat:@"%.2f", newPrice] forKey:@"price"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"price"]) {
        _priceLabel.text = [NSString stringWithFormat:@"%.2f", [_stock01 price]];
    }
}

- (BOOL)isValidText:(NSString *)text {
    return text.length > 3;
}

- (void)updateUI {
    BOOL isValid = [self isValidText:_countTextField.text];
    _countTextField.backgroundColor = isValid ? [UIColor clearColor] : [UIColor redColor];
}

@end




















