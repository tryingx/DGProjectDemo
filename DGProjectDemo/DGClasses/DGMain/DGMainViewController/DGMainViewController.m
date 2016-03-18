//
//  DGMainViewController.m
//  DGProjectDemo
//
//  Created by Gavin on 16/3/17.
//  Copyright © 2016年 com.tryingx. All rights reserved.
//

#import "DGMainViewController.h"
#import "AFNetworkManager.h"

@interface DGMainViewController () <UITabBarControllerDelegate>

@end

@implementation DGMainViewController

#pragma mark - Life Circle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = @"http://www.baidu.com";
    requestGET(url, nil, ^(NSError *error) {
        NSLog(@"%@",[error description]);
    }, ^(id dict) {
        NSLog(@"%@",dict);
    });
    [self loadDefaultSetting];
}

/** Load the default UI elements And prepare some datas needed. */
- (void)loadDefaultSetting {
    NSArray *controllerProperties = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"controllers" ofType:@"plist"]];
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:controllerProperties.count];
    for (NSDictionary *dicData in controllerProperties) {
        Class cls = NSClassFromString(dicData[@"controller"]);
        UIViewController *viewController = [cls new];
        viewController.title = dicData[@"title"];
        viewController.tabBarItem.image = [UIImage imageNamed:dicData[@"tab_icon"]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:dicData[@"tab_icon_sl"]];
        [controllers addObject:viewController];
    }
    self.delegate = self;
    self.viewControllers = [controllers copy];
    [self syncNavgationItemsFromViewController:controllers.firstObject];
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self syncNavgationItemsFromViewController:viewController];
}

/** Sync TabBar's NavigationItem */
- (void)syncNavgationItemsFromViewController:(UIViewController *)viewController {
    self.navigationItem.leftBarButtonItem = viewController.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = viewController.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = viewController.navigationItem.rightBarButtonItems;
    self.navigationItem.titleView = viewController.navigationItem.titleView;
    self.navigationItem.title = viewController.navigationItem.title;
}

- (void)dealloc {
    // RELEASE OBJECTS TO FREE THE MEMORIES HERE!
    __unsafe_unretained typeof(self) selfUnsafe = self;
    DGLog(@"🌜A instance of type %@ was DESTROYED!🌛", NSStringFromClass([selfUnsafe class]));
}

@end

