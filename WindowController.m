#import "XcodeView.h"

@implementation WindowController

-(instancetype)init
{
	self=super.init;
	
	self.windowFrameAutosaveName=@"window";
	
	NSRect windowRect=NSMakeRect(0,0,500,500);
	NSWindowStyleMask windowStyle=NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable;
	self.window=[NSWindow.alloc initWithContentRect:windowRect styleMask:windowStyle backing:NSBackingStoreBuffered defer:false];
	self.window.tabbingMode=NSWindowTabbingModePreferred;
	
	self.view=[XcodeView.alloc initWithFrame:self.window.frame];
	self.window.contentView=self.view;
	
	return self;
}

@end