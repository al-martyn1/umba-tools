@set ACC=al-martyn1
@set BASE=github.com

@set PREFIX=https://%BASE%/%ACC%
@rem set PREFIX=git@%BASE%:%ACC%


cd ..

if not exist umba-brief-scanner    git clone %PREFIX%/umba-brief-scanner.git
if exist umba-brief-scanner\_libs\clone_libs_https.bat call umba-brief-scanner\_libs\clone_libs_https.bat

if not exist umba-make-headers     git clone %PREFIX%/umba-make-headers.git

if not exist umba-pretty-headers   git clone %PREFIX%/umba-pretty-headers.git
if exist umba-pretty-headers\_libs\clone_libs_https.bat call umba-pretty-headers\_libs\clone_libs_https.bat

if not exist umba-sort-headers     git clone %PREFIX%/umba-sort-headers.git

if not exist umba-subst-macros     git clone %PREFIX%/umba-subst-macros.git
if exist umba-subst-macros\_libs\clone_libs_https.bat call umba-subst-macros\_libs\clone_libs_https.bat

cd umba-tools
