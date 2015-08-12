//
//  BookRideViewController.m
//  Executer
//
//  Created by Kehinde Shittu on 8/7/15.
//  Copyright (c) 2015 Kehesjay. All rights reserved.
//

#import "BookRideViewController.h"
#import "MenuViewController.h"

@interface BookRideViewController ()
{
    CGRect executerLogoOldPosition;
    CGRect executerLogoNewPosition;
}
@end

@implementation BookRideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bookRide.layer.cornerRadius = 5;
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *tapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showUberTypes:)];
    UITapGestureRecognizer *bookTapAction = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bookRide:)];
    [self.chooseUberType addGestureRecognizer:tapAction];
    self.chooseUberType.layer.borderWidth = 1.0;
    self.chooseUberType.layer.borderColor = [UIColor blackColor].CGColor;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    self.locationTextField.delegate = self;
    self.destinationTextField.delegate = self;
    self.startTimeTextField.delegate = self;
    self.endTimeTextField.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:43.0/255 green:180.0/255 blue:192.0/255 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,
                                    [UIFont fontWithName:@"System" size:20.0], NSFontAttributeName,
                                    nil];
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    self.navigationItem.titleView.tintColor = [UIColor whiteColor];
}
-(void)showUberTypes:(UITapGestureRecognizer *)sender{
    NSLog(@"show uber types");
    MenuViewController *menuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    menuViewController.delegate = self;
    menuViewController.modalPresentationStyle = UIModalPresentationPopover;
    menuViewController.preferredContentSize = CGSizeMake(self.view.frame.size.height/4, self.view.frame.size.height/3);
    UIPopoverPresentationController * popController = menuViewController.popoverPresentationController;
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.delegate = self;
    popController.sourceView = self.chooseUberType;
    popController.sourceRect = CGRectMake(0,self.chooseUberType.layer.frame.size.height/2,1,1);
    [self presentViewController:menuViewController animated:YES completion:nil];
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)menuViewResponse:(MenuViewController *)controller didSelectOptions:(NSMutableArray*)options{
    NSLog(@"this cells were selected %@",options);
    NSString *labelText = @"";
    int i = 0;
    for (NSString *text in options){
        NSString *formatedText = text;
        if(i > 0){
            formatedText = [NSString stringWithFormat:@" -> %@",formatedText];
        }
      labelText =   [labelText stringByAppendingString:formatedText];
        i++;
    }
    self.selectedUberTypesLabel.text = [labelText  isEqual: @""] ? @"None":labelText;
    self.selectedUberTypesView.hidden = NO;
}


// text field delegates.
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"about to call delegate");

    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    return YES;
}



#pragma mark - Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification
{
    executerLogoOldPosition = CGRectMake(self.view.layer.frame.origin.x , self.view.layer.frame.origin.y, self.view.layer.frame.size.width, self.view.layer.frame.size.height);
    executerLogoNewPosition = CGRectMake(self.view.layer.frame.origin.x , self.view.layer.frame.origin.y -self.executerLogo.layer.frame.size.height, self.view.layer.frame.size.width, self.view.layer.frame.size.height);
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.view.frame = executerLogoNewPosition;
    } completion:nil];

}

- (void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
          self.view.frame = executerLogoOldPosition;
    } completion:nil];
    
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
