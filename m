Return-Path: <linux-kernel+bounces-724691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2ECAFF5FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186C31BC8B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B919DF4D;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCdV0Fi2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F7D82899
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107552; cv=none; b=EYkkqW6v+pnB6DUc9ZQAjjsEmZ6GeDY7xcK5SDaHbOHgRdrPQ/qjSOq6KgSpsaRxu0kbP9I3JiD1swQcB5azkTQpneaLrKzqofm4m2c+a/7HLgu5IxfqM5n4tGOTG7nnXQgl42A6j+b0L2hlSf7ericeSd5RnSb6kRZOKVbHMsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107552; c=relaxed/simple;
	bh=xTAprtQvx3uhd6w55w5St7wvBdidAioJkx+UYQ5LK4o=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=YzR9wKzkvoOGmDcDePQVm3PJ3NUQtWK44JqnAsq5am0+yMsra2SfntWoMjAvFziljbrXcFkDto5WiSO/Y0T42rWSJZItWZ+//b236jwekWxu64EMDHaSuCHOaFE0aMkWMdjB41MfXMa2zmrvjUCbfx6aMTBmv1zpRcxSvtf6Hc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCdV0Fi2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF26C4CEF7;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=xTAprtQvx3uhd6w55w5St7wvBdidAioJkx+UYQ5LK4o=;
	h=Date:From:To:Cc:Subject:References:From;
	b=gCdV0Fi2mz0NhbRH9QZf7eXqpVeYRwZs577LDh91v0wb5jRF+rlirVS+qEFDM70vy
	 SeNDYyYzzxB6MjMZo51cfbGXNg1k+42ZGa9hT8HH1M50iew8/RRzSuoRMDffXce0gK
	 neLpX1yFPGK4BJx0iYM1s8kIr/d96uvz4nd142Mozc4YsM470C2TNqTvXBUa9E2iPd
	 PirWA5rSXh+pLhlYfgEOVGQBBCBJ7NYUQSdi8++WKrjUkQ4MW5mgFOEvMKNXnjBlpT
	 yET+HU8cvOUy1rNp+V4XDNRr3c1zHUWfCYdbEbch58oEh9F5p9B/JQxUs+OUQwgwe4
	 I33srbezdakQw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDJ-00000001WRl-07aT;
	Wed, 09 Jul 2025 20:32:37 -0400
Message-ID: <20250710003236.885337953@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 09/12] rv: Add rtapp_pagefault monitor
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Userspace real-time applications may have design flaws that they raise
page faults in real-time threads, and thus have unexpected latencies.

