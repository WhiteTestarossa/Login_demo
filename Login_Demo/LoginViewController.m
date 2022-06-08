//
//  LoginViewController.m
//  Login_Demo
//
//  Created by Daniel Belokursky on 6/7/22.
//  Copyright © 2022 Daniel Belokursky. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *secureView;
@property (weak, nonatomic) IBOutlet UILabel *secureLabel;
@property (weak, nonatomic) IBOutlet UIButton *oneButton;
@property (weak, nonatomic) IBOutlet UIButton *twoButton;
@property (weak, nonatomic) IBOutlet UIButton *threeButton;

@property (strong, nonatomic) NSMutableString *code;

@end

@interface LoginViewController (TextFieldDelegateMethods)
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupTitle];
    [self setupTextFields];
    [self setupButton];
    [self setupSecureView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapAction)];
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

- (void)setupTitle {
    self.titleLabel.font = [UIFont boldSystemFontOfSize:36.0];
    self.titleLabel.textColor = UIColor.blackColor;
}

- (void)setupTextFields {
    self.loginTextField.keyboardType = UIKeyboardTypeASCIICapable;
    self.loginTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.loginTextField.placeholder = @"Login";
    self.loginTextField.text = @"";
    self.loginTextField.layer.borderWidth = 1.5;
    self.loginTextField.layer.cornerRadius = 5;
    self.loginTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.loginTextField.layer.borderColor = UIColor.blackColor.CGColor;
    self.loginTextField.delegate = self;
    
    self.passwordTextField.secureTextEntry = true;
    self.passwordTextField.placeholder = @"Password";
    self.passwordTextField.text = @"";
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordTextField.layer.borderColor = UIColor.blackColor.CGColor;
    self.passwordTextField.delegate = self;
    
    [self.loginTextField setUserInteractionEnabled:YES];
    [self.passwordTextField setUserInteractionEnabled:YES];
}

- (void)setupButton {
    self.loginButton.layer.borderColor = [UIColor colorWithRed: 0.43 green: 0.63 blue: 0.83 alpha: 1.00].CGColor;
    self.loginButton.layer.borderWidth = 2.0;
    self.loginButton.layer.cornerRadius = 10;
    [self.loginButton setUserInteractionEnabled:YES];
    self.loginButton.layer.opacity = 1;
    
    [self.loginButton setTitle:@"Authorize" forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = [UIFont systemFontOfSize:20.0 weight: UIFontWeightSemibold];
    [self.loginButton setTitleColor: [UIColor colorWithRed: 0.43 green: 0.63 blue: 0.83 alpha: 1.00] forState:UIControlStateNormal];
    
    UIImage *buttonImageNormal = [UIImage systemImageNamed:@"person"];
    [self.loginButton setImage:buttonImageNormal forState:UIControlStateNormal];
    
    UIImage *buttonImageHighlighted = [UIImage systemImageNamed:@"person.fill"];
    [self.loginButton setImage:buttonImageHighlighted forState:UIControlStateHighlighted];
    
    [self.loginButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)setupSecureView {
    [self.secureView setHidden:YES];
    self.code = [[NSMutableString alloc] initWithString:@""];
     self.secureView.layer.borderColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1.00].CGColor;
    [self.secureLabel setText:@"_"];

    [self.oneButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    [self.oneButton.layer setBorderColor: [UIColor systemBlueColor].CGColor];
    self.oneButton.layer.borderWidth = 1.5;
    self.oneButton.layer.cornerRadius = 25.0;
    [self.oneButton addTarget:self action:@selector(pressOneButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.twoButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    self.twoButton.layer.borderColor = [UIColor systemBlueColor].CGColor;
    self.twoButton.layer.borderWidth = 1.5;
    self.twoButton.layer.cornerRadius = 25.0;
    [self.twoButton addTarget:self action:@selector(pressTwoButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.threeButton.titleLabel setFont:[UIFont systemFontOfSize:24.0 weight:UIFontWeightSemibold]];
    self.threeButton.layer.borderColor = [UIColor systemBlueColor].CGColor;
    self.threeButton.layer.borderWidth = 1.5;
    self.threeButton.layer.cornerRadius = 25.0;
    [self.threeButton addTarget:self action:@selector(pressThreeButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)pressOneButton {
    if (self.code.length < 6) {
        [self.code appendString:@"1 "];
        
        [self updateCode];
    }
}
- (void)pressTwoButton {
    if (self.code.length < 6) {
        [self.code appendString:@"2 "];
        [self updateCode];
    }
}
- (void)pressThreeButton {
    if (self.code.length < 6) {
        [self.code appendString:@"3 "];
        [self updateCode];
    }
}

- (void)updateCode {
    
    if (self.code.length <= 6) {
        [self.secureLabel setText:self.code];
          self.secureView.layer.borderColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1.00].CGColor;
    }
    
    if (self.code.length == 6) {
        NSString *code = [self.code substringToIndex:[self.code length] - 1];
        if ([code isEqualToString:@"1 3 2"]) {
            self.secureView.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
            self.secureView.layer.borderWidth = 2;
            self.secureView.layer.cornerRadius = 10;
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfuly authorized!" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
                [self setupTitle];
                [self setupTextFields];
                [self setupButton];
                [self setupSecureView];
            }];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
            
        } else if (![code isEqualToString:@"1 3 2"]) {
            self.secureView.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
            self.secureView.layer.borderWidth = 2;
            self.secureView.layer.cornerRadius = 10;
            [self.secureLabel setText:@"_"];
            self.code = [NSMutableString stringWithString:@""];
        }
    }
    
}

- (void)buttonAction {
    
    if (![self.loginTextField.text isEqual:@"username"]) {
        self.loginTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
    } else {
        self.loginTextField.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
    }
    
    if (![self.passwordTextField.text isEqual:@"password"]) {
        self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
    } else {
        self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
    }
    
    if (([self.loginTextField.text  isEqual: @"username"] && [self.passwordTextField.text  isEqual: @"password"])) {
        
        self.loginTextField.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
        self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
        
        [self.view endEditing:true];
        
        [self.loginTextField setUserInteractionEnabled:NO];
        [self.passwordTextField setUserInteractionEnabled:NO];
        self.loginButton.layer.opacity = 0.5;
        [self.loginButton setUserInteractionEnabled: false];
        [self.secureView setHidden:NO];
    }
    
}


- (void)handleTapAction {
    [self.view endEditing:true];
}
@end

@implementation LoginViewController (TextFieldDelegateMethods)

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}

@end
