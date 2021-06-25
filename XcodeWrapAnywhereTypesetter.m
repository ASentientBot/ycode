// TODO: there MUST be a better way to do this...

@interface XcodeWrapAnywhereTypesetter:DVTAnnotatingTypesetter
@end

@implementation XcodeWrapAnywhereTypesetter

-(BOOL)shouldBreakLineByWordBeforeCharacterAtIndex:(NSUInteger)charIndex
{
	return false;
}

@end