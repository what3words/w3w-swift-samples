//
//  ViewController.m
//  ObjectiveC
//
//  Created by Dave Duprey on 02/03/2021.
//

#import <MapKit/MapKit.h>
#import "ViewController.h"
@import W3WSwiftComponents;
@import W3WSwiftApi;


@interface ViewController : UIViewController
@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  CGRect frame = CGRectMake(16.0, 128.0, self.view.frame.size.width - 32.0, 32.0);
  
  // You can also create this and set the API key in Interface Builder
  W3WObjcAutoSuggestTextField *textfield = [[W3WObjcAutoSuggestTextField alloc] initWithFrame:frame];
  [textfield setApiKey:@"YourApiKey"];
  [textfield setVoice: YES];
  [textfield setFreeformText: YES];
  [textfield setLanguage:@"en"];
  [textfield setAllowInvalid3wa: YES];
  
  // set filters to only search Canada and the UK, prefering coordinates  near London (focus), and specifying the voice input to be English
  W3WObjcOptions *options = [[W3WObjcOptions alloc] init];
  [options addFocus: CLLocationCoordinate2DMake(51.520847,-0.195521)];
  [options addClipToCountries: @[@"GB", @"CA"]];
  [options addVoiceLanguage: @"en"];
  [options addNumberFocusResults: 1];
  [textfield setOptions: options];
  
  [textfield setSuggestionCallback: ^(W3WObjcSuggestion *suggestion) {
    NSLog(@"%@ %@", suggestion.words, suggestion.distanceToFocus);
  }];
  
  [textfield setTextChangedCallback: ^(NSString *text) {
    NSLog(@"%@", text);
  }];
  
  [textfield setErrorCallback: ^(NSError *error) {
    NSLog(@"Error: %@", error.localizedDescription);
  }];

  [self.view addSubview:textfield];
}


- (void)onSuggestion:(W3WObjcSuggestion *)suggestion {
  NSLog(@" %@ %@ %@", suggestion.words, suggestion.nearestPlace, suggestion.country);
}

- (void)onError:(NSError * _Nonnull)error {
  NSLog(@"Error: %@", error.localizedDescription);
}

- (void)changedWithText:(NSString * _Nullable)text {
}


- (void)changedText:(NSString * _Nullable)text {
  NSLog(@"%@", text);
}


@end
