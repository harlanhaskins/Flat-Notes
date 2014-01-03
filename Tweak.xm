%hook UIColor

+(UIColor*) notesAppYellowColor {

  return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
}

%end

@interface UIImage(Color)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation UIImage(Color)

+ (UIImage *)imageWithColor:(UIColor *)color {

  CGRect rect = CGRectMake(0, 0, 1, 1);

  // Create a 1 by 1 pixel context
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
  [color setFill];
  UIRectFill(rect);   // Fill it with your color
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;

}

@end

%hook NotesTextureBackgroundView

+ (UIImage*) statusBarBackgroundImage {
  return [UIImage imageWithColor:[UIColor whiteColor]];
}

+ (UIImage*) textureImage {
  return [UIImage imageWithColor:[UIColor whiteColor]];
}

%end
