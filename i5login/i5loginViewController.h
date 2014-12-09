//
//  i5loginViewController.h
//  i5login
//
//  Created by Bernd Dongus on 29.01.13.
//  Copyright (c) 2013 Bernd Dongus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface i5loginViewController : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *Benutzer;
@property (retain, nonatomic) IBOutlet UITextField *Passwort;
- (IBAction)checkPW:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *Errorcode;
@property (retain, nonatomic) IBOutlet UILabel *MessageText;

@end