Add an linear temporal logic monitor to detect this scenario.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/78fea8a2de6d058241d3c6502c1a92910772b0ed.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                       |  1 +
 kernel/trace/rv/Makefile                      |  1 +
 kernel/trace/rv/monitors/pagefault/Kconfig    | 20 +++++
 .../trace/rv/monitors/pagefault/pagefault.c   | 88 +++++++++++++++++++
 .../trace/rv/monitors/pagefault/pagefault.h   | 64 ++++++++++++++
 .../rv/monitors/pagefault/pagefault_trace.h   | 14 +++
 kernel/trace/rv/rv_trace.h                    |  1 +
 tools/verification/models/rtapp/pagefault.ltl |  1 +
 8 files changed, 190 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/pagefault/Kconfig
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.c
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault.h
 create mode 100644 kernel/trace/rv/monitors/pagefault/pagefault_trace.h
 create mode 100644 tools/verification/models/rtapp/pagefault.ltl

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 5c407d291661..6f86d8501e87 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -42,6 +42,7 @@ source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
+source "kernel/trace/rv/monitors/pagefault/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 9b28c2419995..353ecf939d0e 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
+obj-$(CONFIG_RV_MON_PAGEFAULT) += monitors/pagefault/pagefault.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig b/kernel/trace/rv/monitors/pagefault/Kconfig
new file mode 100644
index 000000000000..5e16625f1653
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_PAGEFAULT
+	depends on RV
+	select RV_LTL_MONITOR
+	depends on RV_MON_RTAPP
+	depends on X86 || RISCV
+	default y
+	select LTL_MON_EVENTS_ID
+	bool "pagefault monitor"
+	help
+	  Monitor that real-time tasks do not raise page faults, causing
+	  undesirable latency.
+
+	  If you are developing a real-time system and not entirely sure whether
+	  the applications are designed correctly for real-time, you want to say
+	  Y here.
+
+	  This monitor does not affect execution speed while it is not running,
+	  therefore it is safe to enable this in production kernel.
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.c b/kernel/trace/rv/monitors/pagefault/pagefault.c
new file mode 100644
index 000000000000..9fe6123b2200
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include <linux/tracepoint.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "pagefault"
+
+#include <rv_trace.h>
+#include <trace/events/exceptions.h>
+#include <monitors/rtapp/rtapp.h>
+
+#include "pagefault.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon)
+{
+	/*
+	 * This includes "actual" real-time tasks and also PI-boosted
+	 * tasks. A task being PI-boosted means it is blocking an "actual"
+	 * real-task, therefore it should also obey the monitor's rule,
+	 * otherwise the "actual" real-task may be delayed.
+	 */
+	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
+{
+	if (task_creation)
+		ltl_atom_set(mon, LTL_PAGEFAULT, false);
+}
+
+static void handle_page_fault(void *data, unsigned long address, struct pt_regs *regs,
+			      unsigned long error_code)
+{
+	ltl_atom_pulse(current, LTL_PAGEFAULT, true);
+}
+
+static int enable_pagefault(void)
+{
+	int retval;
+
+	retval = ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("rtapp_pagefault", page_fault_kernel, handle_page_fault);
+	rv_attach_trace_probe("rtapp_pagefault", page_fault_user, handle_page_fault);
+
+	return 0;
+}
+
+static void disable_pagefault(void)
+{
+	rv_detach_trace_probe("rtapp_pagefault", page_fault_kernel, handle_page_fault);
+	rv_detach_trace_probe("rtapp_pagefault", page_fault_user, handle_page_fault);
+
+	ltl_monitor_destroy();
+}
+
+static struct rv_monitor rv_pagefault = {
+	.name = "pagefault",
+	.description = "Monitor that RT tasks do not raise page faults",
+	.enable = enable_pagefault,
+	.disable = disable_pagefault,
+};
+
+static int __init register_pagefault(void)
+{
+	return rv_register_monitor(&rv_pagefault, &rv_rtapp);
+}
+
+static void __exit unregister_pagefault(void)
+{
+	rv_unregister_monitor(&rv_pagefault);
+}
+
+module_init(register_pagefault);
+module_exit(unregister_pagefault);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("pagefault: Monitor that RT tasks do not raise page faults");
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault.h b/kernel/trace/rv/monitors/pagefault/pagefault.h
new file mode 100644
index 000000000000..c580ec194009
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * C implementation of Buchi automaton, automatically generated by
+ * tools/verification/rvgen from the linear temporal logic specification.
+ * For further information, see kernel documentation:
+ *   Documentation/trace/rv/linear_temporal_logic.rst
+ */
+
+#include <linux/rv.h>
+
+#define MONITOR_NAME pagefault
+
+enum ltl_atom {
+	LTL_PAGEFAULT,
+	LTL_RT,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] = {
+		"pa",
+		"rt",
+	};
+
+	return names[atom];
+}
+
+enum ltl_buchi_state {
+	S0,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);
+
+static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
+{
+	bool pagefault = test_bit(LTL_PAGEFAULT, mon->atoms);
+	bool val3 = !pagefault;
+	bool rt = test_bit(LTL_RT, mon->atoms);
+	bool val1 = !rt;
+	bool val4 = val1 || val3;
+
+	if (val4)
+		__set_bit(S0, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
+{
+	bool pagefault = test_bit(LTL_PAGEFAULT, mon->atoms);
+	bool val3 = !pagefault;
+	bool rt = test_bit(LTL_RT, mon->atoms);
+	bool val1 = !rt;
+	bool val4 = val1 || val3;
+
+	switch (state) {
+	case S0:
+		if (val4)
+			__set_bit(S0, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_trace.h b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
new file mode 100644
index 000000000000..fe1f82597b1a
--- /dev/null
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_PAGEFAULT
+DEFINE_EVENT(event_ltl_monitor_id, event_pagefault,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_ltl_monitor_id, error_pagefault,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_PAGEFAULT */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index fd3111ad1d51..98eee8ec96e4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -172,6 +172,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 
 	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
 );
+#include <monitors/pagefault/pagefault_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
diff --git a/tools/verification/models/rtapp/pagefault.ltl b/tools/verification/models/rtapp/pagefault.ltl
new file mode 100644
index 000000000000..d7ce62102733
--- /dev/null
+++ b/tools/verification/models/rtapp/pagefault.ltl
@@ -0,0 +1 @@
+RULE = always (RT imply not PAGEFAULT)
-- 
2.47.2



