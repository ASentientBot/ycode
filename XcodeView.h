#import "XcodeViewSettings.h"

#import "XcodeInterfaces.h"
#import "XcodeWrapAnywhereTypesetter.m"

@interface XcodeView:DVTSourceTextScrollView

@property(retain) DVTTextStorage* codeStorage;
@property(retain) DVTSourceTextView* codeView;
@property(assign) BOOL hasBeenSaved;

-(instancetype)initWithFrame:(NSRect)rect;
-(void)loadURL:(NSURL*)codeURL;
-(void)saveURL:(NSURL*)codeURL;
-(void)undo;
-(void)redo;

@end


#import "XcodeView.m"