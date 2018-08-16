
#import "hook.h"

#include <stdio.h>
#include <objc/runtime.h>
#include <Foundation/Foundation.h>
#include <UIKit/UIKit.h>

static IMP sOriginalImp = NULL;

@implementation hook

+(void)load
{
	Class originalClass = NSClassFromString(@"MainWebView");
	Method originalMeth = class_getInstanceMethod(originalClass, @selector(webView:didFinishLoadForFrame:));
	sOriginalImp = method_getImplementation(originalMeth);

	Method replacementMeth = class_getInstanceMethod(NSClassFromString(@"hook"), @selector(patch:a2:));
	method_exchangeImplementations(originalMeth, replacementMeth);
}

-(void)patch:(id)arg1 a2:(id)arg2
{
	sOriginalImp(self, @selector(webView:didFinishLoadForFrame:), arg1, arg2);

    [arg1 stringByEvaluatingJavaScriptFromString: @"document.getElementById('speedbump').remove();" ];
}

@end
