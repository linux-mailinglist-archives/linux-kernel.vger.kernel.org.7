Return-Path: <linux-kernel+bounces-898255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82AC54B42
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCB254E1478
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8403A2EBDC7;
	Wed, 12 Nov 2025 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qr29ueHW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A692765FF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762985993; cv=none; b=u9zMdcQsG+LpcLbFQnws5g8Hh/FwFIqPdMK4WFQapzDqYzZoVu5kFEMl34kJzIRFhKpBRR2Cl4pAfEWlyeVwfjSaEhPBP4OsYAXcDWnNvoZMJAaWxm4/i9bfjBA27GPL7LRfPyBtchSUba/bkdeXAXpMhwNfccUHnFNDfh9+IUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762985993; c=relaxed/simple;
	bh=n4Tqndp+kJVHsZQsNWwWa7X/ogK2HmtX2Vdn4QbD6QU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=V9A9eRSdGClr/STlbRKmYPDMZgFgFLsEW780o6MCf9LsN9fwM2huWHBkPILgMAnkblA/EHGIBR/Rke7ju7Qf+MMSird9REkpYDAxaOyAxHqQCrQnFGEPO0VH9lVO7rljqPGOlWinB9bLDHsXfOMQT+C4rg9upe9R9cBGRqm7Q9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qr29ueHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2458C2BC86;
	Wed, 12 Nov 2025 22:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762985992;
	bh=n4Tqndp+kJVHsZQsNWwWa7X/ogK2HmtX2Vdn4QbD6QU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=qr29ueHWhJYjEjj6bR4JAuPiV7+UGQRFixLDdjex0bnomWpYfbRpfbqXvOcOwwgSA
	 eGujX4KJWM9kM2Q9MTOcuId4T7n2jHDXHU7G8RjE5UYQ1/PR+3SeLpfUjeifu4PRq4
	 LcFQQhL8D+YMmD6kYpPE2q4LmKQMpMC5Dl/HY3HQqjFBDlVtej8N6SQWNtJxUdsQJI
	 yR+snqAhtWYsowEFBy4j3QMjFrTICURUSf1z6stu3/lWiZPVvZlHud295j6Bwq7hjZ
	 K30pd0DNYVyxRGdrMSZLPo8Z1lWqD46MjIUSFt1P4A9F/STd79Q1TGwauHNahK7G/6
	 vf7922ca7b54Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vJJCA-00000001EWM-3ql6;
	Wed, 12 Nov 2025 17:20:06 -0500
Message-ID: <20251112222006.772387903@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 12 Nov 2025 17:19:48 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-next][PATCH 2/5] selftests/verification: Add initial RV tests
References: <20251112221946.389142361@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

Add a series of tests to validate the RV tracefs API and basic
functionality.

* available monitors:
    Check that all monitors (from the monitors folder) appear as
    available and have a description. Works with nested monitors.

* enable/disable:
    Enable and disable all monitors and validate both the enabled file
    and the enabled_monitors. Check that enabling container monitors
    enables all nested monitors.

* reactors:
    Set all reactors and validate the setting, also for nested monitors.

* wwnr with printk:
    wwnr is broken on purpose, run it with a load and check that the
    printk reactor works. Also validate disabling reacting_on or
    monitoring_on prevents reactions.

These tests use the ftracetest suite.

Acked-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20251017115203.140080-3-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 MAINTAINERS                                   |  1 +
 .../testing/selftests/verification/.gitignore |  2 +
 tools/testing/selftests/verification/Makefile |  8 ++
 tools/testing/selftests/verification/config   |  1 +
 tools/testing/selftests/verification/settings |  1 +
 .../selftests/verification/test.d/functions   | 39 ++++++++++
 .../test.d/rv_monitor_enable_disable.tc       | 75 +++++++++++++++++++
 .../verification/test.d/rv_monitor_reactor.tc | 68 +++++++++++++++++
 .../test.d/rv_monitors_available.tc           | 18 +++++
 .../verification/test.d/rv_wwnr_printk.tc     | 30 ++++++++
 .../verification/verificationtest-ktap        |  8 ++
 11 files changed, 251 insertions(+)
 create mode 100644 tools/testing/selftests/verification/.gitignore
 create mode 100644 tools/testing/selftests/verification/Makefile
 create mode 100644 tools/testing/selftests/verification/config
 create mode 100644 tools/testing/selftests/verification/settings
 create mode 100644 tools/testing/selftests/verification/test.d/functions
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_monitors_available.tc
 create mode 100644 tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
 create mode 100755 tools/testing/selftests/verification/verificationtest-ktap

