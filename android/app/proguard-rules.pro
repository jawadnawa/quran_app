# Keep class members required for serialization/deserialization
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    private void readObjectNoData();
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# Keep all Flutter classes
-keep class io.flutter.** { *; }

# Don't warn about missing classes
-dontwarn io.flutter.embedding.**

# Keep Application classes
-keep class androidx.lifecycle.DefaultLifecycleObserver { *; }

# Keep certain support library classes
-keep public class androidx.** { *; }
-dontwarn androidx.**

# Preserve Gson and JSON serialization/deserialization
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keepattributes EnclosingMethod
-keepattributes InnerClasses

# OkHttp and Retrofit
-dontwarn okhttp3.**
-dontwarn retrofit2.**
-keep class okhttp3.** { *; }
-keep class retrofit2.** { *; }

# Preserve enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Keep accessibility and reflection classes
-keep class sun.misc.Unsafe { *; }
-keep class java.lang.invoke.** { *; }

# Exclude logging frameworks from optimization
-assumenosideeffects class android.util.Log {
    public static *** v(...);
    public static *** d(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
}

# Support for Glide
-keep class com.bumptech.glide.** { *; }
-dontwarn com.bumptech.glide.**

# Keep rules for libraries used in the project
-dontwarn com.google.firebase.**
-keep class com.google.firebase.** { *; }
-keepattributes *Annotation*

# Keep SplitCompatApplication to resolve missing class issue
-keep class com.google.android.play.core.splitcompat.** { *; }
-keepclassmembers class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.splitcompat.**

# General rules to avoid missing references
-dontwarn javax.annotation.**
-dontwarn kotlin.**

# Keep rules for WorkManager
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**

# Keep rules for Play Core library
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Allow reflection for Firebase
-keepattributes InnerClasses
-keepattributes SourceFile,LineNumberTable
-keepattributes Annotation