Return-Path: <linux-kernel+bounces-724693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89650AFF5FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD4A16FEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035A11B043E;
	Thu, 10 Jul 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rAUOFumK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FC145B16
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107553; cv=none; b=M1AWr7BSN+BCj57VmCX47mqfPMsTf3bOoyIMcPMtA/6y6YUZv5DkuLsSoMlSJ5immRN9BHeSRMJRO0h+yCNEux8stPJ+HqNplzJmVlKHgYil7mQSVNd+1o29Ck2miKJgbM3aCB6NIf4OtqR7cnI5VnnKZ6nSLLKDV3W7w0GRvWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107553; c=relaxed/simple;
	bh=F4j2QKisF3GwB86EP1X9Dvfftli16JoytVoL0P3gJA8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=hLpDp1wwvyrly5x90Hqv3AERnGtn5LTPZhPHzKYquPbaEn7/citPPlZKHIg+CywtCHA5j5yWUwXEEppoBnKOV4t33rFRipqn4gscTFUEPCCf8Vd2rLCIbtE09tED1FhaFTECe9NxR8sJuHz/ZndrpWq6Ctknc+73cWu4EfoQkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rAUOFumK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA3C4CEF1;
	Thu, 10 Jul 2025 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107552;
	bh=F4j2QKisF3GwB86EP1X9Dvfftli16JoytVoL0P3gJA8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rAUOFumK3WC3Pm2btJYv1/FjXR4w+NAFoiYG2s9BZDzUE2s/539gzr2imNtgLySVG
	 C5ZAPaOBcYj0PRzAeiRWJYxeksNQl7ji0bHqKhWEjaU7/lLm/EtMEsNmiOb52aZiIt
	 dXuFPX9Z3mozK+Nc3/t8hkU65giN7GZuS4ZhahhkJhBnw3X8yOsG2vtRjTSyKlBMK1
	 5IdkWsbt8C72ZuBcQiUXk6aM1Xf3oQm0qYC4Gro/EfvxxIAvON0xENsVm8+0bTXAWt
	 vKKg9hP3k3cymUCXARGRG0f6o7FjQeiitUSuTpJFKvFeh6Gho7E9BlVESlxHvWKy9q
	 rZp0L/DX4gYgQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDJ-00000001WSG-0pPW;
	Wed, 09 Jul 2025 20:32:37 -0400
Message-ID: <20250710003237.051816614@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:06 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 10/12] rv: Add rtapp_sleep monitor
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add a monitor for checking that real-time tasks do not go to sleep in a
manner that may cause undesirable latency.

Also change
	RV depends on TRACING
to
	RV select TRACING
to avoid the following recursive dependency:

 error: recursive dependency detected!
	symbol TRACING is selected by PREEMPTIRQ_TRACEPOINTS
	symbol PREEMPTIRQ_TRACEPOINTS depends on TRACE_IRQFLAGS
	symbol TRACE_IRQFLAGS is selected by RV_MON_SLEEP
	symbol RV_MON_SLEEP depends on RV
	symbol RV depends on TRACING

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/75bc5bcc741d153aa279c95faf778dff35c5c8ad.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig                      |   3 +-
 kernel/trace/rv/Makefile                     |   1 +
 kernel/trace/rv/monitors/sleep/Kconfig       |  22 ++
 kernel/trace/rv/monitors/sleep/sleep.c       | 237 +++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep.h       | 257 +++++++++++++++++++
 kernel/trace/rv/monitors/sleep/sleep_trace.h |  14 +
 kernel/trace/rv/rv_trace.h                   |   1 +
 tools/verification/models/rtapp/sleep.ltl    |  22 ++
 8 files changed, 556 insertions(+), 1 deletion(-)
 create mode 100644 kernel/trace/rv/monitors/sleep/Kconfig
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.c
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep.h
 create mode 100644 kernel/trace/rv/monitors/sleep/sleep_trace.h
 create mode 100644 tools/verification/models/rtapp/sleep.ltl

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 6f86d8501e87..942d57575e67 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -20,7 +20,7 @@ config RV_LTL_MONITOR
 
 menuconfig RV
 	bool "Runtime Verification"
