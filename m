Return-Path: <linux-kernel+bounces-585504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A37A7946F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B54516692B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Apr 2025 17:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28F1F428C;
	Wed,  2 Apr 2025 17:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6qegvJ4"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034441F3BB0
	for <linux-kernel@vger.kernel.org>; Wed,  2 Apr 2025 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743615755; cv=none; b=Z+0zD+9upM9agypKaFvVT9+8i9rFvgzssdHKYVOfB3yvgfY1g1bTEJF4mdrLOjpIyaYtm5223Xi80kj6JaP8R7/4Glkw58wnh6vwpC2M6cHQfN1i2KQrcd2hjZrgkoOXWNaLI49GWiIWAZpDtHiPggLnTn1SQwWgDw1oxMf+55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743615755; c=relaxed/simple;
	bh=tbmzOu8oc31PGBNDZFXnFrX42d1QUV8nhlMeNuluIgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LN4Ydfa6+ayY6+Hm3MyNacRW5f8vGFKBltLNwHMavrgDD1pDyhsNYDSpUIi9cgnIbSve0eb4UwMYH9zBqcWTjekEbypIvAyUpdxNUSH0W0/n1KOmY6Q/JsiDORLa1oq+uReX/T1JEmeKUqe0Zpifd/5Q3M4D5oA3nCNALrgM2iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6qegvJ4; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85b41281b50so327439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Apr 2025 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743615752; x=1744220552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCIt9tYIDEGpxvCFrjrEJ4lAt8KNuZmfjyIc/WC7B0Q=;
        b=d6qegvJ42HY/qFZgiLKTCUGvcFKSOIYt19VKJB9NyUYRlXfGRlFaLgidO+CZqJklYn
         OdHekpBk+1LtVjkhdXz8gpbsDm+kK1+c0LbOhiqdkWjgv7yvI/K5fqlSgRxJPU3FKwKg
         K9NA3INL1TBkVqy++D/v31yi5kOGVQekKWogmOtbTN7ckKTuYrw96laTeEhrAxoyRRg8
         9aq6jy2m0L7oHn0c8NODKboln2bF9ol08ks6uRqfyNwE2s9VNgThCTVVToCnFuisP2uJ
         StfhCAbIruFiwM967+/zu5Nc/55ctAs/elHKM0eOaE9oFsAh8/oGsgweEO8yHoHDWFDo
         LwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743615752; x=1744220552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCIt9tYIDEGpxvCFrjrEJ4lAt8KNuZmfjyIc/WC7B0Q=;
        b=TZwthMStc1K80/jNlxpZmfaq+Nz6db1o5WlUmnGvPZ7OoVZwusL3zUkO+lVXaxlQ2n
         lRPcrCyi1pp4HwI6dwLy+kPXLeQ0ItXaOzUF0geP9y8n6/nlmkmsR0Iu1K9z1ewLPmlA
         qYsYxB8gr6i6zyPhOgf/763GhMFs84xKSTCyIT/dkdpXCF9C4CDNANUCz2gZZgbR2Qqt
         ZHqXZix7oH+4Ex5T28jWRSUQB2KFKo+YUz6yf7mLpT9k7EHfwytJcCiKNL73i0KzV5jU
         /Q+vKMNGEDE8hhhpC8BIIzZ3AObcw9QrNT9Lyrf2WL1xv0aNVlYaBj7XzGnCdeqzLLLe
         ehOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJNAchsjta22KIsNm9uOI0DGmHR+56mWQuhs7/f/5iR6xSJjaljX+c1L99hwkl470IIzNKNCPJXmL+LHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd9I/PHmzte2K1cTV40AMnnp32ZliFmxY2SCdHAm0KW+qqZvn5
	6cL7Fk57aEFE2ElxFc77Z+6pgxVR2JjlONzo9V+yavMquA+xDQJD
X-Gm-Gg: ASbGncsY3Hz4MYBwboER+ELrlQGwC8A+V6AarlW0uIVzI6A+8ywMyGL+cSnQucnpXv/
	YCYcP3HXhrLuzNoNk+hMR4UywLmov9mn4bXfJFtqYwuEI8fjtth9KEnDpTUIYjpwvMXbw5kwQgU
	wo3JvKa/AeBx2TPgsQNzvS74aiEvK1XR99DRyO3j4R1mmX6yEcRtYFiLZRXHITit7rpouNEm2T0
	DyrgxnJOskHLODIpyXrdoHpwJbnNEnazbtP2/SrlruszAp+2J8n6G1aEb5Aasm1ws5DpNSKIjvr
	2oj73dUFrdOPnVkFmFWUo/jAxPIkw3E8MeHjbUTukBYT4EkD0TYvphbNLOLCiQ1WkgATU0xhs4D
	g+7ai4hJuoE1x
