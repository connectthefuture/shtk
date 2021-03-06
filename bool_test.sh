# Copyright 2013 Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
# * Neither the name of Google Inc. nor the names of its contributors
#   may be used to endorse or promote products derived from this software
#   without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

shtk_import bool
shtk_import unittest


shtk_unittest_add_test check__true
check__true_test() {
    for value in yes Yes YES true True TRUE 1; do
        expect_command -s exit:0 shtk_bool_check "${value}"
    done
}


shtk_unittest_add_test check__false
check__false_test() {
    for value in no No NO false False FALSE 0; do
        expect_command -s exit:1 shtk_bool_check "${value}"
    done
}


shtk_unittest_add_test check__error__default_message
check__error__default_message_test() {
    for value in 'yes ' ' no' 'foo'; do
        expect_command -s exit:1 \
            -e match:"E: Invalid boolean value '${value}'" \
            shtk_bool_check "${value}"
    done
}


shtk_unittest_add_test check__error__custom_message
check__error__custom_message_test() {
    for value in 'yes ' ' no' 'foo'; do
        expect_command -s exit:1 \
            -e match:"E: WRONG ${value}" \
            shtk_bool_check "${value}" "WRONG ${value}"
    done
}
