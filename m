Return-Path: <linux-kernel+bounces-746346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D65DB125AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402AB7BE0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63912269817;
	Fri, 25 Jul 2025 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lzc9WVq+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EA125F96D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753475661; cv=none; b=QT/+vFHbuLbamFkp6BDp7PUxassv1LUPbdi33Ay3cSy/QAfuuujll+Gv5LiP7vwpGXh2h+YfWGJLlzMhHAihmWIvjurTjRLXisIvfcHPxOd4fL/sQNbRH5K3DwDmmgWL+SITcZc1/rTTQt2FAr9aDYewd/shv+5Sn8gSSFz59Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753475661; c=relaxed/simple;
	bh=5npNIdNOxU6nl+F6cCfxhjYp6GZooHL2IR9nKtVZYgo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=i3Db7NhNhFUPC3VHn9cPK8UMZ4g7kac2oiJptZKOZtLbBHenym02E0Uv3wjaoKHD0V6HZjpuI/21Qz8jenUo0Ns30Bm48vI32aDSFPb9Mpb+ddrVOZykuR0lWmSCdZMx7zoIFpNCYeb+OMs9UfP8ekbwFExrAzsa9X1nvwSO3r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lzc9WVq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223C3C4CEF4;
	Fri, 25 Jul 2025 20:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753475661;
	bh=5npNIdNOxU6nl+F6cCfxhjYp6GZooHL2IR9nKtVZYgo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Lzc9WVq+3C3x0hB1WdjsVutatSsD/e1wJ/LbbSthO/4DehG/W//umUHjYefaiuT2l
	 C8l/v39eHeIPpOXVOVo5v7Wysx4L6ciZo+UCID6qlKVnCVEwyX8Ye8iih7TTcrJeLj
	 IwTGPyPrPlwIGycxgdug5riadutLfMeXZUegtBk0BVa5k/AqPipygdrCOUOStMQMZz
	 mSAFaE+RxJSW8iz40ASHiadC6No5e7sFfpB/vQIUN02zlvYdDbwTR72N9S1JT3qRHo
	 t43G9u37DL4+kRSaHh+2ExMXwRTZUjNE6xyWRI3LS1jFgnNnG6Mqi3JVcPoMUQp816
	 LkL/5JPcoutuA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufP7b-00000001QlM-1ANg;
	Fri, 25 Jul 2025 16:34:27 -0400
Message-ID: <20250725203427.130326086@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 16:34:16 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Nam Cao <namcao@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 19/25] verification/rvgen: Organise Kconfig entries for nested monitors
References: <20250725203357.087558746@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

The current behaviour of rvgen when running with the -a option is to
append the necessary lines at the end of the configuration for Kconfig,
Makefile and tracepoints.
This is not always the desired behaviour in case of nested monitors:
while tracepoints are not affected by nesting and the Makefile's only
requirement is that the parent monitor is built before its children, in
the Kconfig it is better to have children defined right after their
parent, otherwise the result has wrong indentation:

[*]   foo_parent monitor
[*]     foo_child1 monitor
[*]     foo_child2 monitor
[*]   bar_parent monitor
[*]     bar_child1 monitor
[*]     bar_child2 monitor
[*]   foo_child3 monitor
[*]   foo_child4 monitor

Adapt rvgen to look for a different marker for nested monitors in the
Kconfig file and append the line right after the last sibling, instead
of the last monitor.
Also add the marker when creating a new parent monitor.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Link: https://lore.kernel.org/20250723161240.194860-5-gmonaco@redhat.com
Reviewed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                     |  5 +++++
 tools/verification/rvgen/rvgen/container.py | 10 ++++++++++
 tools/verification/rvgen/rvgen/generator.py | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index c11bf7e61ebf..26017378f79b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -43,6 +43,7 @@ config RV_PER_TASK_MONITORS
 
 source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
+
 source "kernel/trace/rv/monitors/sched/Kconfig"
 source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
@@ -50,9 +51,13 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
+# Add new sched monitors here
+
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
+# Add new rtapp monitors here
+
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/tools/verification/rvgen/rvgen/container.py b/tools/verification/rvgen/rvgen/container.py
index 47d8ab2ad3ec..51f188530b4d 100644
--- a/tools/verification/rvgen/rvgen/container.py
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -20,3 +20,13 @@ class Container(generator.RVGenerator):
         main_h = self.main_h
         main_h = main_h.replace("%%MODEL_NAME%%", self.name)
         return main_h
+
+    def fill_kconfig_tooltip(self):
+        """Override to produce a marker for this container in the Kconfig"""
+        container_marker = self._kconfig_marker(self.name) + "\n"
+        result = super().fill_kconfig_tooltip()
+        if self.auto_patch:
+            self._patch_file("Kconfig",
+                             self._kconfig_marker(), container_marker)
+            return result
+        return result + container_marker
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 19d0078a3803..3441385c1177 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -137,7 +137,8 @@ class RVGenerator:
         kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
-    def __patch_file(self, file, marker, line):
+    def _patch_file(self, file, marker, line):
+        assert self.auto_patch
         file_to_patch = os.path.join(self.rv_dir, file)
         content = self._read_file(file_to_patch)
         content = content.replace(marker, line + "\n" + marker)
@@ -146,7 +147,7 @@ class RVGenerator:
     def fill_tracepoint_tooltip(self):
         monitor_class_type = self.fill_monitor_class_type()
         if self.auto_patch:
-            self.__patch_file("rv_trace.h",
+            self._patch_file("rv_trace.h",
                             "// Add new monitors based on CONFIG_%s here" % monitor_class_type,
                             "#include <monitors/%s/%s_trace.h>" % (self.name, self.name))
             return "  - Patching %s/rv_trace.h, double check the result" % self.rv_dir
@@ -156,10 +157,15 @@ Add this line where other tracepoints are included and %s is defined:
 #include <monitors/%s/%s_trace.h>
 """ % (self.rv_dir, monitor_class_type, self.name, self.name)
 
+    def _kconfig_marker(self, container=None) -> str:
+        return "# Add new %smonitors here" % (container + " "
+                                              if container else "")
+
     def fill_kconfig_tooltip(self):
         if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
+            # monitors with a container should stay together in the Kconfig
+            self._patch_file("Kconfig",
+                             self._kconfig_marker(self.parent),
                             "source \"kernel/trace/rv/monitors/%s/Kconfig\"" % (self.name))
             return "  - Patching %s/Kconfig, double check the result" % self.rv_dir
 
@@ -172,7 +178,7 @@ source \"kernel/trace/rv/monitors/%s/Kconfig\"
         name = self.name
         name_up = name.upper()
         if self.auto_patch:
-            self.__patch_file("Makefile",
+            self._patch_file("Makefile",
                             "# Add new monitors here",
                             "obj-$(CONFIG_RV_MON_%s) += monitors/%s/%s.o" % (name_up, name, name))
             return "  - Patching %s/Makefile, double check the result" % self.rv_dir
-- 
2.47.2



