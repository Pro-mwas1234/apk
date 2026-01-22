#!/bin/bash
set -e

echo "🔧 Setting up Android SDK for Kotlin development..."

# Install system dependencies
sudo apt-get update
sudo apt-get install -y wget unzip lib32z1 lib32stdc++6

# Set environment paths
ANDROID_HOME="$HOME/android-sdk"
CMDLINE_TOOLS="$ANDROID_HOME/cmdline-tools/latest"

# Create directories
mkdir -p "$ANDROID_HOME" "$CMDLINE_TOOLS"

# Download Android Command-line Tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdline-tools.zip
unzip -q /tmp/cmdline-tools.zip -d /tmp
mv /tmp/cmdline-tools/* "$CMDLINE_TOOLS/"
rm -rf /tmp/cmdline-tools /tmp/cmdline-tools.zip

# Add to PATH (for current session)
export ANDROID_HOME
export PATH="$CMDLINE_TOOLS/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"

# Accept licenses automatically
yes | sdkmanager --licenses >/dev/null 2>&1

# Install essential SDK packages
sdkmanager \
  "platform-tools" \
  "platforms;android-34" \
  "build-tools;34.0.0" \
  "ndk;25.1.8335253" \
  "cmake;3.22.1" \
  "extras;google;m2repository" \
  "extras;android;m2repository"

# Create symbolic link for Gradle to find SDK (optional but helpful)
echo "export ANDROID_HOME=\$HOME/android-sdk" >> "$HOME/.bashrc"
echo 'export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$PATH"' >> "$HOME/.bashrc"

echo "✅ Android SDK setup complete!"
echo "Kotlin Android dev environment ready."
