# ===== CREATE ANDROID PROJECT FROM SCRATCH =====

# 1. Create directory structure
mkdir -p app/src/main/{java/com/example/myapp,res/layout,res/values}

# 2. AndroidManifest.xml
cat > app/src/main/AndroidManifest.xml << 'EOF'
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.example.myapp">
    <application
        android:allowBackup="true"
        android:label="MyApp"
        android:supportsRtl="true"
        android:theme="@android:style/Theme.Material.Light">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>
</manifest>
EOF

# 3. MainActivity.kt
cat > app/src/main/java/com/example/myapp/MainActivity.kt << 'EOF'
package com.example.myapp

import android.app.Activity
import android.os.Bundle
import android.widget.TextView
import android.widget.LinearLayout
import android.view.Gravity

class MainActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        val layout = LinearLayout(this).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
        }
        
        val textView = TextView(this).apply {
            text = "Hello from GitHub Codespaces! 🚀"
            textSize = 20f
        }
        
        layout.addView(textView)
        setContentView(layout)
    }
}
EOF

# 4. build.gradle (Project-level)
cat > build.gradle << 'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.2.1'
        classpath 'org.jetbrains.kotlin:kotlin-gradle-plugin:1.9.22'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
EOF

# 5. build.gradle (App-level)
cat > app/build.gradle << 'EOF'
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace 'com.example.myapp'
    compileSdk 34

    defaultConfig {
        applicationId "com.example.myapp"
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }
}

dependencies {
    implementation 'org.jetbrains.kotlin:kotlin-stdlib:1.9.22'
}
EOF

# 6. settings.gradle
echo "include ':app'" > settings.gradle

# 7. gradle.properties (optional but recommended)
cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx2048m
android.useAndroidX=true
kotlin.code.style=official
EOF

# 8. Make sure we can build
chmod +x ./gradlew 2>/dev/null || echo "No gradlew yet — using system Gradle"

echo "✅ Android project created successfully!"
