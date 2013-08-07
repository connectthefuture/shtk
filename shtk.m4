dnl Copyright 2013 Google Inc.
dnl All rights reserved.
dnl
dnl Redistribution and use in source and binary forms, with or without
dnl modification, are permitted provided that the following conditions are
dnl met:
dnl
dnl * Redistributions of source code must retain the above copyright
dnl   notice, this list of conditions and the following disclaimer.
dnl * Redistributions in binary form must reproduce the above copyright
dnl   notice, this list of conditions and the following disclaimer in the
dnl   documentation and/or other materials provided with the distribution.
dnl * Neither the name of Google Inc. nor the names of its contributors
dnl   may be used to endorse or promote products derived from this software
dnl   without specific prior written permission.
dnl
dnl THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
dnl "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
dnl LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
dnl A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
dnl OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
dnl SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
dnl LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
dnl DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
dnl THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
dnl (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
dnl OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

dnl SHTK_CHECK([version-spec])
dnl
dnl Checks if shtk is present and substitutes SHTK_TOOL with the full path to
dnl the shtk(1) utility needed to "build" scripts that use shtk, and
dnl SHTK_MODULESDIR with the location of the modules.
dnl
dnl \param version-spec If provided, indicates the version requirement for the
dnl     shtk pkgconfig package.  This argument must be a version comparison
dnl     specification accepted by pkgconfig; e.g. '>= 1.3'.
AC_DEFUN([SHTK_CHECK], [
    spec="shtk[]m4_default_nblank([ $1], [])"
    AC_MSG_CHECKING([for ${spec}])
    PKG_CHECK_EXISTS([${spec}], [found=yes], [found=no])
    if test "${found}" = yes; then
        SHTK_MODULESDIR="$("${PKG_CONFIG}" --variable=shtk_modulesdir shtk)"
        AC_SUBST([SHTK_MODULESDIR], ["${SHTK_MODULESDIR}"])
        SHTK_TOOL="$("${PKG_CONFIG}" --variable=shtk_tool shtk)"
        AC_SUBST([SHTK_TOOL], ["${SHTK_TOOL}"])
        AC_MSG_RESULT([${SHTK_TOOL}])
    else
        AC_MSG_RESULT([no])
        AC_MSG_ERROR([Could not find shtk])
    fi
])
