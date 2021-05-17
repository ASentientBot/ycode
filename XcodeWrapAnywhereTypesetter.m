@interface XcodeWrapAnywhereTypesetter:DVTAnnotatingTypesetter
@end

@implementation XcodeWrapAnywhereTypesetter

-(BOOL)shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
	return false;
}

@end