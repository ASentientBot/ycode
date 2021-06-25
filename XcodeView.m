dispatch_once_t frameworkInitPredicate;

@implementation XcodeView

-(instancetype)initWithFrame:(NSRect)rect
{
	dispatch_once(&frameworkInitPredicate,^()
	{
		[DVTDeveloperPaths initializeApplicationDirectoryName:@"something"];
		[DVTPlugInManager.defaultPlugInManager scanForPlugIns:nil];
		DVTSourceSpecification.searchForAndRegisterAllAvailableSpecifications;
		DVTTheme.initialize;
		
		DVTTextPreferences.sharedPreferences.enableTypeOverCompletions=TYPE_OVER_COMPLETIONS;
		DVTTextPreferences.sharedPreferences.useSyntaxAwareIndenting=AUTO_INDENT;
		DVTTextPreferences.sharedPreferences.autoInsertClosingBrace=AUTO_CLOSE_BRACE;
		DVTTextPreferences.sharedPreferences.autoInsertOpenBracket=AUTO_OPEN_BRACKET;
	});
	
	self=[super initWithFrame:rect];
	
	self.hasBeenSaved=false;
	
	[self loadURL:nil];
	
	return self;
}

-(void)loadURL:(NSURL*)codeURL
{
	NSString* codeString=@"";
	if(codeURL)
	{
		codeString=[NSString stringWithContentsOfURL:codeURL encoding:NSUTF8StringEncoding error:nil];
		self.hasBeenSaved=true;
	}
	
	self.codeStorage=[DVTTextStorage.alloc initWithString:codeString];
	self.codeStorage.release;
	
	if(codeURL)
	{
		DVTFilePath* codeFile=[DVTFilePath filePathForFileURL:codeURL];
		DVTFileDataType* codeType=[DVTFileDataType fileDataTypeForFilePath:codeFile error:nil];
		DVTSourceCodeLanguage* language=[DVTSourceCodeLanguage sourceCodeLanguageForFileDataType:codeType];
		
		if(!language)
		{
			NSString* identifier=LANGUAGE_FALLBACKS()[codeURL.pathExtension];
			if(identifier)
			{
				language=[DVTSourceCodeLanguage sourceCodeLanguageWithIdentifier:identifier];
			}
		}
		
		self.codeStorage.language=language;
	}
	
	self.codeStorage.usesTabs=USE_TABS;
	self.codeStorage.wrappedLineIndentWidth=WRAP_INDENT;
	
	self.codeView=DVTSourceTextView.alloc.init;
	self.codeView.release;
	[self.codeView.layoutManager replaceTextStorage:self.codeStorage];
	self.codeView.horizontallyResizable=true;
	self.codeView.wrapsLines=WRAP;
	self.codeView.allowsUndo=true;
	self.codeView.maxSize=NSMakeSize(CGFLOAT_MAX,CGFLOAT_MAX);
	self.codeView.usesFindBar=true;
	
	if(!WRAP_ON_WORDS)
	{
		self.codeView.layoutManager.typesetter=XcodeWrapAnywhereTypesetter.alloc.init;
		self.codeView.layoutManager.typesetter.release;
	}
	
	self.documentView=self.codeView;
	self.hasVerticalScroller=true;
	self.hasHorizontalScroller=true;
	
	if(SHOW_LINE_NUMBERS)
	{
		DVTTextSidebarView* sidebarView=[DVTTextSidebarView.alloc initWithScrollView:self orientation:NSVerticalRuler];
		sidebarView.drawsLineNumbers=true;
		self.verticalRulerView=sidebarView;
		sidebarView.release;
		self.hasVerticalRuler=true;
		self.rulersVisible=true;
	}
}

-(void)saveURL:(NSURL*)codeURL
{
	self.codeView.breakUndoCoalescing;
	
	[self.codeStorage.string writeToURL:codeURL atomically:false encoding:NSUTF8StringEncoding error:nil];
	
	if(!self.hasBeenSaved)
	{
		// TODO: bit of a hack to refresh the language on first save
		[self loadURL:codeURL];
	}
	
	self.hasBeenSaved=true;
}

-(void)undo
{
	self.codeView.undoManager.undo;
}

-(void)redo
{
	self.codeView.undoManager.redo;
}

-(BOOL)validateUserInterfaceItem:(id<NSValidatedUserInterfaceItem>)item
{
	if(item.action==@selector(undo))
	{
		return self.codeView.undoManager.canUndo;
	}
	if(item.action==@selector(redo))
	{
		return self.codeView.undoManager.canRedo;
	}
	
	return true;
}

-(void)dealloc
{
	self.codeStorage.release;
	self.codeView.release;
	super.dealloc;
}

@end
