//
//  iTermTests.m
//  iTerm
//
//  Created by George Nachman on 10/16/13.
//
//

#import "iTermTests.h"
#import <objc/runtime.h>
#import "iTermApplicationDelegate.h"

@implementation iTermTest
@end

#define DECLARE_TEST(t) \
@interface t : iTermTest \
@end

DECLARE_TEST(VT100GridTest)
DECLARE_TEST(VT100ScreenTest)
DECLARE_TEST(IntervalTreeTest)
DECLARE_TEST(AppleScriptTest)
DECLARE_TEST(NSStringCategoryTest)
DECLARE_TEST(PTYTextViewTest)
DECLARE_TEST(PTYSessionTest)
DECLARE_TEST(iTermPasteHelperTest)
DECLARE_TEST(TrouterTest)

static void RunTestsInObject(iTermTest *test) {
    NSLog(@"-- Begin tests in %@ --", [test class]);
    unsigned int methodCount;
    Method *methods = class_copyMethodList([test class], &methodCount);
    for (int i = 0; i < methodCount; i++) {
        SEL name = method_getName(methods[i]);
        NSString *stringName = NSStringFromSelector(name);
        if ([stringName hasPrefix:@"test"]) {
            if ([test respondsToSelector:@selector(setup)]) {
                [test setup];
            }
            NSLog(@"Running %@", stringName);
            [test performSelector:name];
            if ([test respondsToSelector:@selector(teardown)]) {
                [test teardown];
            }
            NSLog(@"Success!");
        }
    }
    free(methods);
    NSLog(@"-- Finished tests in %@ --", [test class]);
}

int main(int argc, const char * argv[]) {
    [[NSApplication sharedApplication] setDelegate:[[iTermApplicationDelegate alloc] init]];
/*
    RunTestsInObject([[VT100GridTest new] autorelease]);
    RunTestsInObject([[VT100ScreenTest new] autorelease]);
    RunTestsInObject([[IntervalTreeTest new] autorelease]);
    RunTestsInObject([[NSStringCategoryTest new] autorelease]);
    RunTestsInObject([[AppleScriptTest new] autorelease]);
    RunTestsInObject([[PTYTextViewTest new] autorelease]);
    RunTestsInObject([[PTYSessionTest new] autorelease]);
    RunTestsInObject([[iTermPasteHelperTest new] autorelease]);
 RunTestsInObject([[TrouterTest new] autorelease]);
*/
    NSLog(@"All tests passed");
    return 0;
}

