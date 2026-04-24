#import "GPBProtocolBuffers_RuntimeSupport.h"

#import <objc/runtime.h>
#import <stdlib.h>

static char kSVGALegacyFileSyntaxKey;

@interface GPBFileDescriptor (SVGALegacyGeneratedCompatibilityPrivate)
- (instancetype)initWithPackage:(NSString *)package objcPrefix:(NSString *)objcPrefix;
@end

@interface GPBDescriptor (SVGALegacyGeneratedCompatibilityPrivate)
- (void)setupContainingMessageClass:(Class)messageClass;
@end

static NSString *SVGALegacyMessageName(Class messageClass, NSString *objcPrefix) {
    NSString *messageName = NSStringFromClass(messageClass);
    if (objcPrefix.length > 0 && [messageName hasPrefix:objcPrefix]) {
        messageName = [messageName substringFromIndex:objcPrefix.length];
    }

    NSRange nestedSeparator = [messageName rangeOfString:@"_" options:NSBackwardsSearch];
    if (nestedSeparator.location != NSNotFound) {
        messageName = [messageName substringFromIndex:nestedSeparator.location + 1];
    }
    return messageName;
}

static GPBFileDescription *SVGALegacyFileDescription(GPBFileDescriptor *file) {
    GPBFileDescription *fileDescription = calloc(1, sizeof(*fileDescription));
    NSString *package = file.package;
    NSString *objcPrefix = file.objcPrefix;

    fileDescription->package = package.length > 0 ? package.UTF8String : NULL;
    fileDescription->prefix = objcPrefix.length > 0 ? objcPrefix.UTF8String : NULL;

    NSNumber *syntaxValue = objc_getAssociatedObject(file, &kSVGALegacyFileSyntaxKey);
    fileDescription->syntax = syntaxValue != nil ? (GPBFileSyntax)syntaxValue.unsignedIntegerValue : GPBFileSyntaxUnknown;
    return fileDescription;
}

@implementation GPBFileDescriptor (SVGALegacyGeneratedCompatibility)

- (instancetype)initWithPackage:(NSString *)package objcPrefix:(NSString *)objcPrefix syntax:(GPBFileSyntax)syntax {
    self = [self initWithPackage:package objcPrefix:objcPrefix];
    if (self != nil) {
        objc_setAssociatedObject(self, &kSVGALegacyFileSyntaxKey, @(syntax), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return self;
}

- (GPBFileSyntax)syntax {
    NSNumber *syntaxValue = objc_getAssociatedObject(self, &kSVGALegacyFileSyntaxKey);
    return syntaxValue != nil ? (GPBFileSyntax)syntaxValue.unsignedIntegerValue : GPBFileSyntaxUnknown;
}

@end

@implementation GPBDescriptor (SVGALegacyGeneratedCompatibility)

+ (instancetype)allocDescriptorForClass:(Class)messageClass
                             rootClass:(Class)__unused rootClass
                                  file:(GPBFileDescriptor *)file
                                fields:(void *)fieldDescriptions
                            fieldCount:(uint32_t)fieldCount
                           storageSize:(uint32_t)storageSize
                                 flags:(GPBDescriptorInitializationFlags)flags {
    GPBFileDescription *fileDescription = SVGALegacyFileDescription(file);
    GPBDescriptorInitializationFlags compatibilityFlags =
        (GPBDescriptorInitializationFlags)(flags |
                                           GPBDescriptorInitializationFlag_UsesClassRefs |
                                           GPBDescriptorInitializationFlag_Proto3OptionalKnown |
                                           GPBDescriptorInitializationFlag_ClosedEnumSupportKnown);

    GPBDescriptor *descriptor =
        [self allocDescriptorForClass:messageClass
                          messageName:SVGALegacyMessageName(messageClass, file.objcPrefix)
                      fileDescription:fileDescription
                               fields:fieldDescriptions
                           fieldCount:fieldCount
                          storageSize:storageSize
                                flags:compatibilityFlags];

    objc_setAssociatedObject(descriptor.file, &kSVGALegacyFileSyntaxKey, @(fileDescription->syntax), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return descriptor;
}

- (void)setupContainingMessageClassName:(Class)messageClass {
    [self setupContainingMessageClass:messageClass];
}

@end
