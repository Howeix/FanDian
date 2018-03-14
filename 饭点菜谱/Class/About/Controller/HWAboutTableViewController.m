//
//  HWAboutTableViewController.m
//  饭点菜谱
//
//  Created by 黄炜 on 2018/3/12.
//  Copyright © 2018年 黄炜. All rights reserved.
//

#import "HWAboutTableViewController.h"
#import <MessageUI/MessageUI.h>
#import <StoreKit/StoreKit.h>
#import <Availability.h>
#import <SVProgressHUD.h>
@interface HWAboutTableViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation HWAboutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.bounces = NO;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        
        //反馈
        //判断此iphone的邮箱是否打开
        if ([MFMailComposeViewController canSendMail]) {
            //写邮件界面
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            //邮件的标题
            [picker setSubject:@"Enter your subject!"];
            
            
            //接收用户发送的邮件的邮箱
            NSArray *toRecipients = [NSArray arrayWithObject:@"howeix@yeah.net"];
            [picker setToRecipients:toRecipients];
            
            [self presentViewController:picker animated:YES completion:nil];
        }else{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在您的设置中打开'邮件'!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alertView show];
//            [alertView release];
            
        }
    }else{
        
        if (__IPHONE_10_3) {
            [SKStoreReviewController requestReview];
        }else{
            [SVProgressHUD showErrorWithStatus:@"版本不支持app内部评论"];
        }
        
        
        
    }
}


//邮箱的协议方法，当点击发送或者取消时调用：
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
