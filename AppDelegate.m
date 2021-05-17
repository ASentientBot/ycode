#import "Document.h"

NSMenu* makeMenu(NSMenu* parentMenu,NSString* title)
{
	NSMenu* dropdownMenu=[NSMenu.alloc initWithTitle:title];
	NSMenuItem* dropdownMenuItem=NSMenuItem.new;
	[dropdownMenuItem setSubmenu:dropdownMenu];
	[parentMenu addItem:dropdownMenuItem];
	return dropdownMenu;
}

NSMenuItem* addMenuItem(NSMenu* parentMenu,NSString* name,id target,SEL selector,NSString* key,NSEventModifierFlags mask,NSInteger tag)
{
	NSMenuItem* menuItem=[NSMenuItem.alloc initWithTitle:name action:selector keyEquivalent:key];
	menuItem.keyEquivalentModifierMask=mask;
	menuItem.target=target;
	menuItem.tag=tag;
	[parentMenu addItem:menuItem];
	return menuItem;
}

void addMenuSeparator(NSMenu* parentMenu)
{
	[parentMenu addItem:NSMenuItem.separatorItem];
}

@implementation AppDelegate

-(void)applicationDidFinishLaunching:(NSNotification*)notification
{
	NSMenu* menuBar=NSMenu.new;
	
	NSMenu* appMenu=makeMenu(menuBar,@"");
	addMenuItem(appMenu,@"Quit",nil,@selector(terminate:),@"q",NSEventModifierFlagCommand,0);
	
	NSMenu* fileMenu=makeMenu(menuBar,@"File");
	addMenuItem(fileMenu,@"New",nil,@selector(newDocument:),@"n",NSEventModifierFlagCommand,0);
	addMenuItem(fileMenu,@"Open",nil,@selector(openDocument:),@"o",NSEventModifierFlagCommand,0);
	addMenuSeparator(fileMenu);
	addMenuItem(fileMenu,@"Close",nil,@selector(performClose:),@"w",NSEventModifierFlagCommand,0);
	addMenuItem(fileMenu,@"Save",nil,@selector(saveDocument:),@"s",NSEventModifierFlagCommand,0);
	
	NSMenu* editMenu=makeMenu(menuBar,@"Edit");
	addMenuItem(editMenu,@"Undo",nil,@selector(undo),@"z",NSEventModifierFlagCommand,0);
	addMenuItem(editMenu,@"Redo",nil,@selector(redo),@"z",NSEventModifierFlagCommand|NSEventModifierFlagShift,0);
	addMenuSeparator(editMenu);
	addMenuItem(editMenu,@"Cut",nil,@selector(cut:),@"x",NSEventModifierFlagCommand,0);
	addMenuItem(editMenu,@"Copy",nil,@selector(copy:),@"c",NSEventModifierFlagCommand,0);
	addMenuItem(editMenu,@"Paste",nil,@selector(paste:),@"v",NSEventModifierFlagCommand,0);
	addMenuItem(editMenu,@"Select All",nil,@selector(selectAll:),@"a",NSEventModifierFlagCommand,0);
	addMenuSeparator(editMenu);
	addMenuItem(editMenu,@"Find",nil,@selector(performTextFinderAction:),@"f",NSEventModifierFlagCommand,NSTextFinderActionShowFindInterface);
	addMenuItem(editMenu,@"Find Next",nil,@selector(performTextFinderAction:),@"g",NSEventModifierFlagCommand,NSTextFinderActionNextMatch);
	addMenuItem(editMenu,@"Find Previous",nil,@selector(performTextFinderAction:),@"g",NSEventModifierFlagCommand|NSEventModifierFlagShift,NSTextFinderActionPreviousMatch);
	addMenuSeparator(editMenu);
	addMenuItem(editMenu,@"Shift Right",nil,@selector(shiftRight:),@"]",NSEventModifierFlagCommand,0);
	addMenuItem(editMenu,@"Shift Left",nil,@selector(shiftLeft:),@"[",NSEventModifierFlagCommand,0);
	
	NSMenu* viewMenu=makeMenu(menuBar,@"View");
	addMenuItem(viewMenu,@"Previous Tab",nil,@selector(selectPreviousTab:),@"\x1C",NSEventModifierFlagCommand|NSEventModifierFlagOption,0);
	addMenuItem(viewMenu,@"Next Tab",nil,@selector(selectNextTab:),@"\x1D",NSEventModifierFlagCommand|NSEventModifierFlagOption,0);
	addMenuSeparator(viewMenu);
	addMenuItem(viewMenu,@"Enter Full Screen",nil,@selector(toggleFullScreen:),@"f",NSEventModifierFlagCommand|NSEventModifierFlagControl,0);
	
	NSApp.mainMenu=menuBar;
	
	[NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent*(NSEvent* event)
	{
		if(event.modifierFlags&NSEventModifierFlagCommand)
		{
			if([@"123456789" containsString:event.characters])
			{
				NSArray<NSWindow*>* tabWindows=NSApp.keyWindow.tabbedWindows;
				int tabIndex=event.characters.integerValue-1;
				if(tabIndex==8||tabIndex>=tabWindows.count)
				{
					tabWindows[tabWindows.count-1].makeKeyWindow;
				}
				else
				{
					tabWindows[tabIndex].makeKeyWindow;
				}
				return nil;
			}
		}
		return event;
	}];
	
	[NSApp activateIgnoringOtherApps:true];
}

@end