# .zshenv is sourced on all invocations of the shell, unless the -f option
# is set. It should contain commands to set the command search path, plus
# other important environment variables. .zshenv should not contain commands
# that produce output or assume the shell is attached to a tty.

(( $EUID == 0 )) && umask 22 || umask 77

# the directory to search for shell startup files
ZDOTDIR=~/.zsh

export GOHOME=/usr/local/go

# java
export J17_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_71.jdk/Contents/Home/
export J18_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_31.jdk/Contents/Home/
export JAVA_HOME=$J17_HOME

# maven
export M2_HOME=~/tools/apache-maven-3.2.5/
export MAVEN_OPTS="-Xmx512m"

# servers
export TOMCAT_HOME=/home/kuro/ws/head/tomcat

export PATH=$JAVA_HOME/bin:$PATH

# set generic path and manpath
path=($M2_HOME/bin
      $JAVA_HOME/bin
	$GOHOME/bin
	~/tools/scripts
      /sbin
      /bin
      /usr/sbin
      /usr/bin
      /usr/local/sbin
      /usr/local/bin
      /usr/X11R6/bin
	/usr/local/mysql/bin/
      )
manpath=($HOME/usr/man $manpath)

# search path for cd
#cdpath=(~)

# where to look for autoloaded function definitions
fpath=($fpath ~/.zsh/completion)

# remove duplicate entries from path, cdpath, manpath and
# fpath and export (export is equivalent to typeset -gx)
typeset -Ugx path manpath cdpath fpath

# sh sources ENV after the profile scripts if the shell
# is invoked for interactive use
export ENV=$HOME/.shrc

