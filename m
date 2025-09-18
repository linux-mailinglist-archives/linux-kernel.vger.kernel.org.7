Return-Path: <linux-kernel+bounces-748603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19AAB14385
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80E1D7ADCF9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E824527EFE7;
	Mon, 28 Jul 2025 20:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRWPiPZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E190122FDE6
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735787; cv=none; b=CGz76Yj/VU6Re5FSWn2jggp0qKKuGiphfXfICGCLyx5TTDo8T8iyXxaR6sZlgNpEEPWg5LrZEFTyiJmpYmPrmO02zfl/SqMxjUQ+iRPv9OTgDZIulCKuviAKgl6kXqn6+jIjgphlU8+T8RtN2wYqpkYCrEXvgEcVALH4SCnmJlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735787; c=relaxed/simple;
	bh=HTTn0gtcrrZx9SzRKRbbP/AJwa/FfRT+WzBhPwNbJn4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HcD2m+uhxSoc6WAVDVLWDUpU+MolXf20maEpVuWua2g5xqlXpQhXhMSs8YqDGPIwBgpb/3eJCT/4TgbzCHxA8FUqGHsmcxJP3c4OdB7Xoor6JmSMRMhakUg6KSi6qNZfaUeqGXnSK7NMHF2mi4yqkFB7HyyowI3A+icbZT2lQVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRWPiPZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B95EC4CEE7;
	Mon, 28 Jul 2025 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753735786;
	bh=HTTn0gtcrrZx9SzRKRbbP/AJwa/FfRT+WzBhPwNbJn4=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QRWPiPZ23NNMAagYdgRLioFa89nMQROx3TwBHoiB2BbYt/sHUyWnomF+o9OFuazCv
	 UgW9z/Gh/YcNPaZJU44wV/ZvVQg57W5wyV9sWcqIxgKxzBMUUx11QTYYodc4gnGJCU
	 tu4CJtnqduadvx1tRxg4w7TCm7E0M7Nd9E7VmuxAeROxnMpPbtZEFmlZD03mCN6T9B
	 cHQZzejFYZs6q257UTCB7UQnbzVJnut3BOTAINkLnTugPP22mVRx7rQADHUD58zlN1
	 Kag26H8LuLDOOW9yalocIkp3Z1Syn6JBQ5j27hZpBq4OzLacIkc5KFyMjew8vmcpfy
	 y1JT0Z3MgQo5Q==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ugUnH-000000042yH-1h3M;
	Mon, 28 Jul 2025 16:49:59 -0400
Message-ID: <20250728204959.259938900@kernel.org>
User-Agent: quilt/0.68
Date: Mon, 28 Jul 2025 16:49:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nam Cao <namcao@linutronix.de>,
 Juri Lelli <jlelli@redhat.com>,
 Clark Williams <williams@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Gabriele Monaco <gmonaco@redhat.com>
Subject: [for-next][PATCH 09/11] rv: Replace tss and sncid monitors with more complete sts
References: <20250728204934.281385756@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Gabriele Monaco <gmonaco@redhat.com>

The tss monitor currently guarantees task switches can happen only while
scheduling, whereas the sncid monitor enforces scheduling occurs with
interrupt disabled.