X-Google-Smtp-Source: AGHT+IFfGtZPni22y+0xW+8U0Khw+cTygsnRaXQqfaDRuRmQ1klihTpldlBe8ndlWy3frQCWeXYYiQ==
X-Received: by 2002:a05:6e02:3713:b0:3d5:8922:77a0 with SMTP id e9e14a558f8ab-3d5e09c89a5mr234397865ab.18.1743615751996;
        Wed, 02 Apr 2025 10:42:31 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3d5d5af8369sm33439725ab.71.2025.04.02.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:42:31 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 18/54] selftests-dyndbg: add tools/testing/selftests/dynamic_debug/*
Date: Wed,  2 Apr 2025 11:41:20 -0600
Message-ID: <20250402174156.1246171-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402174156.1246171-1-jim.cromie@gmail.com>
References: <20250402174156.1246171-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a selftest script for dynamic-debug.  The config requires
CONFIG_TEST_DYNAMIC_DEBUG=m and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m,
which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
CONFIG_DYNAMIC_DEBUG_CORE=y

ATM this has just basic_tests(), which modify pr_debug() flags in the
builtin params module.  This means they're available to manipulate and
observe the effects in "cat control".

This is backported from another feature branch; the support-fns (thx
Lukas) have unused features at the moment, they'll get used shortly.

The script enables simple virtme-ng testing:

   [jimc@gandalf b0-ftrace]$ vrun_t
   virtme-ng 1.32+115.g07b109d
   doing: vng --name v6.14-rc4-60-gd5f48427de0c \
   	  --user root -v -p 4 -a dynamic_debug.verbose=3 V=1 \
	  -- ../tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
   virtme: waiting for virtiofsd to start
   ..

And add dynamic_debug to TARGETS, so `make run_tests` sees it properly

For the impatient, set TARGETS explicitly:

  bash-5.2# make TARGETS=dynamic_debug run_tests
  make[1]: ...
  TAP version 13
  1..1
  [   35.552922] dyndbg: read 3 bytes from userspace
  [   35.553099] dyndbg: query 0: "=_" mod:*
  [   35.553544] dyndbg: processed 1 queries, with 1778 matches, 0 errs

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
-r3 turn off green at end
    drop config dep on TEST_DYNAMIC_DEBUG,
    since basic-test uses builtin params

- check KCONFIG_CONFIG to avoid silly fails

Several tests are dependent upon config choices. Lets avoid failing
where that is noise.

The KCONFIG_CONFIG var exists to convey the config-file around.  If
the var names a file, read it and extract the relevant CONFIG items,
and use them to skip the dependent tests, thus avoiding the fails that
would follow, and the disruption to whatever CI is running these
selftests.

If the envar doesn't name a config-file, ".config" is assumed.

CONFIG_DYNAMIC_DEBUG=y:

basic-tests() and comma-terminator-tests() test for the presence of
the builtin pr_debugs in module/main.c, which I deemed stable and
therefore safe to count.  That said, the test fails if only
CONFIG_DYNAMIC_DEBUG_CORE=y is set.  It could be rewritten to test
against test-dynamic-debug.ko, but that just trades one config
dependence for another.

CONFIG_TEST_DYNAMIC_DEBUG=m

As written, test_percent_splitting() modprobes test_dynamic_debug,
enables several classes, and count them.  It could be re-written to
work for the builtin module also, but builtin test modules are not a
common or desirable build/config.

CONFIG_TEST_DYNAMIC_DEBUG=m && CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m

test_mod_submod() recaps the bug found in DRM-CI where drivers werent
enabled by drm.debug=<bits>.  It modprobes both test_dynamic_debug &
test_dynamic_debug_submod, so it depends on a loadable modules config.

It could be rewritten to work in a builtin parent config; DRM=y is
common enough to be pertinent, but testing that config also wouldn't
really test anything more fully than all-loadable modules, since they
default together.

generalize-test-env
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/Makefile              |   1 +
 .../testing/selftests/dynamic_debug/Makefile  |   9 +
 tools/testing/selftests/dynamic_debug/config  |   7 +
 .../dynamic_debug/dyndbg_selftest.sh          | 257 ++++++++++++++++++
 5 files changed, 275 insertions(+)
 create mode 100644 tools/testing/selftests/dynamic_debug/Makefile
 create mode 100644 tools/testing/selftests/dynamic_debug/config
 create mode 100755 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c5fcbd9e408..1192ad6c65c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8140,6 +8140,7 @@ S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug*.c
+F:	tools/testing/selftests/dynamic_debug/*
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 8daac70c2f9d..b6a323c7f986 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -26,6 +26,7 @@ TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
 TARGETS += drivers/platform/x86/intel/ifs
 TARGETS += dt
+TARGETS += dynamic_debug
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
diff --git a/tools/testing/selftests/dynamic_debug/Makefile b/tools/testing/selftests/dynamic_debug/Makefile
new file mode 100644
index 000000000000..6d06fa7f1040
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# borrowed from Makefile for user memory selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := dyndbg_selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dynamic_debug/config b/tools/testing/selftests/dynamic_debug/config
new file mode 100644
index 000000000000..0f906ff53908
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/config
@@ -0,0 +1,7 @@
+
+# basic tests ref the builtin params module
+CONFIG_DYNAMIC_DEBUG=m
+
+# more testing is possible with these
+# CONFIG_TEST_DYNAMIC_DEBUG=m
+# CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
new file mode 100755
index 000000000000..465fad3f392c
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,257 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+V=${V:=0}  # invoke as V=1 $0  for global verbose
+RED="\033[0;31m"
+GREEN="\033[0;32m"
+YELLOW="\033[0;33m"
+BLUE="\033[0;34m"
+MAGENTA="\033[0;35m"
+CYAN="\033[0;36m"
+NC="\033[0;0m"
+error_msg=""
+
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=y ${NC}"
+    exit 0 # nothing to test here, no good reason to fail.
+}
+
+# need info to avoid failures due to untestable configs
+
+[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=".config"
+if [ -f "$KCONFIG_CONFIG" ]; then
+    echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
+    grep -q "CONFIG_DYNAMIC_DEBUG=y" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=m" $KCONFIG_CONFIG ; LACK_TMOD=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m" $KCONFIG_CONFIG ; LACK_TMOD_SUBMOD=$?
+    if [ $V -eq 1 ]; then
+	echo LACK_DD_BUILTIN: $LACK_DD_BUILTIN
+	echo LACK_TMOD: $LACK_TMOD
+	echo LACK_TMOD_SUBMOD: $LACK_TMOD_SUBMOD
+    fi
+else
+    LACK_DD_BUILTIN=0
+    LACK_TMOD=0
+    LACK_TMOD_SUBMOD=0
+fi
+
+function vx () {
+    echo $1 > /sys/module/dynamic_debug/parameters/verbose
+}
+
+function ddgrep () {
+    grep $1 /proc/dynamic_debug/control
+}
+
+function doprints () {
+    cat /sys/module/test_dynamic_debug/parameters/do_prints
+}
+
+function ddcmd () {
+    exp_exit_code=0
+    num_args=$#
+    if [ "${@:$#}" = "pass" ]; then
+	num_args=$#-1
+    elif [ "${@:$#}" = "fail" ]; then
+        num_args=$#-1
+	exp_exit_code=1
+    fi
+    args=${@:1:$num_args}
+    output=$((echo "$args" > /proc/dynamic_debug/control) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 5 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function handle_exit_code() {
+    local exp_exit_code=0
+    [ $# == 4 ] && exp_exit_code=$4
+    if [ $3 -ne $exp_exit_code ]; then
+        echo -e "${RED}: $BASH_SOURCE:$1 $2() expected to exit with code $exp_exit_code"
+	[ $3 == 1 ] && echo "Error: '$error_msg'"
+        exit
+    fi
+}
+
+# $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
+# $2 - number of times the pattern passed in $1 is expected to match
+# $3 - optional can be set either to "-r" or "-v"
+#       "-r" means relaxed matching in this case pattern provided in $1 is passed
+#       as is without enclosing it with spaces
+#       "-v" prints matching lines
+# $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
+function check_match_ct {
+    pattern="\s$1\s"
+    exp_cnt=0
+
+    [ "$3" == "-r" ] && pattern="$1"
+    let cnt=$(ddgrep "$pattern" | wc -l)
+    if [ $V -eq 1 ] || [ "$3" == "-v" ] || [ "$4" == "-v" ]; then
+        echo -ne "${BLUE}" && ddgrep $pattern && echo -ne "${NC}"
+    fi
+    [ $# -gt 1 ] && exp_cnt=$2
+    if [ $cnt -ne $exp_cnt ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO check failed expected $exp_cnt on $1, got $cnt"
+        exit
+    else
+        echo ": $cnt matches on $1"
+    fi
+}
+
+# $1 - trace instance name
+# #2 - if > 0 then directory is expected to exist, if <= 0 then otherwise
+# $3 - "-v" for verbose
+function check_trace_instance_dir {
+    if [ -e /sys/kernel/tracing/instances/$1 ]; then
+        if [ "$3" == "-v" ] ; then
+            echo "ls -l /sys/kernel/tracing/instances/$1: "
+            ls -l /sys/kernel/tracing/instances/$1
+        fi
+	if [ $2 -le 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does exist"
+	    exit
+	fi
+    else
+	if [ $2 -gt 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does not exist"
+	    exit
+        fi
+    fi
+}
+
+function tmark {
+    echo $* > /sys/kernel/tracing/trace_marker
+}
+
+# $1 - trace instance name
+# $2 - line number
+# $3 - if > 0 then the instance is expected to be opened, otherwise
+# the instance is expected to be closed
+function check_trace_instance {
+    output=$(tail -n9 /proc/dynamic_debug/control | grep ": Opened trace instances" \
+	    | xargs -n1 | grep $1)
+    if [ "$output" != $1 ] && [ $3 -gt 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not opened"
+        exit
+    fi
+    if [ "$output" == $1 ] && [ $3 -le 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not closed"
+        exit
+    fi
+}
+
+function is_trace_instance_opened {
+    check_trace_instance $1 $BASH_LINENO 1
+}
+
+function is_trace_instance_closed {
+    check_trace_instance $1 $BASH_LINENO 0
+}
+
+# $1 - trace instance directory to delete
+# $2 - if > 0 then directory is expected to be deleted successfully, if <= 0 then otherwise
+function del_trace_instance_dir() {
+    exp_exit_code=1
+    [ $2 -gt 0 ] && exp_exit_code=0
+    output=$((rmdir /sys/kernel/debug/tracing/instances/$1) 2>&1)
+    exit_code=$?
+    error_msg=$(echo $output | cut -d ":" -f 3 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function error_log_ref {
+    # to show what I got
+    : echo "# error-log-ref: $1"
+    : echo cat \$2
+}
+
+function ifrmmod {
+    lsmod | grep $1 2>&1>/dev/null && rmmod $1
+}
+
+# $1 - text to search for
+function search_trace() {
+    search_trace_name 0 1 $1
+}
+
+# $1 - trace instance name, 0 for global event trace
+# $2 - line number counting from the bottom
+# $3 - text to search for
+function search_trace_name() {
+	if [ "$1" = "0" ]; then
+	    buf=$(cat /sys/kernel/debug/tracing/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/trace | head -1 | sed -e 's/^[[:space:]]*//')
+	else
+	    buf=$(cat /sys/kernel/debug/tracing/instances/$1/trace)
+	    line=$(tail -$2 /sys/kernel/debug/tracing/instances/$1/trace | head -1 | \
+		   sed -e 's/^[[:space:]]*//')
+	fi
+	if [ $2 = 0 ]; then
+	    # whole-buf check
+	    output=$(echo $buf | grep "$3")
+	else
+	    output=$(echo $line | grep "$3")
+	fi
+	if [ "$output" = "" ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO search for '$3' failed \
+		    in line '$line' or '$buf'"
+	    exit
+	fi
+	if [ $V = 1 ]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+        fi
+}
+
+# $1 - error message to check
+function check_err_msg() {
+    if [ "$error_msg" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error message '$error_msg' \
+		does not match with '$1'"
+        exit
+    fi
+}
+
+function basic_tests {
+    echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
+    ddcmd =_ # zero everything
+    check_match_ct =p 0
+
+    # module params are builtin to handle boot args
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module params +mpf
+    check_match_ct =pmf 4
+
+    # multi-cmd input, newline separated, with embedded comments
+    cat <<"EOF" > /proc/dynamic_debug/control
+      module params =_				# clear params
+      module params +mf				# set flags
+      module params func parse_args +sl		# other flags
+EOF
+    check_match_ct =mf 3
+    check_match_ct =mfsl 1
+    ddcmd =_
+}
+
+tests_list=(
+    basic_tests
+)
+
+# Run tests
+
+ifrmmod test_dynamic_debug_submod
+ifrmmod test_dynamic_debug
+
+for test in "${tests_list[@]}"
+do
+    $test
+    echo ""
+done
+echo -en "${GREEN}# Done on: "
+date
+echo -en "${NC}"
-- 
2.49.0


