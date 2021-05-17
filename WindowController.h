@class XcodeView;

@interface WindowController:NSWindowController

@property XcodeView* view;

-(instancetype)init;

@end

#import "WindowController.m"