//
//  DGNavigationController.m
//  DGProjectDemo
//
//  Created by Gavin on 16/3/17.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DGNavigationController.h"

@interface DGNavigationController ()

@end

@implementation DGNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

+ (void)initialize {
    /*! --- CONFIGURE THE VARIETY BAR'S PROPERTIES ---
     UINavigationBar *navBar = [UINavigationBar appearance];
     [navBar setBarTintColor:DGMainNavColor];
     [navBar setTintColor:[UIColor whiteColor]];
     [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
     
     UIBarButtonItem *barButtonItem = [UIBarButtonItem appearanceWhenContainedIn:[DGNavigationController class], nil];
     [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]} forState:UIControlStateNormal];
     
     [barButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]} forState:UIControlStateDisabled];
     */
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    [super pushViewController:viewController animated:animated];
}

- (void)backAction {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
