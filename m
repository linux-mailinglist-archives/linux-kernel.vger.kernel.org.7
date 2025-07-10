Return-Path: <linux-kernel+bounces-724688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 682A9AFF5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5D07BAA7F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126321990D8;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYKIxKC/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443BF72621
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107552; cv=none; b=Fb4cRJcLGxxMfkAEiho7CxKAtp2g38WX8mPox526Crse7B6NR6Ncv/glwdl/ezhzZjVy23lB+AWq++ssh8lq4PSq65VFwcDhdGNkstfmGaeKDa0R8VGt4jYO1Q1o9fQzC9dA8iV6wMtCifJ28fsNX4SKZNUD2PTfmSNGT5IAkGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107552; c=relaxed/simple;
	bh=53c3RWRNhOFX4zFUIYNXf4dlgkJh96GohXYWkK3mTsg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Qh4IOLvD3gDgvH8Ox33xKjm+V25kEEQhNjv8l1ORTiY+M/UTouNaez0gNAV7oTBxLunARw73UPsLjpL/vo3sUTVfzdBNVWePFmPDR+vy8NjmJqRgNqBqfmqfrHtEJ8yUvyTT9szJjzFrhzJL3eALGDn9/ltCWhdooht/o+R7Qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYKIxKC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253B6C4CEFD;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=53c3RWRNhOFX4zFUIYNXf4dlgkJh96GohXYWkK3mTsg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=dYKIxKC/2kVV8ANHajMqPsOgeASypXE5LTK67SWfaJ4ki0hh6HcMZ1do7h/OIzfnt
	 DqgYIg8k61tfx4QXWcMJKpF0iAVoyA0rt7xZdVWgRs8+ffp5EexEVz5ue8hZNIFUP+
	 RI0uLlOK2E1i5en6Yyk2niNEE513fUwJOXbZYGiwZMuG3XYTHPSXnYZrYQKPbIhEvJ
	 v5H/mRapfRWZTKNgATOGEOIHeDuZLf7AMK4crS6SwYe3CC2zvtuTsOD9FzpJtemZhG
	 WLhi38GWM3iO4yBF2mlStrEbxsgwFZWafYL5vjmIsTA5c0BEYSasdDuBjmKrkXq2gq
	 fbNmFUuuekJAA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDI-00000001WQj-2trs;
	Wed, 09 Jul 2025 20:32:36 -0400
Message-ID: <20250710003236.543250719@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:03 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 07/12] rv: Add rtapp container monitor
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add the container "rtapp" which is the monitor collection for detecting
problems with real-time applications. The monitors will be added in the
follow-up commits.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/fb18b87631d386271de00959d8d4826f23fcd1cd.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                |  1 +
 kernel/trace/rv/Makefile               |  1 +
 kernel/trace/rv/monitors/rtapp/Kconfig | 10 ++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.c | 33 ++++++++++++++++++++++++++
 kernel/trace/rv/monitors/rtapp/rtapp.h |  3 +++
 5 files changed, 48 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/rtapp/Kconfig
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.c
 create mode 100644 kernel/trace/rv/monitors/rtapp/rtapp.h

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6e157f964991..5c407d291661 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -41,6 +41,7 @@ source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
+source "kernel/trace/rv/monitors/rtapp/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f9b2cd0483c3..9b28c2419995 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
 obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
+obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/rtapp/Kconfig b/kernel/trace/rv/monitors/rtapp/Kconfig
new file mode 100644
index 000000000000..b7415c3570bb
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/Kconfig
@@ -0,0 +1,10 @@
+config RV_MON_RTAPP
+	depends on RV
+	bool "rtapp monitor"
+	help
+	  Collection of monitors to check for common problems with real-time
+	  application that may cause unexpected latency.
+
+	  If you are developing a real-time system and not entirely sure whether
+	  the applications are designed correctly for real-time, you want to say
+	  Y here.
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.c b/kernel/trace/rv/monitors/rtapp/rtapp.c
new file mode 100644
index 000000000000..fd75fc927d65
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "rtapp"
+
+#include "rtapp.h"
+
+struct rv_monitor rv_rtapp;
+
+struct rv_monitor rv_rtapp = {
+	.name = "rtapp",
+	.description = "Collection of monitors for detecting problems with real-time applications",
+};
+
+static int __init register_rtapp(void)
+{
+	return rv_register_monitor(&rv_rtapp, NULL);
+}
+
+static void __exit unregister_rtapp(void)
+{
+	rv_unregister_monitor(&rv_rtapp);
+}
+
+module_init(register_rtapp);
+module_exit(unregister_rtapp);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("Collection of monitors for detecting problems with real-time applications");
diff --git a/kernel/trace/rv/monitors/rtapp/rtapp.h b/kernel/trace/rv/monitors/rtapp/rtapp.h
new file mode 100644
index 000000000000..4c200d67c7f6
--- /dev/null
+++ b/kernel/trace/rv/monitors/rtapp/rtapp.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_rtapp;
-- 
2.47.2



