const BOOL TYPE_OVER_COMPLETIONS=false;
const BOOL AUTO_INDENT=false;
const BOOL AUTO_CLOSE_BRACE=false;
const BOOL AUTO_OPEN_BRACKET=false;
const BOOL USE_TABS=true;
const BOOL WRAP=true;
const int WRAP_INDENT=0;
const BOOL WRAP_ON_WORDS=false;
const BOOL SHOW_LINE_NUMBERS=true;

NSDictionary<NSString*,NSString*>* LANGUAGE_FALLBACKS()
{
	NSMutableDictionary* result=NSMutableDictionary.alloc.init;
	
	// ActionScript
	result[@"as"]=@"Xcode.SourceCodeLanguage.JavaScript";
	
	return result.autorelease;
}