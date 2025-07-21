Return-Path: <linux-kernel+bounces-738897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7147FB0BEC8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13CA81888D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 08:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B41288C0E;
	Mon, 21 Jul 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkDgWkJv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D288C0A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753086276; cv=none; b=B7d//a3o/lFpSN2oa9DNtZ3DWQ7tYgAkeFd5nfY2+IV4VAohVaCdIX0OWbtiT99UymCai4lFYBNVieYN64fNG1FySfvF2Sw65NEc0cOGH1bNqLWkPo8MmX879l8COFfqHV+vR0ar+3aVTd9PURveV3TznRcJSqtTU6ucUIhdyWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753086276; c=relaxed/simple;
	bh=RZnMlp/XHUE1XwilHDi0KtYprzOZta5gm0/F/CgWajM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czPgUrPRg/3s2DqsLrjneAkdM7D301cdVik311nLwcX4wdURRJ6r6bKYSCOg86DIBh4kA1p68FTdvkRJGv62ymC1QnvsJvWNgkFzfGI2ktUrfEap3B1LyT68VqkzhT/9vIN6OiKNdHPZZccXFk+ZN4sxItE0GKiq2JxeC7jGRWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DkDgWkJv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753086274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aWlRIRPsUX6yaqoJxdmSpBkAg6xtzZpaMzMvZTZJgfU=;
	b=DkDgWkJvISwh5zVRVM+H3TLMXUX/bjVfY17lJD/E15EyX3LE+L2jPGW0y/hP/XRNuY+AwI
	nOBfM/8d06k/DeuKd5DRi9L3tyN5osn7Zp2uzmL5bMyRjklore3Hb/h7PPsFUmDiR2ytUi
	izK1q7e0QQBbcQgEZ8MT5IiEYEpIJbE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-ZkbUaA8aNTa5kPZlJCdfUQ-1; Mon,
 21 Jul 2025 04:24:30 -0400
X-MC-Unique: ZkbUaA8aNTa5kPZlJCdfUQ-1
X-Mimecast-MFC-AGG-ID: ZkbUaA8aNTa5kPZlJCdfUQ_1753086269
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 656981955F44;
	Mon, 21 Jul 2025 08:24:29 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.44.32.136])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBE98195608D;
	Mon, 21 Jul 2025 08:24:24 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>,
	Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v4 08/14] verification/rvgen: Organise Kconfig entries for nested monitors
Date: Mon, 21 Jul 2025 10:23:18 +0200
Message-ID: <20250721082325.71554-9-gmonaco@redhat.com>
In-Reply-To: <20250721082325.71554-1-gmonaco@redhat.com>
References: <20250721082325.71554-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 kernel/trace/rv/Kconfig                     |  5 +++++
 tools/verification/rvgen/rvgen/container.py | 10 ++++++++++
 tools/verification/rvgen/rvgen/generator.py | 16 +++++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index c11bf7e61ebf0..26017378f79b8 100644
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
index 47d8ab2ad3ec4..96dbb4818adf5 100644
--- a/tools/verification/rvgen/rvgen/container.py
+++ b/tools/verification/rvgen/rvgen/container.py
@@ -20,3 +20,13 @@ class Container(generator.RVGenerator):
         main_h = self.main_h
         main_h = main_h.replace("%%MODEL_NAME%%", self.name)
         return main_h
+
+    def fill_kconfig_tooltip(self):
+        """Override to produce a marker for this container in the Kconfig"""
+        container_marker = self._container_marker(self.name) + "\n"
+        result = super().fill_kconfig_tooltip()
+        if self.auto_patch:
+            self._patch_file("Kconfig",
+                             self._container_marker(), container_marker)
+            return result
+        return result + container_marker
diff --git a/tools/verification/rvgen/rvgen/generator.py b/tools/verification/rvgen/rvgen/generator.py
index 19d0078a38032..1ee184ce57342 100644
--- a/tools/verification/rvgen/rvgen/generator.py
+++ b/tools/verification/rvgen/rvgen/generator.py
@@ -137,7 +137,8 @@ class RVGenerator:
         kconfig = kconfig.replace("%%MONITOR_DEPS%%", monitor_deps)
         return kconfig
 
-    def __patch_file(self, file, marker, line):
+    def _patch_file(self, file, marker, line):
+        assert(self.auto_patch)
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
 
+    def _container_marker(self, container = None) -> str:
+        return "# Add new %smonitors here" % (container + " "
+                                              if container else "")
+
     def fill_kconfig_tooltip(self):
         if self.auto_patch:
-            self.__patch_file("Kconfig",
-                            "# Add new monitors here",
+            # monitors with a container should stay together in the Kconfig
+            self._patch_file("Kconfig",
+                             self._container_marker(self.parent),
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
2.50.1


