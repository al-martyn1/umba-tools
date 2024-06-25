@set ACC=al-martyn1
@set BASE=github.com

@set PREFIX=https://%BASE%/%ACC%
@rem set PREFIX=git@%BASE%:%ACC%


cd ..

if not exist umba-2c               git clone %PREFIX%/umba-2c.git
if exist umba-2c\_libs\clone_libs_https.bat call umba-2c\_libs\clone_libs_https.bat

if not exist umba-brief-scanner    git clone %PREFIX%/umba-brief-scanner.git
if exist umba-brief-scanner\_libs\clone_libs_https.bat call umba-brief-scanner\_libs\clone_libs_https.bat

if not exist umba-dll-proxy-gen    git clone %PREFIX%/umba-dll-proxy-gen.git
if exist umba-dll-proxy-gen\_libs\clone_libs_https.bat call umba-dll-proxy-gen\_libs\clone_libs_https.bat

if not exist umba-enum-gen         git clone %PREFIX%/umba-enum-gen.git
if exist umba-enum-gen\_libs\clone_libs_https.bat call umba-enum-gen\_libs\clone_libs_https.bat

if not exist umba-make-headers     git clone %PREFIX%/umba-make-headers.git

if not exist umba-md               git clone %PREFIX%/umba-md.git
if exist umba-md\_libs\clone_libs_https.bat call umba-md\_libs\clone_libs_https.bat

if not exist umba-md-pp            git clone %PREFIX%/umba-md-pp.git
if exist umba-md-pp\_libs\clone_libs_https.bat call umba-md-pp\_libs\clone_libs_https.bat

if not exist umba-msvc-filters     git clone %PREFIX%/umba-msvc-filters.git
if exist umba-msvc-filters\_libs\clone_libs_https.bat call umba-msvc-filters\_libs\clone_libs_https.bat

if not exist umba-pretty-headers   git clone %PREFIX%/umba-pretty-headers.git
if exist umba-pretty-headers\_libs\clone_libs_https.bat call umba-pretty-headers\_libs\clone_libs_https.bat

if not exist umba-sort-headers     git clone %PREFIX%/umba-sort-headers.git
if exist umba-sort-headers\_libs\clone_libs_https.bat call umba-sort-headers\_libs\clone_libs_https.bat

if not exist umba-subst-macros     git clone %PREFIX%/umba-subst-macros.git
if exist umba-subst-macros\_libs\clone_libs_https.bat call umba-subst-macros\_libs\clone_libs_https.bat

if not exist umba-tabtool          git clone %PREFIX%/umba-tabtool.git
if exist umba-tabtool\_libs\clone_libs_https.bat call umba-tabtool\_libs\clone_libs_https.bat

if not exist umba-tr               git clone %PREFIX%/umba-tr.git
if exist umba-tr\_libs\clone_libs_https.bat call umba-tr\_libs\clone_libs_https.bat

cd umba-tools