-	depends on TRACING
+	select TRACING
 	help
 	  Enable the kernel runtime verification infrastructure. RV is a
 	  lightweight (yet rigorous) method that complements classical
@@ -43,6 +43,7 @@ source "kernel/trace/rv/monitors/snep/Kconfig"
 source "kernel/trace/rv/monitors/sncid/Kconfig"
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
+source "kernel/trace/rv/monitors/sleep/Kconfig"
 # Add new monitors here
 
 config RV_REACTORS
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 353ecf939d0e..13ec2944c665 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_RV_MON_SNEP) += monitors/snep/snep.o
 obj-$(CONFIG_RV_MON_SNCID) += monitors/sncid/sncid.o
 obj-$(CONFIG_RV_MON_RTAPP) += monitors/rtapp/rtapp.o
 obj-$(CONFIG_RV_MON_PAGEFAULT) += monitors/pagefault/pagefault.o
+obj-$(CONFIG_RV_MON_SLEEP) += monitors/sleep/sleep.o
 # Add new monitors here
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
diff --git a/kernel/trace/rv/monitors/sleep/Kconfig b/kernel/trace/rv/monitors/sleep/Kconfig
new file mode 100644
index 000000000000..6b7a122e7b47
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_SLEEP
+	depends on RV
+	select RV_LTL_MONITOR
+	depends on HAVE_SYSCALL_TRACEPOINTS
+	depends on RV_MON_RTAPP
+	select TRACE_IRQFLAGS
+	default y
+	select LTL_MON_EVENTS_ID
+	bool "sleep monitor"
+	help
+	  Monitor that real-time tasks do not sleep in a manner that may
+	  cause undesirable latency.
+
+	  If you are developing a real-time system and not entirely sure whether
+	  the applications are designed correctly for real-time, you want to say
+	  Y here.
+
+	  Enabling this monitor may have performance impact (due to select
+	  TRACE_IRQFLAGS). Therefore, you probably should say N for
+	  production kernel.
diff --git a/kernel/trace/rv/monitors/sleep/sleep.c b/kernel/trace/rv/monitors/sleep/sleep.c
new file mode 100644
index 000000000000..eea447b06907
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/sched/deadline.h>
+#include <linux/sched/rt.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "sleep"
+
+#include <trace/events/syscalls.h>
+#include <trace/events/sched.h>
+#include <trace/events/lock.h>
+#include <uapi/linux/futex.h>
+#include <rv_trace.h>
+#include <monitors/rtapp/rtapp.h>
+
+#include "sleep.h"
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
+	ltl_atom_set(mon, LTL_SLEEP, false);
+	ltl_atom_set(mon, LTL_WAKE, false);
+	ltl_atom_set(mon, LTL_ABORT_SLEEP, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_HARDIRQ, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_NMI, false);
+	ltl_atom_set(mon, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, false);
+
+	if (task_creation) {
+		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
+		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
+		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
+		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
+		ltl_atom_set(mon, LTL_BLOCK_ON_RT_MUTEX, false);
+	}
+
+	if (task->flags & PF_KTHREAD) {
+		ltl_atom_set(mon, LTL_KERNEL_THREAD, true);
+
+		/* kernel tasks do not do syscall */
+		ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
+		ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
+		ltl_atom_set(mon, LTL_CLOCK_NANOSLEEP, false);
+
+		if (strstarts(task->comm, "migration/"))
+			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, true);
+		else
+			ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
+
+		if (strstarts(task->comm, "rcu"))
+			ltl_atom_set(mon, LTL_TASK_IS_RCU, true);
+		else
+			ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
+	} else {
+		ltl_atom_set(mon, LTL_KTHREAD_SHOULD_STOP, false);
+		ltl_atom_set(mon, LTL_KERNEL_THREAD, false);
+		ltl_atom_set(mon, LTL_TASK_IS_RCU, false);
+		ltl_atom_set(mon, LTL_TASK_IS_MIGRATION, false);
+	}
+
+}
+
+static void handle_sched_set_state(void *data, struct task_struct *task, int state)
+{
+	if (state & TASK_INTERRUPTIBLE)
+		ltl_atom_pulse(task, LTL_SLEEP, true);
+	else if (state == TASK_RUNNING)
+		ltl_atom_pulse(task, LTL_ABORT_SLEEP, true);
+}
+
+static void handle_sched_wakeup(void *data, struct task_struct *task)
+{
+	ltl_atom_pulse(task, LTL_WAKE, true);
+}
+
+static void handle_sched_waking(void *data, struct task_struct *task)
+{
+	if (this_cpu_read(hardirq_context)) {
+		ltl_atom_pulse(task, LTL_WOKEN_BY_HARDIRQ, true);
+	} else if (in_task()) {
+		if (current->prio <= task->prio)
+			ltl_atom_pulse(task, LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO, true);
+	} else if (in_nmi()) {
+		ltl_atom_pulse(task, LTL_WOKEN_BY_NMI, true);
+	}
+}
+
+static void handle_contention_begin(void *data, void *lock, unsigned int flags)
+{
+	if (flags & LCB_F_RT)
+		ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, true);
+}
+
+static void handle_contention_end(void *data, void *lock, int ret)
+{
+	ltl_atom_update(current, LTL_BLOCK_ON_RT_MUTEX, false);
+}
+
+static void handle_sys_enter(void *data, struct pt_regs *regs, long id)
+{
+	struct ltl_monitor *mon;
+	unsigned long args[6];
+	int op, cmd;
+
+	mon = ltl_get_monitor(current);
+
+	switch (id) {
+	case __NR_clock_nanosleep:
+#ifdef __NR_clock_nanosleep_time64
+	case __NR_clock_nanosleep_time64:
+#endif
+		syscall_get_arguments(current, regs, args);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, args[0] == CLOCK_MONOTONIC);
+		ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, args[0] == CLOCK_TAI);
+		ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, args[1] == TIMER_ABSTIME);
+		ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, true);
+		break;
+
+	case __NR_futex:
+#ifdef __NR_futex_time64
+	case __NR_futex_time64:
+#endif
+		syscall_get_arguments(current, regs, args);
+		op = args[1];
+		cmd = op & FUTEX_CMD_MASK;
+
+		switch (cmd) {
+		case FUTEX_LOCK_PI:
+		case FUTEX_LOCK_PI2:
+			ltl_atom_update(current, LTL_FUTEX_LOCK_PI, true);
+			break;
+		case FUTEX_WAIT:
+		case FUTEX_WAIT_BITSET:
+		case FUTEX_WAIT_REQUEUE_PI:
+			ltl_atom_update(current, LTL_FUTEX_WAIT, true);
+			break;
+		}
+		break;
+	}
+}
+
+static void handle_sys_exit(void *data, struct pt_regs *regs, long ret)
+{
+	struct ltl_monitor *mon = ltl_get_monitor(current);
+
+	ltl_atom_set(mon, LTL_FUTEX_LOCK_PI, false);
+	ltl_atom_set(mon, LTL_FUTEX_WAIT, false);
+	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_MONOTONIC, false);
+	ltl_atom_set(mon, LTL_NANOSLEEP_CLOCK_TAI, false);
+	ltl_atom_set(mon, LTL_NANOSLEEP_TIMER_ABSTIME, false);
+	ltl_atom_update(current, LTL_CLOCK_NANOSLEEP, false);
+}
+
+static void handle_kthread_stop(void *data, struct task_struct *task)
+{
+	/* FIXME: this could race with other tracepoint handlers */
+	ltl_atom_update(task, LTL_KTHREAD_SHOULD_STOP, true);
+}
+
+static int enable_sleep(void)
+{
+	int retval;
+
+	retval = ltl_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
+	rv_attach_trace_probe("rtapp_sleep", sched_wakeup, handle_sched_wakeup);
+	rv_attach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set_state);
+	rv_attach_trace_probe("rtapp_sleep", contention_begin, handle_contention_begin);
+	rv_attach_trace_probe("rtapp_sleep", contention_end, handle_contention_end);
+	rv_attach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_stop);
+	rv_attach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
+	rv_attach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
+	return 0;
+}
+
+static void disable_sleep(void)
+{
+	rv_detach_trace_probe("rtapp_sleep", sched_waking, handle_sched_waking);
+	rv_detach_trace_probe("rtapp_sleep", sched_wakeup, handle_sched_wakeup);
+	rv_detach_trace_probe("rtapp_sleep", sched_set_state_tp, handle_sched_set_state);
+	rv_detach_trace_probe("rtapp_sleep", contention_begin, handle_contention_begin);
+	rv_detach_trace_probe("rtapp_sleep", contention_end, handle_contention_end);
+	rv_detach_trace_probe("rtapp_sleep", sched_kthread_stop, handle_kthread_stop);
+	rv_detach_trace_probe("rtapp_sleep", sys_enter, handle_sys_enter);
+	rv_detach_trace_probe("rtapp_sleep", sys_exit, handle_sys_exit);
+
+	ltl_monitor_destroy();
+}
+
+static struct rv_monitor rv_sleep = {
+	.name = "sleep",
+	.description = "Monitor that RT tasks do not undesirably sleep",
+	.enable = enable_sleep,
+	.disable = disable_sleep,
+};
+
+static int __init register_sleep(void)
+{
+	return rv_register_monitor(&rv_sleep, &rv_rtapp);
+}
+
+static void __exit unregister_sleep(void)
+{
+	rv_unregister_monitor(&rv_sleep);
+}
+
+module_init(register_sleep);
+module_exit(unregister_sleep);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nam Cao <namcao@linutronix.de>");
+MODULE_DESCRIPTION("sleep: Monitor that RT tasks do not undesirably sleep");
diff --git a/kernel/trace/rv/monitors/sleep/sleep.h b/kernel/trace/rv/monitors/sleep/sleep.h
new file mode 100644
index 000000000000..2ab46fd218d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep.h
@@ -0,0 +1,257 @@
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
+#define MONITOR_NAME sleep
+
+enum ltl_atom {
+	LTL_ABORT_SLEEP,
+	LTL_BLOCK_ON_RT_MUTEX,
+	LTL_CLOCK_NANOSLEEP,
+	LTL_FUTEX_LOCK_PI,
+	LTL_FUTEX_WAIT,
+	LTL_KERNEL_THREAD,
+	LTL_KTHREAD_SHOULD_STOP,
+	LTL_NANOSLEEP_CLOCK_MONOTONIC,
+	LTL_NANOSLEEP_CLOCK_TAI,
+	LTL_NANOSLEEP_TIMER_ABSTIME,
+	LTL_RT,
+	LTL_SLEEP,
+	LTL_TASK_IS_MIGRATION,
+	LTL_TASK_IS_RCU,
+	LTL_WAKE,
+	LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
+	LTL_WOKEN_BY_HARDIRQ,
+	LTL_WOKEN_BY_NMI,
+	LTL_NUM_ATOM
+};
+static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);
+
+static const char *ltl_atom_str(enum ltl_atom atom)
+{
+	static const char *const names[] = {
+		"ab_sl",
+		"bl_on_rt_mu",
+		"cl_na",
+		"fu_lo_pi",
+		"fu_wa",
+		"ker_th",
+		"kth_sh_st",
+		"na_cl_mo",
+		"na_cl_ta",
+		"na_ti_ab",
+		"rt",
+		"sl",
+		"ta_mi",
+		"ta_rc",
+		"wak",
+		"wo_eq_hi_pr",
+		"wo_ha",
+		"wo_nm",
+	};
+
+	return names[atom];
+}
+
+enum ltl_buchi_state {
+	S0,
+	S1,
+	S2,
+	S3,
+	S4,
+	S5,
+	S6,
+	S7,
+	RV_NUM_BA_STATES
+};
+static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);
+
+static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)
+{
+	bool task_is_migration = test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool task_is_rcu = test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool val40 = task_is_rcu || task_is_migration;
+	bool futex_lock_pi = test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool val41 = futex_lock_pi || val40;
+	bool block_on_rt_mutex = test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val5 = block_on_rt_mutex || val41;
+	bool kthread_should_stop = test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms);
+	bool abort_sleep = test_bit(LTL_ABORT_SLEEP, mon->atoms);
+	bool val32 = abort_sleep || kthread_should_stop;
+	bool woken_by_nmi = test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
+	bool val33 = woken_by_nmi || val32;
+	bool woken_by_hardirq = test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
+	bool val34 = woken_by_hardirq || val33;
+	bool woken_by_equal_or_higher_prio = test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
+	     mon->atoms);
+	bool val14 = woken_by_equal_or_higher_prio || val34;
+	bool wake = test_bit(LTL_WAKE, mon->atoms);
+	bool val13 = !wake;
+	bool kernel_thread = test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool nanosleep_clock_tai = test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms);
+	bool nanosleep_clock_monotonic = test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
+	bool val24 = nanosleep_clock_monotonic || nanosleep_clock_tai;
+	bool nanosleep_timer_abstime = test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mon->atoms);
+	bool val25 = nanosleep_timer_abstime && val24;
+	bool clock_nanosleep = test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
+	bool val18 = clock_nanosleep && val25;
+	bool futex_wait = test_bit(LTL_FUTEX_WAIT, mon->atoms);
+	bool val9 = futex_wait || val18;
+	bool val11 = val9 || kernel_thread;
+	bool sleep = test_bit(LTL_SLEEP, mon->atoms);
+	bool val2 = !sleep;
+	bool rt = test_bit(LTL_RT, mon->atoms);
+	bool val1 = !rt;
+	bool val3 = val1 || val2;
+
+	if (val3)
+		__set_bit(S0, mon->states);
+	if (val11 && val13)
+		__set_bit(S1, mon->states);
+	if (val11 && val14)
+		__set_bit(S4, mon->states);
+	if (val5)
+		__set_bit(S5, mon->states);
+}
+
+static void
+ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)
+{
+	bool task_is_migration = test_bit(LTL_TASK_IS_MIGRATION, mon->atoms);
+	bool task_is_rcu = test_bit(LTL_TASK_IS_RCU, mon->atoms);
+	bool val40 = task_is_rcu || task_is_migration;
+	bool futex_lock_pi = test_bit(LTL_FUTEX_LOCK_PI, mon->atoms);
+	bool val41 = futex_lock_pi || val40;
+	bool block_on_rt_mutex = test_bit(LTL_BLOCK_ON_RT_MUTEX, mon->atoms);
+	bool val5 = block_on_rt_mutex || val41;
+	bool kthread_should_stop = test_bit(LTL_KTHREAD_SHOULD_STOP, mon->atoms);
+	bool abort_sleep = test_bit(LTL_ABORT_SLEEP, mon->atoms);
+	bool val32 = abort_sleep || kthread_should_stop;
+	bool woken_by_nmi = test_bit(LTL_WOKEN_BY_NMI, mon->atoms);
+	bool val33 = woken_by_nmi || val32;
+	bool woken_by_hardirq = test_bit(LTL_WOKEN_BY_HARDIRQ, mon->atoms);
+	bool val34 = woken_by_hardirq || val33;
+	bool woken_by_equal_or_higher_prio = test_bit(LTL_WOKEN_BY_EQUAL_OR_HIGHER_PRIO,
+	     mon->atoms);
+	bool val14 = woken_by_equal_or_higher_prio || val34;
+	bool wake = test_bit(LTL_WAKE, mon->atoms);
+	bool val13 = !wake;
+	bool kernel_thread = test_bit(LTL_KERNEL_THREAD, mon->atoms);
+	bool nanosleep_clock_tai = test_bit(LTL_NANOSLEEP_CLOCK_TAI, mon->atoms);
+	bool nanosleep_clock_monotonic = test_bit(LTL_NANOSLEEP_CLOCK_MONOTONIC, mon->atoms);
+	bool val24 = nanosleep_clock_monotonic || nanosleep_clock_tai;
+	bool nanosleep_timer_abstime = test_bit(LTL_NANOSLEEP_TIMER_ABSTIME, mon->atoms);
+	bool val25 = nanosleep_timer_abstime && val24;
+	bool clock_nanosleep = test_bit(LTL_CLOCK_NANOSLEEP, mon->atoms);
+	bool val18 = clock_nanosleep && val25;
+	bool futex_wait = test_bit(LTL_FUTEX_WAIT, mon->atoms);
+	bool val9 = futex_wait || val18;
+	bool val11 = val9 || kernel_thread;
+	bool sleep = test_bit(LTL_SLEEP, mon->atoms);
+	bool val2 = !sleep;
+	bool rt = test_bit(LTL_RT, mon->atoms);
+	bool val1 = !rt;
+	bool val3 = val1 || val2;
+
+	switch (state) {
+	case S0:
+		if (val3)
+			__set_bit(S0, next);
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val5)
+			__set_bit(S5, next);
+		break;
+	case S1:
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val13 && val3)
+			__set_bit(S2, next);
+		if (val14 && val3)
+			__set_bit(S3, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val13 && val5)
+			__set_bit(S6, next);
+		if (val14 && val5)
+			__set_bit(S7, next);
+		break;
+	case S2:
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val13 && val3)
+			__set_bit(S2, next);
+		if (val14 && val3)
+			__set_bit(S3, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val13 && val5)
+			__set_bit(S6, next);
+		if (val14 && val5)
+			__set_bit(S7, next);
+		break;
+	case S3:
+		if (val3)
+			__set_bit(S0, next);
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val5)
+			__set_bit(S5, next);
+		break;
+	case S4:
+		if (val3)
+			__set_bit(S0, next);
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val5)
+			__set_bit(S5, next);
+		break;
+	case S5:
+		if (val3)
+			__set_bit(S0, next);
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val5)
+			__set_bit(S5, next);
+		break;
+	case S6:
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val13 && val3)
+			__set_bit(S2, next);
+		if (val14 && val3)
+			__set_bit(S3, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val13 && val5)
+			__set_bit(S6, next);
+		if (val14 && val5)
+			__set_bit(S7, next);
+		break;
+	case S7:
+		if (val3)
+			__set_bit(S0, next);
+		if (val11 && val13)
+			__set_bit(S1, next);
+		if (val11 && val14)
+			__set_bit(S4, next);
+		if (val5)
+			__set_bit(S5, next);
+		break;
+	}
+}
diff --git a/kernel/trace/rv/monitors/sleep/sleep_trace.h b/kernel/trace/rv/monitors/sleep/sleep_trace.h
new file mode 100644
index 000000000000..22eaf31da987
--- /dev/null
+++ b/kernel/trace/rv/monitors/sleep/sleep_trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_SLEEP
+DEFINE_EVENT(event_ltl_monitor_id, event_sleep,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_ltl_monitor_id, error_sleep,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_SLEEP */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 98eee8ec96e4..b6f310498466 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -173,6 +173,7 @@ DECLARE_EVENT_CLASS(error_ltl_monitor_id,
 	TP_printk("%s[%d]: violation detected", __get_str(comm), __entry->pid)
 );
 #include <monitors/pagefault/pagefault_trace.h>
+#include <monitors/sleep/sleep_trace.h>
 // Add new monitors based on CONFIG_LTL_MON_EVENTS_ID here
 #endif /* CONFIG_LTL_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
diff --git a/tools/verification/models/rtapp/sleep.ltl b/tools/verification/models/rtapp/sleep.ltl
new file mode 100644
index 000000000000..6379bbeb6212
--- /dev/null
+++ b/tools/verification/models/rtapp/sleep.ltl
@@ -0,0 +1,22 @@
+RULE = always ((RT and SLEEP) imply (RT_FRIENDLY_SLEEP or ALLOWLIST))
+
+RT_FRIENDLY_SLEEP = (RT_VALID_SLEEP_REASON or KERNEL_THREAD)
+                and ((not WAKE) until RT_FRIENDLY_WAKE)
+
+RT_VALID_SLEEP_REASON = FUTEX_WAIT
+                     or RT_FRIENDLY_NANOSLEEP
+
+RT_FRIENDLY_NANOSLEEP = CLOCK_NANOSLEEP
+                    and NANOSLEEP_TIMER_ABSTIME
+                    and (NANOSLEEP_CLOCK_MONOTONIC or NANOSLEEP_CLOCK_TAI)
+
+RT_FRIENDLY_WAKE = WOKEN_BY_EQUAL_OR_HIGHER_PRIO
+                or WOKEN_BY_HARDIRQ
+                or WOKEN_BY_NMI
+                or ABORT_SLEEP
+                or KTHREAD_SHOULD_STOP
+
+ALLOWLIST = BLOCK_ON_RT_MUTEX
+         or FUTEX_LOCK_PI
+         or TASK_IS_RCU
+         or TASK_IS_MIGRATION
-- 
2.47.2



