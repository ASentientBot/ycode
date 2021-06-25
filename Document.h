@class WindowController;

@interface Document:NSDocument

@property(retain) NSURL* cachedURL;
@property(retain) WindowController* windowController;

@end

#import "Document.m"