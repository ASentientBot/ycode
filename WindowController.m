#import "XcodeView.h"

@implementation WindowController

-(instancetype)init
{
	self=super.init;
	
	self.windowFrameAutosaveName=@"window";
	
	NSRect windowRect=NSMakeRect(0,0,500,500);
	NSWindowStyleMask windowStyle=NSWindowStyleMaskTitled|NSWindowStyleMaskClosable|NSWindowStyleMaskMiniaturizable|NSWindowStyleMaskResizable;
	NSWindow* window=[NSWindow.alloc initWithContentRect:windowRect styleMask:windowStyle backing:NSBackingStoreBuffered defer:false];
	window.tabbingMode=NSWindowTabbingModePreferred;
	self.window=window;
	window.release;
	
	XcodeView* view=[XcodeView.alloc initWithFrame:self.window.frame];
	self.view=view;
	window.contentView=view;
	view.release;
	
	return self;
}

-(void)dealloc
{
	self.view.release;
	super.dealloc;
}

@end