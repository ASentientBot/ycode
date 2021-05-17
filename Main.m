@import AppKit;
#import "AppDelegate.h"

int main(int argCount,char** argList)
{
	NSApplication.sharedApplication.delegate=AppDelegate.alloc.init;
	NSApp.run;
}