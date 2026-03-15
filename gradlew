#!/usr/bin/env sh

# Copyright 2015 the original author or authors.

# Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

##############################################################################
#
#   Gradle start up script for UN*X
#
##############################################################################

# Attempt to set APP_HOME
# Resolve links: $0 may be a link
PRG="$0"
while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`"/$link"
  fi
done
SAVED="`pwd`"
cd "`dirname "$PRG"`/" > /dev/null
APP_HOME="`pwd -P`"
cd "$SAVED" > /dev/null

APP_NAME="Gradle"
APP_BASE_NAME=`basename "$0"`

# Add default JVM options here. You can also use JAVA_OPTS and GRADLE_OPTS to pass JVM options to this script.
DEFAULT_JVM_OPTS=""

# Use the maximum available, or set MAX_FD != -1 to use that value.
MAX_FD="maximum"

warn () {
    echo "$*"
}

die () {
    echo
    echo "$*"
    echo
    exit 1
}

# OS specific support (must be 'true' or 'false').
cygwin=false
darwin=false
mingw=false
case "`uname`" in
  CYGWIN* )
    cygwin=true
    ;;
  Darwin* )
    darwin=true
    ;;
  MINGW* )
    mingw=true
    ;;
esac

# For Cygwin, ensure paths are in UNIX format before anything is touched.
if $cygwin ; then
    [ -n "$JAVA_HOME" ] && JAVA_HOME=`cygpath --unix "$JAVA_HOME"`
    [ -n "$CLASSPATH" ] && CLASSPATH=`cygpath --path --unix "$CLASSPATH"`
fi

# Attempt to find JAVA_HOME
if [ -z "$JAVA_HOME" ] ; then
    if $darwin ; then
        # OSX
        if [ -d "/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home" ] ; then
            export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home"
        fi
    else
        JAVA_HOME=`which java 2>/dev/null`
        if [ -n "$JAVA_HOME" ] ; then
            JAVA_HOME=`dirname "$JAVA_HOME"`/..
        fi
    fi
    if [ -z "$JAVA_HOME" ] ; then
        die "ERROR: JAVA_HOME not found and no 'java' command could be found in your PATH."
    fi
fi

# Set JAVA_EXE
JAVA_EXE="$JAVA_HOME/bin/java"
if [ ! -x "$JAVA_EXE" ] ; then
    die "ERROR: JAVA_HOME is set to an invalid directory: $JAVA_HOME\n\nPlease set the JAVA_HOME variable in your environment to match the\nlocation of your Java installation."
fi

# Increase the maximum file descriptors if we can.
if [ "$MAX_FD" = "maximum" -o "$MAX_FD" = "max" ] ; then
    # Get max file descriptors for this process.
    MAX_FD=`ulimit -H -n`
    if [ $? -ne 0 ] ; then
        warn "Could not query maximum file descriptor limit."
        MAX_FD="4096"
    fi
fi
if [ "$MAX_FD" -gt 0 ] ; then
    ulimit -n $MAX_FD
fi

# For Darwin, add options to specify how the application appears in the dock
if $darwin; then
    GRADLE_OPTS="$GRADLE_OPTS "-Xdock:name=$APP_NAME" "-Xdock:icon=$APP_HOME/media/gradle.icns""
fi

# For Cygwin, switch paths to Windows format before running java
if $cygwin ; then
    APP_HOME=`cygpath --path --windows "$APP_HOME"`
    JAVA_HOME=`cygpath --path --windows "$JAVA_HOME"`
    CLASSPATH=`cygpath --path --windows "$CLASSPATH"`
    JAVA_EXE=`cygpath --unix "$JAVA_EXE"`

    # We build the pattern for arguments to be converted via cygpath
    ROOTDIRSRAW=`find "$APP_HOME" -type d -name "bin" | sort`
    SEP=":"
    if [ "$MSYSTEM" = "MINGW32" ] ; then
        SEP=";"
    fi
    ROOTDIRS="`echo "$ROOTDIRSRAW" | tr "\\n" "$SEP" | sed 's|$SEP$||'`"
fi

# Collect all arguments for the java command,
# following the shell quoting and substitution rules
eval set -- "$DEFAULT_JVM_OPTS" "$JAVA_OPTS" "$GRADLE_OPTS" "-Dorg.gradle.appname=$APP_BASE_NAME" -classpath "$CLASSPATH" org.gradle.launcher.GradleMain "$@"

# by default we should be in the correct project dir, but when run from Finder on Mac, the cwd is wrong
if [ "$darwin" ] && [ "$HOME" = "`pwd`" ]; then
  cd "$APP_HOME"
fi

if $cygwin ; then
    # Convert paths to Windows before executing java
    case "$1" in
        -D* | -X* | -XX* | --* )
            # Arguments with quotes must be converted to windows paths before splitting
            org_args="$@"
            args=()
            while [ $# -gt 0 ] ; do
                if expr "$1" : '"' > /dev/null; then
                    # Remove first quote
                    arg=`expr "$1" : '"\(.*\)'`
                    # Find matching second quote
                    i=2
                    while [ "`expr "$arg" : '.*"'`" = "0" ] && [ $i -lt "${#1}" ]; do
                        arg="$arg `expr "$1" : ".\{$i\}\(.*\)"`"
                        i=`expr $i + 1`
                    done
                    # Remove second quote
                    arg=`expr "$arg" : '\(.*\)"'`
                else
                    arg="$1"
                fi
                # Convert arg to windows path
                if expr "$arg" : '/.*' > /dev/null; then
                    arg=`cygpath --path --windows "$arg"`
                fi
                args="${args[@]}" "$arg"
                shift
            done
            # Execute java with the converted arguments
            exec "$JAVA_EXE" "${args[@]}"
            ;;
        * )
            # Convert the arguments to windows paths
            # Create a temporary file to hold the command
            cmdfile=`mktemp /tmp/gradle.cmd.XXXXXX`
            echo "@echo off" > "$cmdfile"
            echo "setlocal" >> "$cmdfile"
            echo "set GRADLE_HOME=$APP_HOME" >> "$cmdfile"
            echo "set CLASSPATH=$CLASSPATH" >> "$cmdfile"
            echo "set JAVA_EXE=$JAVA_EXE" >> "$cmdfile"
            echo "set DEFAULT_JVM_OPTS=$DEFAULT_JVM_OPTS" >> "$cmdfile"
            echo "set JAVA_OPTS=$JAVA_OPTS" >> "$cmdfile"
            echo "set GRADLE_OPTS=$GRADLE_OPTS" >> "$cmdfile"
            echo "set APP_BASE_NAME=$APP_BASE_NAME" >> "$cmdfile"
            echo "set APP_HOME=$APP_HOME" >> "$cmdfile"
            echo "call :main %*" >> "$cmdfile"
            echo "endlocal" >> "$cmdfile"
            echo "goto :EOF" >> "$cmdfile"
            echo ":main" >> "$cmdfile"
            echo "setlocal" >> "$cmdfile"
            echo "set args=" >> "$cmdfile"
            echo ":loop"
            echo "if [%1]==[] goto :execute" >> "$cmdfile"
            echo "set args=%args% %1" >> "$cmdfile"
            echo "shift" >> "$cmdfile"
            echo "goto :loop" >> "$cmdfile"
            echo ":execute"
            echo "%JAVA_EXE% %DEFAULT_JVM_OPTS% %JAVA_OPTS% %GRADLE_OPTS% -Dorg.gradle.appname=%APP_BASE_NAME% -classpath %CLASSPATH% org.gradle.launcher.GradleMain %args%" >> "$cmdfile"
            echo "endlocal" >> "$cmdfile"
            echo "goto :EOF" >> "$cmdfile"
            # Execute the command file
            exec cmd /c "$cmdfile"
            ;;
    esac
else
    # Execute java
    exec "$JAVA_EXE" "$@"
fi