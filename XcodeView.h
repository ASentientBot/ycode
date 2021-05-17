#import "XcodeViewSettings.h"

#import "XcodeInterfaces.m"
#import "XcodeWrapAnywhereTypesetter.m"

@interface XcodeView:DVTSourceTextScrollView

@property DVTTextStorage* codeStorage;
@property DVTSourceTextView* codeView;
@property BOOL hasBeenSaved;

-(instancetype)initWithFrame:(NSRect)rect;
-(void)loadURL:(NSURL*)codeURL;
-(void)saveURL:(NSURL*)codeURL;
-(void)undo;
-(void)redo;

@end


#import "XcodeView.m"