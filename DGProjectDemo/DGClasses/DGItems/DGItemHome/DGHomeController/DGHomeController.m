//
//  DGHomeController.m
//  DGProjectDemo
//
//  Created by Gavin on 16/3/18.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DGHomeController.h"

@interface DGHomeController ()

@end

@implementation DGHomeController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

/** Load the default UI elements And prepare some datas needed. */
- (void)loadDefaultSetting {
    self.title = @"home";
    self.view.backgroundColor = DGColorRandom;
}

- (void)dealloc {
    // RELEASE OBJECTS TO FREE THE MEMORIES HERE!
    __unsafe_unretained typeof(self) selfUnsafe = self;
    DGLog(@"🌜A instance of type %@ was DESTROYED!🌛", NSStringFromClass([selfUnsafe class]));
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
