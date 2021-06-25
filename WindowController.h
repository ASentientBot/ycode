@class XcodeView;

@interface WindowController:NSWindowController

@property(strong) XcodeView* view;

-(instancetype)init;

@end

#import "WindowController.m"