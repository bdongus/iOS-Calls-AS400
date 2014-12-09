//
//  i5loginViewController.m
//  i5login
//
//  Created by Bernd Dongus on 29.01.13.
//  Copyright (c) 2013 Bernd Dongus. All rights reserved.
//

#import "i5loginViewController.h"
#include "soapWEBLOGINSOAP11BindingProxy.h"
#import "gsoapios.h"
using namespace std;

typedef struct _ns2__weblogin RequestStruct;
typedef struct ns2__WEBLOGINInput RequestInput;
typedef struct _ns2__webloginResponse ResponseStruct;
typedef struct ns2__WEBLOGINResult RequestResult;

@interface i5loginViewController ()

@end

@implementation i5loginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_Benutzer release];
    [_Passwort release];
    [_Errorcode release];
    [_MessageText release];
    [super dealloc];
}
- (IBAction)checkPW:(id)sender {
	// file:///Users/bernd/gsoap-2.8/gsoap/ios_plugin/ios_plugin/docs/html/ios_0.html
	RequestStruct request;
	ResponseStruct response;
	RequestInput input;
	WEBLOGINSOAP11BindingProxy service;
	
	_Errorcode.text = @"";
	_MessageText.text = @"";
		
	std::string user = std::string((char *)[_Benutzer.text UTF8String]);
	std::string password = std::string((char *) [_Passwort.text UTF8String]);
	input._USCOREUSERID = &user;
	input._USCOREPASSWORD = &password;
	
	request.param0 = &input;
	
	// ----- register plugin for callbacks ------
	soap_register_plugin(&service, soap_ios);

	// Optional: timeout internal, the default is 60.0 seconds
	soap_ios_settimeoutinterval(&service, 30.0);
	
	// Optional: the default policy is NSURLRequestUseProtocolCachePolicy (0)
	soap_ios_setcachepolicy(&service, NSURLRequestReturnCacheDataElseLoad); // (2)
	
	int status = service.weblogin(&request, &response);
	
	if ( status == SOAP_OK) {
		if(response.return_ && response.return_->_USCOREMESSAGE) {
			_MessageText.text = [[NSString alloc] initWithUTF8String:response.return_->_USCOREMESSAGE->c_str()];
			_Errorcode.text = [[NSString alloc] initWithUTF8String:response.return_->_USCOREERRORCODE->c_str()];
		} else {
			_MessageText.text = @"Ungültige Angaben";
		}
	} else {
		service.soap_stream_fault(std::cerr);
	}
	
	service.destroy(); // Free soap context
}

- (IBAction)hideKeyboard:(id)sender {
}
@end