diff --git a/MAINTAINERS b/MAINTAINERS
index ddecf1ef3bed..95c32cd3b524 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22498,6 +22498,7 @@ F:	Documentation/trace/rv/
 F:	include/linux/rv.h
 F:	include/rv/
 F:	kernel/trace/rv/
+F:	tools/testing/selftests/verification/
 F:	tools/verification/
 
 RUST
diff --git a/tools/testing/selftests/verification/.gitignore b/tools/testing/selftests/verification/.gitignore
new file mode 100644
index 000000000000..2659417cb2c7
--- /dev/null
+++ b/tools/testing/selftests/verification/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+logs
diff --git a/tools/testing/selftests/verification/Makefile b/tools/testing/selftests/verification/Makefile
new file mode 100644
index 000000000000..aa8790c22a71
--- /dev/null
+++ b/tools/testing/selftests/verification/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+all:
+
+TEST_PROGS := verificationtest-ktap
+TEST_FILES := test.d settings
+EXTRA_CLEAN := $(OUTPUT)/logs/*
+
+include ../lib.mk
diff --git a/tools/testing/selftests/verification/config b/tools/testing/selftests/verification/config
new file mode 100644
index 000000000000..43072c1c38f4
--- /dev/null
+++ b/tools/testing/selftests/verification/config
@@ -0,0 +1 @@
+CONFIG_RV=y
diff --git a/tools/testing/selftests/verification/settings b/tools/testing/selftests/verification/settings
new file mode 100644
index 000000000000..e7b9417537fb
--- /dev/null
+++ b/tools/testing/selftests/verification/settings
@@ -0,0 +1 @@
+timeout=0
diff --git a/tools/testing/selftests/verification/test.d/functions b/tools/testing/selftests/verification/test.d/functions
new file mode 100644
index 000000000000..ec36a092f56e
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/functions
@@ -0,0 +1,39 @@
+check_requires() { # Check required files, monitors and reactors
+	for i in "$@" ; do
+		p=${i%:program}
+		m=${i%:monitor}
+		r=${i%:reactor}
+		if [ $p != $i ]; then
+			if ! which $p ; then
+				echo "Required program $p is not found."
+				exit_unresolved
+			fi
+		elif [ $m != $i ]; then
+			if ! grep -wq $m available_monitors ; then
+				echo "Required monitor $m is not configured."
+				exit_unsupported
+			fi
+		elif [ $r != $i ]; then
+			if ! grep -wq $r available_reactors ; then
+				echo "Required reactor $r is not configured."
+				exit_unsupported
+			fi
+		elif [ ! -e $i ]; then
+			echo "Required feature interface $i doesn't exist."
+			exit_unsupported
+		fi
+	done
+}
+
+initialize_system() { # Reset RV to initial-state
+	echo > enabled_monitors
+	for m in monitors/*; do
+		echo nop > $m/reactors || true
+	done
+	echo 1 > monitoring_on
+	echo 1 > reacting_on || true
+}
+
+finish_system() {
+	initialize_system
+}
diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
new file mode 100644
index 000000000000..f29236defb5a
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_enable_disable.tc
@@ -0,0 +1,75 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test monitor enable/disable
+
+test_simple_monitor() {
+    local monitor="$1"
+    local prefix="$2" # nested monitors
+
+    echo 1 > "monitors/$prefix$monitor/enable"
+    grep -q "$monitor$" enabled_monitors
+
+    echo 0 > "monitors/$prefix$monitor/enable"
+    ! grep -q "$monitor$" enabled_monitors
+
+    echo "$monitor" >> enabled_monitors
+    grep -q 1 "monitors/$prefix$monitor/enable"
+
+    echo "!$monitor" >> enabled_monitors
+    grep -q 0 "monitors/$prefix$monitor/enable"
+}
+
+test_container_monitor() {
+    local monitor="$1"
+	local nested
+
+    echo 1 > "monitors/$monitor/enable"
+    grep -q "^$monitor$" enabled_monitors
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "^$monitor:$nested$" enabled_monitors
+    done
+	test -n "$nested"
+
+    echo 0 > "monitors/$monitor/enable"
+    ! grep -q "^$monitor$" enabled_monitors
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        ! grep -q "^$monitor:$nested$" enabled_monitors
+    done
+
+    echo "$monitor" >> enabled_monitors
+    grep -q 1 "monitors/$monitor/enable"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "^$monitor:$nested$" enabled_monitors
+    done
+
+    echo "!$monitor" >> enabled_monitors
+    grep -q 0 "monitors/$monitor/enable"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+		test_simple_monitor "$nested" "$monitor/"
+    done
+}
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    if find "$monitor_dir" -mindepth 1 -type d | grep -q .; then
+        test_container_monitor "$monitor"
+    else
+        test_simple_monitor "$monitor"
+    fi
+done
+
+! echo non_existent_monitor > enabled_monitors
+! grep -q "^non_existent_monitor$" enabled_monitors
diff --git a/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
new file mode 100644
index 000000000000..2958bf849338
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitor_reactor.tc
@@ -0,0 +1,68 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test monitor reactor setting
+# requires: available_reactors
+
+test_monitor_reactor() {
+    local monitor="$1"
+    local prefix="$2" # nested monitors
+
+    while read -r reactor; do
+        [ "$reactor" = nop ] && continue
+
+        echo "$reactor" > "monitors/$prefix$monitor/reactors"
+        grep -q "\\[$reactor\\]" "monitors/$prefix$monitor/reactors"
+    done < available_reactors
+
+    echo nop > "monitors/$prefix$monitor/reactors"
+    grep -q "\\[nop\\]" "monitors/$prefix$monitor/reactors"
+}
+
+test_container_monitor() {
+    local monitor="$1"
+	local nested
+
+    while read -r reactor; do
+        [ "$reactor" = nop ] && continue
+
+        echo "$reactor" > "monitors/$monitor/reactors"
+        grep -q "\\[$reactor\\]" "monitors/$monitor/reactors"
+
+        for nested_dir in "monitors/$monitor"/*; do
+            [ -d "$nested_dir" ] || continue
+            nested=$(basename "$nested_dir")
+            grep -q "\\[$reactor\\]" "monitors/$monitor/$nested/reactors"
+        done
+    done < available_reactors
+	test -n "$nested"
+
+    echo nop > "monitors/$monitor/reactors"
+    grep -q "\\[nop\\]" "monitors/$monitor/reactors"
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        grep -q "\\[nop\\]" "monitors/$monitor/$nested/reactors"
+    done
+
+    for nested_dir in "monitors/$monitor"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+        test_monitor_reactor "$nested" "$monitor/"
+    done
+}
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    if find "$monitor_dir" -mindepth 1 -type d | grep -q .; then
+        test_container_monitor "$monitor"
+    else
+        test_monitor_reactor "$monitor"
+    fi
+done
+
+monitor=$(ls /sys/kernel/tracing/rv/monitors -1 | head -n 1)
+test -f "monitors/$monitor/reactors"
+! echo non_existent_reactor > "monitors/$monitor/reactors"
+! grep -q "\\[non_existent_reactor\\]" "monitors/$monitor/reactors"
diff --git a/tools/testing/selftests/verification/test.d/rv_monitors_available.tc b/tools/testing/selftests/verification/test.d/rv_monitors_available.tc
new file mode 100644
index 000000000000..e6a4a1410690
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_monitors_available.tc
@@ -0,0 +1,18 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Check available monitors
+
+for monitor_dir in monitors/*; do
+    monitor=$(basename "$monitor_dir")
+
+    grep -q "^$monitor$" available_monitors
+    grep -q . "$monitor_dir"/desc
+
+    for nested_dir in "$monitor_dir"/*; do
+        [ -d "$nested_dir" ] || continue
+        nested=$(basename "$nested_dir")
+
+        grep -q "^$monitor:$nested$" available_monitors
+		grep -q . "$nested_dir"/desc
+    done
+done
diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
new file mode 100644
index 000000000000..5a59432b1d93
--- /dev/null
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -0,0 +1,30 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# description: Test wwnr monitor with printk reactor
+# requires: available_reactors wwnr:monitor printk:reactor stress-ng:program
+
+load() { # returns true if there was a reaction
+	local lines_before num
+	num=$((($(nproc) + 1) / 2))
+	lines_before=$(dmesg | wc -l)
+	stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
+	dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr does not allow event"
+}
+
+echo 1 > monitors/wwnr/enable
+echo printk > monitors/wwnr/reactors
+
+load
+
+echo 0 > monitoring_on
+! load
+echo 1 > monitoring_on
+
+load
+
+echo 0 > reacting_on
+! load
+echo 1 > reacting_on
+
+echo nop > monitors/wwnr/reactors
+echo 0 > monitors/wwnr/enable
diff --git a/tools/testing/selftests/verification/verificationtest-ktap b/tools/testing/selftests/verification/verificationtest-ktap
new file mode 100755
index 000000000000..18f7fe324e2f
--- /dev/null
+++ b/tools/testing/selftests/verification/verificationtest-ktap
@@ -0,0 +1,8 @@
+#!/bin/sh -e
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ftracetest-ktap: Wrapper to integrate ftracetest with the kselftest runner
+#
+# Copyright (C) Arm Ltd., 2023
+
+../ftrace/ftracetest -K -v --rv ../verification
-- 
2.51.0



