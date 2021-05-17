@interface DVTDeveloperPaths:NSObject
+(void)initializeApplicationDirectoryName:(NSString*)name;
@end

@interface DVTSourceSpecification:NSObject
+(void)searchForAndRegisterAllAvailableSpecifications;
@end

@interface DVTPlugInManager:NSObject
+(instancetype)defaultPlugInManager;
-(void)scanForPlugIns:(id)arg1;
@end

@interface DVTTheme:NSObject
@end

@interface DVTFilePath:NSObject
+(instancetype)filePathForFileURL:(NSURL*)url;
@end

@interface DVTFileDataType:NSObject
+(DVTFileDataType*)fileDataTypeForFilePath:(DVTFilePath*)path error:(id)error;
@end

@interface DVTSourceCodeLanguage:NSObject
+(instancetype)sourceCodeLanguageForFileDataType:(DVTFileDataType*)type;
@end

@interface DVTSourceTextView:NSTextView
@property BOOL wrapsLines;
-(void)shiftRight:(id)sender;
-(void)shiftLeft:(id)sender;
@end

@interface DVTTextStorage:NSTextStorage
@property DVTSourceCodeLanguage* language;
@property BOOL usesTabs;
@property int wrappedLineIndentWidth;
@end

@interface DVTTextSidebarView:NSRulerView
@property BOOL drawsLineNumbers;
@end

@interface DVTTextPreferences:NSObject
+(DVTTextPreferences*)sharedPreferences;
@property BOOL enableTypeOverCompletions;
@property BOOL useSyntaxAwareIndenting;
@property BOOL autoInsertClosingBrace;
@property BOOL autoInsertOpenBracket;
@end

@interface DVTSourceTextScrollView:NSScrollView
@end

@interface DVTAnnotatingTypesetter:NSTypesetter
@end