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
+(NSMutableSet<DVTSourceCodeLanguage*>*)sourceCodeLanguages;
+(instancetype)sourceCodeLanguageForFileDataType:(DVTFileDataType*)type;
+(instancetype)sourceCodeLanguageWithIdentifier:(NSString*)identifier;
@end

@interface DVTSourceTextView:NSTextView
@property(assign) BOOL wrapsLines;
-(void)shiftRight:(id)sender;
-(void)shiftLeft:(id)sender;
@end

@interface DVTTextStorage:NSTextStorage
@property(retain) DVTSourceCodeLanguage* language;
@property(assign) BOOL usesTabs;
@property(assign) int wrappedLineIndentWidth;
@end

@interface DVTTextSidebarView:NSRulerView
@property(assign) BOOL drawsLineNumbers;
@end

@interface DVTTextPreferences:NSObject
+(DVTTextPreferences*)sharedPreferences;
@property(assign) BOOL enableTypeOverCompletions;
@property(assign) BOOL useSyntaxAwareIndenting;
@property(assign) BOOL autoInsertClosingBrace;
@property(assign) BOOL autoInsertOpenBracket;
@end

@interface DVTSourceTextScrollView:NSScrollView
@end

@interface DVTAnnotatingTypesetter:NSTypesetter
@end