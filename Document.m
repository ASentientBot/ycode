#import "WindowController.h"

@implementation Document

-(void)makeWindowControllers
{
	WindowController* controller=WindowController.alloc.init;
	self.windowController=controller;
	controller.release;
	
	if(self.cachedURL)
	{
		[self.windowController.view loadURL:self.cachedURL];
	}
	
	[self addWindowController:self.windowController];
}

-(BOOL)readFromURL:(NSURL*)fileURL ofType:(NSString*)fileType error:(NSError**)error
{
	self.cachedURL=fileURL.copy;
	return true;
}

-(BOOL)writeToURL:(NSURL*)fileURL ofType:(NSString*)fileType error:(NSError**)error
{
	[self.windowController.view saveURL:fileURL];
	return true;
}

-(void)dealloc
{
	self.windowController.release;
	self.cachedURL.release;
	super.dealloc;
}

@end