#import "XMPPStringPrep.h"
//@import libidn;
//#import "idn-int.h"
//#import "stringprep.h"
//#import "build-libidn.sh"
#import "libidn.h"

@implementation XMPPStringPrep

+ (NSString *)prepNode:(NSString *)node
{
    return [NSString idn_prepNode:node];
}

+ (NSString *)prepDomain:(NSString *)domain
{
    return [NSString idn_prepDomain:domain];
}

+ (NSString *)prepResource:(NSString *)resource
{
    return [NSString idn_prepResource:resource];
}

+ (NSString *)prepPassword:(NSString *)password
{
    return [NSString idn_prepPassword:password];
}

@end