Replace the monitors with a more comprehensive specification which
implies both but also ensures that:
* each scheduler call disable interrupts to switch
* each task switch happens with interrupts disabled

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>
Cc: Tomas Glozar <tglozar@redhat.com>
Cc: Juri Lelli <jlelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: John Kacur <jkacur@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20250728135022.255578-8-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/rv/monitor_sched.rst      |  87 +++++-----
 kernel/trace/rv/Kconfig                       |   3 +-
 kernel/trace/rv/Makefile                      |   3 +-
 kernel/trace/rv/monitors/sncid/Kconfig        |  15 --
 kernel/trace/rv/monitors/sncid/sncid.c        |  95 -----------
 kernel/trace/rv/monitors/sncid/sncid.h        |  49 ------
 kernel/trace/rv/monitors/sncid/sncid_trace.h  |  15 --
 kernel/trace/rv/monitors/sts/Kconfig          |  19 +++
 kernel/trace/rv/monitors/sts/sts.c            | 156 ++++++++++++++++++
 kernel/trace/rv/monitors/sts/sts.h            | 117 +++++++++++++
 .../{tss/tss_trace.h => sts/sts_trace.h}      |   8 +-
 kernel/trace/rv/monitors/tss/Kconfig          |  14 --
 kernel/trace/rv/monitors/tss/tss.c            |  90 ----------
 kernel/trace/rv/monitors/tss/tss.h            |  47 ------
 kernel/trace/rv/rv_trace.h                    |   3 +-
 tools/verification/models/sched/sncid.dot     |  18 --
 tools/verification/models/sched/sts.dot       |  38 +++++
 tools/verification/models/sched/tss.dot       |  18 --
 18 files changed, 385 insertions(+), 410 deletions(-)
 delete mode 100644 kernel/trace/rv/monitors/sncid/Kconfig
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.c
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid.h
 delete mode 100644 kernel/trace/rv/monitors/sncid/sncid_trace.h
 create mode 100644 kernel/trace/rv/monitors/sts/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sts/sts.c
 create mode 100644 kernel/trace/rv/monitors/sts/sts.h
 rename kernel/trace/rv/monitors/{tss/tss_trace.h => sts/sts_trace.h} (67%)
 delete mode 100644 kernel/trace/rv/monitors/tss/Kconfig
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.c
 delete mode 100644 kernel/trace/rv/monitors/tss/tss.h
 delete mode 100644 tools/verification/models/sched/sncid.dot
 create mode 100644 tools/verification/models/sched/sts.dot
 delete mode 100644 tools/verification/models/sched/tss.dot

diff --git a/Documentation/trace/rv/monitor_sched.rst b/Documentation/trace/rv/monitor_sched.rst
index 24b2c62a3bc2..6c4c00216c07 100644
--- a/Documentation/trace/rv/monitor_sched.rst
+++ b/Documentation/trace/rv/monitor_sched.rst
@@ -40,26 +40,6 @@ defined in by Daniel Bristot in [1].
 
 Currently we included the following:
 
-Monitor tss
-~~~~~~~~~~~
-
-The task switch while scheduling (tss) monitor ensures a task switch happens
-only in scheduling context, that is inside a call to `__schedule`::
-
-                     |
-                     |
-                     v
-                   +-----------------+
-                   |     thread      | <+
-                   +-----------------+  |
-                     |                  |
-                     | schedule_entry   | schedule_exit
-                     v                  |
-    sched_switch                        |
-  +---------------                      |
-  |                       sched         |
-  +-------------->                     -+
-
 Monitor sco
 ~~~~~~~~~~~
 
@@ -144,26 +124,55 @@ does not enable preemption::
                                                   |
                           scheduling_contex      -+
 
-Monitor sncid
-~~~~~~~~~~~~~
-
-The schedule not called with interrupt disabled (sncid) monitor ensures
-schedule is not called with interrupt disabled::
+Monitor sts
+~~~~~~~~~~~
 
-                       |
-                       |
-                       v
-    schedule_entry   +--------------+
-    schedule_exit    |              |
-  +----------------- |  can_sched   |
-  |                  |              |
-  +----------------> |              | <+
-                     +--------------+  |
-                       |               |
-                       | irq_disable   | irq_enable
-                       v               |
-                                       |
-                        cant_sched    -+
+The schedule implies task switch (sts) monitor ensures a task switch happens
+only in scheduling context and up to once, as well as scheduling occurs with
+interrupts enabled but no task switch can happen before interrupts are
+disabled. When the next task picked for execution is the same as the previously
+running one, no real task switch occurs but interrupts are disabled nonetheless::
+
+    irq_entry                      |
+     +----+                        |
+     v    |                        v
+ +------------+ irq_enable    #===================#   irq_disable
+ |            | ------------> H                   H   irq_entry
+ | cant_sched | <------------ H                   H   irq_enable
+ |            | irq_disable   H     can_sched     H --------------+
+ +------------+               H                   H               |
+                              H                   H               |
+            +---------------> H                   H <-------------+
+            |                 #===================#
+            |                   |
+      schedule_exit             | schedule_entry
+            |                   v
+            |   +-------------------+     irq_enable
+            |   |    scheduling     | <---------------+
+            |   +-------------------+                 |
+            |     |                                   |
+            |     | irq_disable                    +--------+  irq_entry
+            |     v                                |        | --------+
+            |   +-------------------+  irq_entry   | in_irq |         |
+            |   |                   | -----------> |        | <-------+
+            |   | disable_to_switch |              +--------+
+            |   |                   | --+
+            |   +-------------------+   |
+            |     |                     |
+            |     | sched_switch        |
+            |     v                     |
+            |   +-------------------+   |
+            |   |     switching     |   | irq_enable
+            |   +-------------------+   |
+            |     |                     |
+            |     | irq_enable          |
+            |     v                     |
+            |   +-------------------+   |
+            +-- |  enable_to_exit   | <-+
+                +-------------------+
+                  ^               | irq_disable
+                  |               | irq_entry
+                  +---------------+ irq_enable
 
 References
 ----------
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 34164eb4ec91..b688b24081c8 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -50,12 +50,11 @@ source "kernel/trace/rv/monitors/wip/Kconfig"
 source "kernel/trace/rv/monitors/wwnr/Kconfig"
 
 source "kernel/trace/rv/monitors/sched/Kconfig"
