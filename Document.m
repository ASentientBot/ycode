#import "WindowController.h"

@implementation Document

-(void)makeWindowControllers
{
	self.windowController=WindowController.alloc.init;
	
	if(self.cachedURL)
	{
		[self.windowController.view loadURL:self.cachedURL];
	}
	
	[self addWindowController:self.windowController];
}

-(BOOL)readFromURL:(NSURL*)fileURL ofType:(NSString*)fileType error:(NSError**)error
{
	self.cachedURL=fileURL;
	return true;
}

-(BOOL)writeToURL:(NSURL*)fileURL ofType:(NSString*)fileType error:(NSError**)error
{
	[self.windowController.view saveURL:fileURL];
	return true;
}

@end