-source "kernel/trace/rv/monitors/tss/Kconfig"
 source "kernel/trace/rv/monitors/sco/Kconfig"
 source "kernel/trace/rv/monitors/snroc/Kconfig"
 source "kernel/trace/rv/monitors/scpd/Kconfig"
 source "kernel/trace/rv/monitors/snep/Kconfig"
-source "kernel/trace/rv/monitors/sncid/Kconfig"
+source "kernel/trace/rv/monitors/sts/Kconfig"
 # Add new sched monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 13ec2944c665..1939d3d7621c 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -6,15 +6,14 @@ obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SCHED) += monitors/sched/sched.o
-obj-$(CONFIG_RV_MON_TSS) += monitors/tss/tss.o
 obj-$(CONFIG_RV_MON_SCO) += monitors/sco/sco.o
 obj-$(CONFIG_RV_MON_SNROC) += monitors/snroc/snroc.o
 obj-$(CONFIG_RV_MON_SCPD) += monitors/scpd/scpd.o
 obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
-obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
 obj-$(CONFIG_RV_MON_PAGEFAULT) += monitors/pagefault/pagefault.o
 obj-$(CONFIG_RV_MON_SLEEP) += monitors/sleep/sleep.o
+obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sncid/Kconfig b/kernel/trace/rv/monitors/sncid/Kconfig
deleted file mode 100644
index 3a5639feaaaf..000000000000
--- a/kernel/trace/rv/monitors/sncid/Kconfig
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-config RV_MON_SNCID
-	depends on RV
-	depends on TRACE_IRQFLAGS
-	depends on RV_MON_SCHED
-	default y
-	select DA_MON_EVENTS_IMPLICIT
-	bool "sncid monitor"
-	help
-	  Monitor to ensure schedule is not called with interrupt disabled.
-	  This monitor is part of the sched monitors collection.
-
-	  For further information, see:
-	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sncid/sncid.c b/kernel/trace/rv/monitors/sncid/sncid.c
deleted file mode 100644
index c8491f426365..000000000000
--- a/kernel/trace/rv/monitors/sncid/sncid.c
+++ /dev/null
@@ -1,95 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ftrace.h>
-#include <linux/tracepoint.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/rv.h>
-#include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
-
-#define MODULE_NAME "sncid"
-
-#include <trace/events/sched.h>
-#include <trace/events/preemptirq.h>
-#include <rv_trace.h>
-#include <monitors/sched/sched.h>
-
-#include "sncid.h"
-
-static struct rv_monitor rv_sncid;
-DECLARE_DA_MON_PER_CPU(sncid, unsigned char);
-
-static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
-{
-	da_handle_event_sncid(irq_disable_sncid);
-}
-
-static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
-{
-	da_handle_start_event_sncid(irq_enable_sncid);
-}
-
-static void handle_schedule_entry(void *data, bool preempt)
-{
-	da_handle_start_event_sncid(schedule_entry_sncid);
-}
-
-static void handle_schedule_exit(void *data, bool is_switch)
-{
-	da_handle_start_event_sncid(schedule_exit_sncid);
-}
-
-static int enable_sncid(void)
-{
-	int retval;
-
-	retval = da_monitor_init_sncid();
-	if (retval)
-		return retval;
-
-	rv_attach_trace_probe("sncid", irq_disable, handle_irq_disable);
-	rv_attach_trace_probe("sncid", irq_enable, handle_irq_enable);
-	rv_attach_trace_probe("sncid", sched_entry_tp, handle_schedule_entry);
-	rv_attach_trace_probe("sncid", sched_exit_tp, handle_schedule_exit);
-
-	return 0;
-}
-
-static void disable_sncid(void)
-{
-	rv_sncid.enabled = 0;
-
-	rv_detach_trace_probe("sncid", irq_disable, handle_irq_disable);
-	rv_detach_trace_probe("sncid", irq_enable, handle_irq_enable);
-	rv_detach_trace_probe("sncid", sched_entry_tp, handle_schedule_entry);
-	rv_detach_trace_probe("sncid", sched_exit_tp, handle_schedule_exit);
-
-	da_monitor_destroy_sncid();
-}
-
-static struct rv_monitor rv_sncid = {
-	.name = "sncid",
-	.description = "schedule not called with interrupt disabled.",
-	.enable = enable_sncid,
-	.disable = disable_sncid,
-	.reset = da_monitor_reset_all_sncid,
-	.enabled = 0,
-};
-
-static int __init register_sncid(void)
-{
-	return rv_register_monitor(&rv_sncid, &rv_sched);
-}
-
-static void __exit unregister_sncid(void)
-{
-	rv_unregister_monitor(&rv_sncid);
-}
-
-module_init(register_sncid);
-module_exit(unregister_sncid);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
-MODULE_DESCRIPTION("sncid: schedule not called with interrupt disabled.");
diff --git a/kernel/trace/rv/monitors/sncid/sncid.h b/kernel/trace/rv/monitors/sncid/sncid.h
deleted file mode 100644
index 21304725142b..000000000000
--- a/kernel/trace/rv/monitors/sncid/sncid.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Automatically generated C representation of sncid automaton
- * For further information about this format, see kernel documentation:
- *   Documentation/trace/rv/deterministic_automata.rst
- */
-
-enum states_sncid {
-	can_sched_sncid = 0,
-	cant_sched_sncid,
-	state_max_sncid
-};
-
-#define INVALID_STATE state_max_sncid
-
-enum events_sncid {
-	irq_disable_sncid = 0,
-	irq_enable_sncid,
-	schedule_entry_sncid,
-	schedule_exit_sncid,
-	event_max_sncid
-};
-
-struct automaton_sncid {
-	char *state_names[state_max_sncid];
-	char *event_names[event_max_sncid];
-	unsigned char function[state_max_sncid][event_max_sncid];
-	unsigned char initial_state;
-	bool final_states[state_max_sncid];
-};
-
-static const struct automaton_sncid automaton_sncid = {
-	.state_names = {
-		"can_sched",
-		"cant_sched"
-	},
-	.event_names = {
-		"irq_disable",
-		"irq_enable",
-		"schedule_entry",
-		"schedule_exit"
-	},
-	.function = {
-		{ cant_sched_sncid,   INVALID_STATE, can_sched_sncid, can_sched_sncid },
-		{    INVALID_STATE, can_sched_sncid,   INVALID_STATE,   INVALID_STATE },
-	},
-	.initial_state = can_sched_sncid,
-	.final_states = { 1, 0 },
-};
diff --git a/kernel/trace/rv/monitors/sncid/sncid_trace.h b/kernel/trace/rv/monitors/sncid/sncid_trace.h
deleted file mode 100644
index 3ce42a57671d..000000000000
--- a/kernel/trace/rv/monitors/sncid/sncid_trace.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-/*
- * Snippet to be included in rv_trace.h
- */
-
-#ifdef CONFIG_RV_MON_SNCID
-DEFINE_EVENT(event_da_monitor, event_sncid,
-	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
-	     TP_ARGS(state, event, next_state, final_state));
-
-DEFINE_EVENT(error_da_monitor, error_sncid,
-	     TP_PROTO(char *state, char *event),
-	     TP_ARGS(state, event));
-#endif /* CONFIG_RV_MON_SNCID */
diff --git a/kernel/trace/rv/monitors/sts/Kconfig b/kernel/trace/rv/monitors/sts/Kconfig
new file mode 100644
index 000000000000..7d1ff0f6fc91
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/Kconfig
@@ -0,0 +1,19 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_STS
+	depends on RV
+	depends on TRACE_IRQFLAGS
+	depends on RV_MON_SCHED
+	default y
+	select DA_MON_EVENTS_IMPLICIT
+	bool "sts monitor"
+	help
+	  Monitor to ensure relationships between scheduler and task switches
+	   * the scheduler is called and returns with interrupts disabled
+	   * each call to the scheduler has up to one switch
+	   * switches only happen inside the scheduler
+	   * each call to the scheduler disables interrupts to switch
+	  This monitor is part of the sched monitors collection.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
new file mode 100644
index 000000000000..c4a9cd67c1d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -0,0 +1,156 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "sts"
+
+#include <trace/events/sched.h>
+#include <trace/events/irq.h>
+#include <trace/events/preemptirq.h>
+#include <rv_trace.h>
+#include <monitors/sched/sched.h>
+
+#include "sts.h"
+
+static struct rv_monitor rv_sts;
+DECLARE_DA_MON_PER_CPU(sts, unsigned char);
+
+#ifdef CONFIG_X86_LOCAL_APIC
+#include <asm/trace/irq_vectors.h>
+
+static void handle_vector_irq_entry(void *data, int vector)
+{
+	da_handle_event_sts(irq_entry_sts);
+}
+
+static void attach_vector_irq(void)
+{
+	rv_attach_trace_probe("sts", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_attach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_attach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
+		rv_attach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+static void detach_vector_irq(void)
+{
+	rv_detach_trace_probe("sts", local_timer_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_IRQ_WORK))
+		rv_detach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
+	if (IS_ENABLED(CONFIG_SMP)) {
+		rv_detach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
+		rv_detach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
+	}
+}
+
+#else
+/* We assume irq_entry tracepoints are sufficient on other architectures */
+static void attach_vector_irq(void) { }
+static void detach_vector_irq(void) { }
+#endif
+
+static void handle_irq_disable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_sts(irq_disable_sts);
+}
+
+static void handle_irq_enable(void *data, unsigned long ip, unsigned long parent_ip)
+{
+	da_handle_event_sts(irq_enable_sts);
+}
+
+static void handle_irq_entry(void *data, int irq, struct irqaction *action)
+{
+	da_handle_event_sts(irq_entry_sts);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	da_handle_event_sts(sched_switch_sts);
+}
+
+static void handle_schedule_entry(void *data, bool preempt)
+{
+	da_handle_event_sts(schedule_entry_sts);
+}
+
+static void handle_schedule_exit(void *data, bool is_switch)
+{
+	da_handle_start_event_sts(schedule_exit_sts);
+}
+
+static int enable_sts(void)
+{
+	int retval;
+
+	retval = da_monitor_init_sts();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("sts", irq_disable, handle_irq_disable);
+	rv_attach_trace_probe("sts", irq_enable, handle_irq_enable);
+	rv_attach_trace_probe("sts", irq_handler_entry, handle_irq_entry);
+	rv_attach_trace_probe("sts", sched_switch, handle_sched_switch);
+	rv_attach_trace_probe("sts", sched_entry_tp, handle_schedule_entry);
+	rv_attach_trace_probe("sts", sched_exit_tp, handle_schedule_exit);
+	attach_vector_irq();
+
+	return 0;
+}
+
+static void disable_sts(void)
+{
+	rv_sts.enabled = 0;
+
+	rv_detach_trace_probe("sts", irq_disable, handle_irq_disable);
+	rv_detach_trace_probe("sts", irq_enable, handle_irq_enable);
+	rv_detach_trace_probe("sts", irq_handler_entry, handle_irq_entry);
+	rv_detach_trace_probe("sts", sched_switch, handle_sched_switch);
+	rv_detach_trace_probe("sts", sched_entry_tp, handle_schedule_entry);
+	rv_detach_trace_probe("sts", sched_exit_tp, handle_schedule_exit);
+	detach_vector_irq();
+
+	da_monitor_destroy_sts();
+}
+
+/*
+ * This is the monitor register section.
+ */
+static struct rv_monitor rv_sts = {
+	.name = "sts",
+	.description = "schedule implies task switch.",
+	.enable = enable_sts,
+	.disable = disable_sts,
+	.reset = da_monitor_reset_all_sts,
+	.enabled = 0,
+};
+
+static int __init register_sts(void)
+{
+	return rv_register_monitor(&rv_sts, &rv_sched);
+}
+
+static void __exit unregister_sts(void)
+{
+	rv_unregister_monitor(&rv_sts);
+}
+
+module_init(register_sts);
+module_exit(unregister_sts);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
+MODULE_DESCRIPTION("sts: schedule implies task switch.");
diff --git a/kernel/trace/rv/monitors/sts/sts.h b/kernel/trace/rv/monitors/sts/sts.h
new file mode 100644
index 000000000000..3368b6599a00
--- /dev/null
+++ b/kernel/trace/rv/monitors/sts/sts.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of sts automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_sts {
+	can_sched_sts = 0,
+	cant_sched_sts,
+	disable_to_switch_sts,
+	enable_to_exit_sts,
+	in_irq_sts,
+	scheduling_sts,
+	switching_sts,
+	state_max_sts
+};
+
+#define INVALID_STATE state_max_sts
+
+enum events_sts {
+	irq_disable_sts = 0,
+	irq_enable_sts,
+	irq_entry_sts,
+	sched_switch_sts,
+	schedule_entry_sts,
+	schedule_exit_sts,
+	event_max_sts
+};
+
+struct automaton_sts {
+	char *state_names[state_max_sts];
+	char *event_names[event_max_sts];
+	unsigned char function[state_max_sts][event_max_sts];
+	unsigned char initial_state;
+	bool final_states[state_max_sts];
+};
+
+static const struct automaton_sts automaton_sts = {
+	.state_names = {
+		"can_sched",
+		"cant_sched",
+		"disable_to_switch",
+		"enable_to_exit",
+		"in_irq",
+		"scheduling",
+		"switching"
+	},
+	.event_names = {
+		"irq_disable",
+		"irq_enable",
+		"irq_entry",
+		"sched_switch",
+		"schedule_entry",
+		"schedule_exit"
+	},
+	.function = {
+		{
+			cant_sched_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			scheduling_sts,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			can_sched_sts,
+			cant_sched_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			enable_to_exit_sts,
+			in_irq_sts,
+			switching_sts,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+		{
+			enable_to_exit_sts,
+			enable_to_exit_sts,
+			enable_to_exit_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			can_sched_sts
+		},
+		{
+			INVALID_STATE,
+			scheduling_sts,
+			in_irq_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+		{
+			disable_to_switch_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+		{
+			INVALID_STATE,
+			enable_to_exit_sts,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE
+		},
+	},
+	.initial_state = can_sched_sts,
+	.final_states = { 1, 0, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/tss/tss_trace.h b/kernel/trace/rv/monitors/sts/sts_trace.h
similarity index 67%
rename from kernel/trace/rv/monitors/tss/tss_trace.h
rename to kernel/trace/rv/monitors/sts/sts_trace.h
index 4619dbb50cc0..d78beb58d5b3 100644
--- a/kernel/trace/rv/monitors/tss/tss_trace.h
+++ b/kernel/trace/rv/monitors/sts/sts_trace.h
@@ -4,12 +4,12 @@
  * Snippet to be included in rv_trace.h
  */
 
-#ifdef CONFIG_RV_MON_TSS
-DEFINE_EVENT(event_da_monitor, event_tss,
+#ifdef CONFIG_RV_MON_STS
+DEFINE_EVENT(event_da_monitor, event_sts,
 	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
 	     TP_ARGS(state, event, next_state, final_state));
 
-DEFINE_EVENT(error_da_monitor, error_tss,
+DEFINE_EVENT(error_da_monitor, error_sts,
 	     TP_PROTO(char *state, char *event),
 	     TP_ARGS(state, event));
-#endif /* CONFIG_RV_MON_TSS */
+#endif /* CONFIG_RV_MON_STS */
diff --git a/kernel/trace/rv/monitors/tss/Kconfig b/kernel/trace/rv/monitors/tss/Kconfig
deleted file mode 100644
index 479f86f52e60..000000000000
--- a/kernel/trace/rv/monitors/tss/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-config RV_MON_TSS
-	depends on RV
-	depends on RV_MON_SCHED
-	default y
-	select DA_MON_EVENTS_IMPLICIT
-	bool "tss monitor"
-	help
-	  Monitor to ensure sched_switch happens only in scheduling context.
-	  This monitor is part of the sched monitors collection.
-
-	  For further information, see:
-	    Documentation/trace/rv/monitor_sched.rst
diff --git a/kernel/trace/rv/monitors/tss/tss.c b/kernel/trace/rv/monitors/tss/tss.c
deleted file mode 100644
index 95ebd15131f5..000000000000
--- a/kernel/trace/rv/monitors/tss/tss.c
+++ /dev/null
@@ -1,90 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/ftrace.h>
-#include <linux/tracepoint.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/rv.h>
-#include <rv/instrumentation.h>
-#include <rv/da_monitor.h>
-
-#define MODULE_NAME "tss"
-
-#include <trace/events/sched.h>
-#include <rv_trace.h>
-#include <monitors/sched/sched.h>
-
-#include "tss.h"
-
-static struct rv_monitor rv_tss;
-DECLARE_DA_MON_PER_CPU(tss, unsigned char);
-
-static void handle_sched_switch(void *data, bool preempt,
-				struct task_struct *prev,
-				struct task_struct *next,
-				unsigned int prev_state)
-{
-	da_handle_event_tss(sched_switch_tss);
-}
-
-static void handle_schedule_entry(void *data, bool preempt)
-{
-	da_handle_event_tss(schedule_entry_tss);
-}
-
-static void handle_schedule_exit(void *data, bool is_switch)
-{
-	da_handle_start_event_tss(schedule_exit_tss);
-}
-
-static int enable_tss(void)
-{
-	int retval;
-
-	retval = da_monitor_init_tss();
-	if (retval)
-		return retval;
-
-	rv_attach_trace_probe("tss", sched_switch, handle_sched_switch);
-	rv_attach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
-	rv_attach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
-
-	return 0;
-}
-
-static void disable_tss(void)
-{
-	rv_tss.enabled = 0;
-
-	rv_detach_trace_probe("tss", sched_switch, handle_sched_switch);
-	rv_detach_trace_probe("tss", sched_entry_tp, handle_schedule_entry);
-	rv_detach_trace_probe("tss", sched_exit_tp, handle_schedule_exit);
-
-	da_monitor_destroy_tss();
-}
-
-static struct rv_monitor rv_tss = {
-	.name = "tss",
-	.description = "task switch while scheduling.",
-	.enable = enable_tss,
-	.disable = disable_tss,
-	.reset = da_monitor_reset_all_tss,
-	.enabled = 0,
-};
-
-static int __init register_tss(void)
-{
-	return rv_register_monitor(&rv_tss, &rv_sched);
-}
-
-static void __exit unregister_tss(void)
-{
-	rv_unregister_monitor(&rv_tss);
-}
-
-module_init(register_tss);
-module_exit(unregister_tss);
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Gabriele Monaco <gmonaco@redhat.com>");
-MODULE_DESCRIPTION("tss: task switch while scheduling.");
diff --git a/kernel/trace/rv/monitors/tss/tss.h b/kernel/trace/rv/monitors/tss/tss.h
deleted file mode 100644
index f0a36fda1b87..000000000000
--- a/kernel/trace/rv/monitors/tss/tss.h
+++ /dev/null
@@ -1,47 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Automatically generated C representation of tss automaton
- * For further information about this format, see kernel documentation:
- *   Documentation/trace/rv/deterministic_automata.rst
- */
-
-enum states_tss {
-	thread_tss = 0,
-	sched_tss,
-	state_max_tss
-};
-
-#define INVALID_STATE state_max_tss
-
-enum events_tss {
-	sched_switch_tss = 0,
-	schedule_entry_tss,
-	schedule_exit_tss,
-	event_max_tss
-};
-
-struct automaton_tss {
-	char *state_names[state_max_tss];
-	char *event_names[event_max_tss];
-	unsigned char function[state_max_tss][event_max_tss];
-	unsigned char initial_state;
-	bool final_states[state_max_tss];
-};
-
-static const struct automaton_tss automaton_tss = {
-	.state_names = {
-		"thread",
-		"sched"
-	},
-	.event_names = {
-		"sched_switch",
-		"schedule_entry",
-		"schedule_exit"
-	},
-	.function = {
-		{     INVALID_STATE,         sched_tss,     INVALID_STATE },
-		{         sched_tss,     INVALID_STATE,        thread_tss },
-	},
-	.initial_state = thread_tss,
-	.final_states = { 1, 0 },
-};
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 3af46cd185b3..97b2f7e07f27 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -58,11 +58,10 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 );
 
 #include <monitors/wip/wip_trace.h>
-#include <monitors/tss/tss_trace.h>
 #include <monitors/sco/sco_trace.h>
 #include <monitors/scpd/scpd_trace.h>
 #include <monitors/snep/snep_trace.h>
-#include <monitors/sncid/sncid_trace.h>
+#include <monitors/sts/sts_trace.h>
 // Add new monitors based on CONFIG_DA_MON_EVENTS_IMPLICIT here
 
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
diff --git a/tools/verification/models/sched/sncid.dot b/tools/verification/models/sched/sncid.dot
deleted file mode 100644
index 072851721b50..000000000000
--- a/tools/verification/models/sched/sncid.dot
+++ /dev/null
@@ -1,18 +0,0 @@
-digraph state_automaton {
-	center = true;
-	size = "7,11";
-	{node [shape = plaintext, style=invis, label=""] "__init_can_sched"};
-	{node [shape = ellipse] "can_sched"};
-	{node [shape = plaintext] "can_sched"};
-	{node [shape = plaintext] "cant_sched"};
-	"__init_can_sched" -> "can_sched";
-	"can_sched" [label = "can_sched", color = green3];
-	"can_sched" -> "can_sched" [ label = "schedule_entry\nschedule_exit" ];
-	"can_sched" -> "cant_sched" [ label = "irq_disable" ];
-	"cant_sched" [label = "cant_sched"];
-	"cant_sched" -> "can_sched" [ label = "irq_enable" ];
-	{ rank = min ;
-		"__init_can_sched";
-		"can_sched";
-	}
-}
diff --git a/tools/verification/models/sched/sts.dot b/tools/verification/models/sched/sts.dot
new file mode 100644
index 000000000000..8f5f38be04d5
--- /dev/null
+++ b/tools/verification/models/sched/sts.dot
@@ -0,0 +1,38 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_can_sched"};
+	{node [shape = doublecircle] "can_sched"};
+	{node [shape = circle] "can_sched"};
+	{node [shape = circle] "cant_sched"};
+	{node [shape = circle] "disable_to_switch"};
+	{node [shape = circle] "enable_to_exit"};
+	{node [shape = circle] "in_irq"};
+	{node [shape = circle] "scheduling"};
+	{node [shape = circle] "switching"};
+	"__init_can_sched" -> "can_sched";
+	"can_sched" [label = "can_sched", color = green3];
+	"can_sched" -> "cant_sched" [ label = "irq_disable" ];
+	"can_sched" -> "scheduling" [ label = "schedule_entry" ];
+	"cant_sched" [label = "cant_sched"];
+	"cant_sched" -> "can_sched" [ label = "irq_enable" ];
+	"cant_sched" -> "cant_sched" [ label = "irq_entry" ];
+	"disable_to_switch" [label = "disable_to_switch"];
+	"disable_to_switch" -> "enable_to_exit" [ label = "irq_enable" ];
+	"disable_to_switch" -> "in_irq" [ label = "irq_entry" ];
+	"disable_to_switch" -> "switching" [ label = "sched_switch" ];
+	"enable_to_exit" [label = "enable_to_exit"];
+	"enable_to_exit" -> "can_sched" [ label = "schedule_exit" ];
+	"enable_to_exit" -> "enable_to_exit" [ label = "irq_disable\nirq_entry\nirq_enable" ];
+	"in_irq" [label = "in_irq"];
+	"in_irq" -> "in_irq" [ label = "irq_entry" ];
+	"in_irq" -> "scheduling" [ label = "irq_enable" ];
+	"scheduling" [label = "scheduling"];
+	"scheduling" -> "disable_to_switch" [ label = "irq_disable" ];
+	"switching" [label = "switching"];
+	"switching" -> "enable_to_exit" [ label = "irq_enable" ];
+	{ rank = min ;
+		"__init_can_sched";
+		"can_sched";
+	}
+}
diff --git a/tools/verification/models/sched/tss.dot b/tools/verification/models/sched/tss.dot
deleted file mode 100644
index 7dfa1d9121bb..000000000000
--- a/tools/verification/models/sched/tss.dot
+++ /dev/null
@@ -1,18 +0,0 @@
-digraph state_automaton {
-	center = true;
-	size = "7,11";
-	{node [shape = plaintext] "sched"};
-	{node [shape = plaintext, style=invis, label=""] "__init_thread"};
-	{node [shape = ellipse] "thread"};
-	{node [shape = plaintext] "thread"};
-	"__init_thread" -> "thread";
-	"sched" [label = "sched"];
-	"sched" -> "sched" [ label = "sched_switch" ];
-	"sched" -> "thread" [ label = "schedule_exit" ];
-	"thread" [label = "thread", color = green3];
-	"thread" -> "sched" [ label = "schedule_entry" ];
-	{ rank = min ;
-		"__init_thread";
-		"thread";
-	}
-}
-- 
2.47.2



